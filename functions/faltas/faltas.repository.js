// functions/faltas/faltas.repository.js

async function existeFalta(db, faltaId) {
  const doc = await db.collection("faltas").doc(faltaId).get();
  return doc.exists;
}

async function registrarFalta(db, faltaId, data) {
  await db.collection("faltas").doc(faltaId).set(data);
}

module.exports = { existeFalta, registrarFalta };