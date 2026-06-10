import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_state.freezed.dart';

//freezed: es una librería de Dart que facilita la creación de clases inmutables y selladas (sealed classes)
// con un enfoque en la seguridad de tipos y la facilidad de uso. Permite definir estados de manera concisa y clara, 
//lo que es especialmente útil en la gestión de estados en aplicaciones Flutter.
@freezed
class AuthState with _$AuthState {
  //estado inicial
  const factory AuthState.initial() = _Initial;
  //estado de carga
  const factory AuthState.loading() = _Loading;
  //estado autenticado con un usuario
  const factory AuthState.authenticated(User user) = _Authenticated;
  //estado no autenticado
  const factory AuthState.unauthenticated() = _Unauthenticated;
  //estado de error con un mensaje
  const factory AuthState.error(String message) = _Error;
}