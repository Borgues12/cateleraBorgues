/**
 * Verifica si ya existe un registro de falta con el identificador proporcionado.
 * @param {object} db - Instancia de la base de datos Firestore.
 * @param {string} faltaId - El identificador único del documento de la falta.
 * @return {Promise<boolean>} Una promesa que se resuelve con true si la falta existe, o false si no.
 */
async function existeFalta(db, faltaId) {
  const doc = await db.collection("faltas").doc(faltaId).get();
  return doc.exists;
}

/**
 * Registra o sobreescribe los datos de una falta en la colección correspondiente.
 * @param {object} db - Instancia de la base de datos Firestore.
 * @param {string} faltaId - El identificador único del documento de la falta.
 * @param {object} data - Los campos y valores que se van a guardar en el documento.
 * @return {Promise<void>} Una promesa que se resuelve cuando el documento ha sido guardado.
 */
async function registrarFalta(db, faltaId, data) {
  await db.collection("faltas").doc(faltaId).set(data);
}

module.exports = {existeFalta, registrarFalta};
