import 'package:freezed_annotation/freezed_annotation.dart';

part 'd_asistencias.freezed.dart';

@freezed
class Asistencia with _$Asistencia {
  const factory Asistencia({
    required String id,
    required String userId,
    required DateTime fecha, // solo año-mes-día, para validar 1 registro/día
    required DateTime horaLlegada,
    required int minutosRetraso,
    String? motivo, // obligatorio si hay retraso > tolerancia
  }) = _Asistencia;
}