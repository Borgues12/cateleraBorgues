const { onSchedule } = require("firebase-functions/v2/scheduler");
const { getFirestore, Timestamp } = require("firebase-admin/firestore");
const { getAuth } = require("firebase-admin/auth");
//exportamos las funciones para comunicarse con la base
const { registrarFalta } = require("./faltas.repository");

//obtener id de documento para subirlo a la coleccion
function buildDocId(userId, fecha) {
  const y = fecha.getFullYear();
  const m = String(fecha.getMonth() + 1).padStart(2, "0");
  const d = String(fecha.getDate()).padStart(2, "0");
  return `${userId}_${y}${m}${d}`;
}

/// Obtiene los UIDs de usuarios verificados (paginado, hasta 1000)
async function getUsuariosVerificados() {
  const result = await getAuth().listUsers(1000);
  return result.users
    .filter((user) => user.emailVerified)
    .map((user) => user.uid);
}

/// Genera faltas automaticas
exports.generarFaltasAutomaticas = onSchedule(
  {
    schedule: "every day 02:00",
    timeZone: "America/Guayaquil",
  },
  async () => {
    const db = getFirestore();

    //analizar los usuarios verificados
    const userIds = await getUsuariosVerificados();
    if (userIds.length === 0) {
      console.error("No hay usuarios verificados en Authentication, abortando");
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
      console.error("No existe config/horarios, abortando");
      return;
    }
    //pasa la informacion de manera formal al revisar que existe
    const config = configDoc.data();
    const minutosTolerancia = config.minutosTolerancia;

    for (const userId of userIds) {
      //busca si el usuario tenia una asistencia el dia de ayer
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

      if (debeGenerarFalta) {
        const faltaId = buildDocId(userId, ayer);

       if (debeGenerarFalta) {
        const faltaId = buildDocId(userId, ayer);
        await registrarFalta(db, faltaId, {
          userId,
          fecha: Timestamp.fromDate(ayer),
          motivo: motivoFalta,
          generadaPorSistema: true,
          creadaEn: Timestamp.now(),
        });
        console.log(`Falta generada para ${userId} el ${asistenciaId}`);
      }

        console.log(`Falta generada para ${userId} el ${asistenciaId}`);
      }
    }
  }
);