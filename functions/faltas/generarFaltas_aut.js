const {onSchedule} = require("firebase-functions/v2/scheduler");
const {getFirestore, Timestamp} = require("firebase-admin/firestore");
const {getAuth} = require("firebase-admin/auth");
// exportamos las funciones para comunicarse con la base
const {registrarFalta} = require("./faltas.repository");
const logger = require("firebase-functions/logger");

/**
 * Genera un identificador único para el documento basado en el ID de usuario y la fecha.
 * @param {string} userId - El identificador del usuario.
 * @param {Date} fecha - La fecha para el registro.
 * @return {string} El ID formateado como 'userId_AAAAMMDD'.
 */
function buildDocId(userId, fecha) {
  const y = fecha.getFullYear();
  const m = String(fecha.getMonth() + 1).padStart(2, "0");
  const d = String(fecha.getDate()).padStart(2, "0");
  return `${userId}_${y}${m}${d}`;
}

/**
 * Obtiene los UIDs de los usuarios que han verificado su correo electrónico.
 * @return {Promise<string[]>} Una lista con los UIDs de usuarios verificados.
 */
async function getUsuariosVerificados() {
  const result = await getAuth().listUsers(1000);
  return result.users
      .filter((user) => user.emailVerified)
      .map((user) => user.uid);
}

/**
 * Cloud Function programada que revisa diariamente las asistencias del día anterior
 * y genera faltas automáticas si detecta inasistencias o retrasos fuera de la tolerancia.
 */
exports.generarFaltasAutomaticas = onSchedule(
    {
      schedule: "every day 02:00",
      timeZone: "America/Guayaquil",
    },
    async () => {
      const db = getFirestore();

      // analizar los usuarios verificados
      const userIds = await getUsuariosVerificados();
      if (userIds.length === 0) {
        logger.error("No hay usuarios verificados en Authentication, abortando");
        return;
      }

      // Revisa el día anterior
      const ayer = new Date();
      ayer.setDate(ayer.getDate() - 1);
      ayer.setHours(0, 0, 0, 0);

      // TODO: cuando exista el modelo de grupos, la config de horarios
      // debe leerse por grupo, no globalmente desde config/horarios
      const configDoc = await db.collection("config").doc("horarios").get();
      if (!configDoc.exists) {
        logger.error("No existe config/horarios, abortando");
        return;
      }
      // pasa la informacion de manera formal al revisar que existe
      const config = configDoc.data();
      const minutosTolerancia = config.minutosTolerancia;

      for (const userId of userIds) {
      // busca si el usuario tenia una asistencia el dia de ayer
        const asistenciaId = buildDocId(userId, ayer);
        const asistenciaDoc = await db
            .collection("asistencias")
            .doc(asistenciaId)
            .get();

        let debeGenerarFalta = false;
        let motivoFalta = "";

        if (!asistenciaDoc.exists) {
          debeGenerarFalta = true;
          motivoFalta = "Inasistencia: no se registró llegada antes de la hora límite";
        } else {
          const data = asistenciaDoc.data();
          const minutosRetraso = data.minutosRetraso;

          if (minutosRetraso > minutosTolerancia) {
            debeGenerarFalta = true;
            motivoFalta = `Retraso de ${minutosRetraso} minutos (tolerancia: ${minutosTolerancia})`;
          }
        }

        // si debe generar falta, la genera
        if (debeGenerarFalta) {
          const faltaId = buildDocId(userId, ayer);
          await registrarFalta(db, faltaId, {
            id: faltaId,
            userId: userId,
            fecha: Timestamp.fromDate(ayer),
            motivo: motivoFalta,
            creadaEn: Timestamp.now(),
          });
          logger.info(`Falta generada para ${userId} el ${asistenciaId}`);
        }
      }
    },
);
