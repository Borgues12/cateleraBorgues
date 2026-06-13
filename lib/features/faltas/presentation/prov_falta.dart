import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/dt_faltas.dart';
import '../domain/d_faltasRepository.dart';

//devuelve una instancia de FirebaseFirestore, que es la clase principal 
//para interactuar con Firestore en Flutter.
final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

//devuelve una instancia de FaltasRepository, 
//que es la interfaz para gestionar las faltas.
final faltasRepositoryProvider = Provider<FaltasRepository>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return FirestoreFaltasRepository(firestore);
});