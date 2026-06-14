import 'package:cloud_firestore/cloud_firestore.dart';
import '../domain/d_asistencias.dart';
import '../domain/repository/d_asistenciaRepository.dart';

class AsistenciaRepositoryImpl implements AsistenciaRepository {
  //instacia con Firestore
  final FirebaseFirestore _firestore;
  AsistenciaRepositoryImpl(this._firestore);

// Referencia a la colección de asistencias en Firestore
  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('asistencias');

  /// id de documento = "userId_yyyyMMdd" para forzar unicidad por día
  String _buildDocId(String userId, DateTime fecha) {
    final f =
        '${fecha.year}${fecha.month.toString().padLeft(2, '0')}${fecha.day.toString().padLeft(2, '0')}';
    return '${userId}_$f';
  }

  /// Mapea un documento de Firestore a la entidad de dominio
  Asistencia _fromFirestore(String docId, Map<String, dynamic> data) {
    return Asistencia(
      id: docId,
      userId: data['userId'] as String,
      fecha: (data['fecha'] as Timestamp).toDate(),
      horaLlegada: (data['horaLlegada'] as Timestamp).toDate(),
      minutosRetraso: data['minutosRetraso'] as int,
      motivo: data['motivo'] as String?,
    );
  }

  /// Mapea la entidad de dominio al formato de Firestore
  Map<String, dynamic> _toFirestore(Asistencia asistencia) {
    return {
      'userId': asistencia.userId,
      'fecha': Timestamp.fromDate(asistencia.fecha),
      'horaLlegada': Timestamp.fromDate(asistencia.horaLlegada),
      'minutosRetraso': asistencia.minutosRetraso,
      'motivo': asistencia.motivo,
    };
  }

#region metodos de la interfaz
  @override
  Future<Asistencia?> getAsistenciaHoy(String userId) async {
    final hoy = DateTime.now();
    final docId = _buildDocId(userId, hoy);
    final doc = await _collection.doc(docId).get();

    if (!doc.exists) return null;

    return _fromFirestore(doc.id, doc.data()!);
  }

  @override
  Future<void> registrarAsistencia(Asistencia asistencia) async {
    final docId = _buildDocId(asistencia.userId, asistencia.fecha);
    await _collection.doc(docId).set(_toFirestore(asistencia));
  }
  #endregion
}
