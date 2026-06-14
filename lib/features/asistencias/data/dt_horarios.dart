import 'package:cloud_firestore/cloud_firestore.dart';
import '../domain/d_horarios.dart';
import '../domain/repository/d_horariosRepository.dart';

class HorariosRepositoryImpl implements HorariosRepository {
  final FirebaseFirestore _firestore;

  HorariosRepositoryImpl(this._firestore);

  @override
  Future<ConfiguracionHorarios> getConfiguracionHorarios() async {
    final doc = await _firestore.collection('config').doc('horarios').get();

    if (!doc.exists) {
      throw Exception('Configuración de horarios no encontrada en Firestore');
    }

    final data = doc.data()!;
    return ConfiguracionHorarios(
      horaSesion: data['horaSesion'] as String,
      limiteLlegada: data['limiteLlegada'] as String,
      minutosTolerancia: data['minutosTolerancia'] as int,
    );
  }
}