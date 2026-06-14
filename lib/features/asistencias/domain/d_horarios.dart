import 'package:freezed_annotation/freezed_annotation.dart';

part 'd_horarios.freezed.dart';

@freezed
class ConfiguracionHorarios with _$ConfiguracionHorarios {
  const factory ConfiguracionHorarios({
    required String horaSesion,      // "20:30"
    required String limiteLlegada,   // "21:00"
    required int minutosTolerancia,  // 5
  }) = _ConfiguracionHorarios;
}