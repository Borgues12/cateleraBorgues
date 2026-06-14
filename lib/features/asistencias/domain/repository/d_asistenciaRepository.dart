import '../d_asistencias.dart';

abstract class AsistenciaRepository {
  /// Verifica si el usuario ya registró asistencia hoy
  Future<Asistencia?> getAsistenciaHoy(String userId);

  /// Registra una nueva asistencia
  Future<void> newAsistencia(Asistencia asistencia);
}