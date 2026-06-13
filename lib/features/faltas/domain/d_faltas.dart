import 'package:freezed_annotation/freezed_annotation.dart';

//parte de otro archivo
part 'd_faltas.freezed.dart';
part 'd_faltas.g.dart';


//Definición de la clase Falta utilizando freezed
//
@freezed
class Falta with _$Falta {
  //Utilizamos un constructor de fábrica para crear instancias de Falta inmutables
  const factory Falta({
    required String id,
    required String userId,
    required DateTime fecha,
    DateTime? horaLlegada,
    required int minutosRetraso,
    String? motivo,
    required DateTime creadaEn,
  }) = _Falta;

  // Metodo que sirve como traductor entre el formato JSON y la clase Falta, 
  //permitiendo la serialización y deserialización de objetos Falta
  factory Falta.fromJson(Map<String, Object?> json) => _$FaltaFromJson(json);
}