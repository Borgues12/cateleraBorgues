import 'package:cloud_firestore/cloud_firestore.dart';
import '../domain/d_faltas.dart';
import '../domain/d_faltasRepository.dart';

class FirestoreFaltasRepository implements FaltasRepository {

  //Instancia de firebase firestore para interactuar con la base de datos.
  final FirebaseFirestore _firestore;

  //Constructor que recibe una instancia de FirebaseFirestore.
  FirestoreFaltasRepository(this._firestore);

//crear o editar una falta en la colección 'faltas' de Firestore utilizando el 
//método set, que sobrescribe el documento si ya existe o lo crea si no existe.
  @override
  Future<void> registrarFalta(Falta falta) async {
    await _firestore
        .collection('faltas')
        .doc(falta.id)
        .set(falta.toJson());
  }

  @override
  Future<List<Falta>> obtenerFaltas() async {
    final snapshot = await _firestore
        .collection('faltas')
        .orderBy('creadaEn', descending: true)
        .get();

//transformamos los documentos obtenidos de Firestore 
//en una lista de objetos Falta utilizando el método fromJson 
//para cada documento.
    return snapshot.docs
        .map((doc) => Falta.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<List<Falta>> obtenerFaltasPorUsuario(String userId) async {
    final snapshot = await _firestore
        .collection('faltas')
        .where('userId', isEqualTo: userId)
        .orderBy('creadaEn', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => Falta.fromJson(doc.data()))
        .toList();
  }
}