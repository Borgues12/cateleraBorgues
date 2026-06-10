import 'package:firebase_auth/firebase_auth.dart';
import '../domain/auth_state.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Escucha cambios de sesión en tiempo real
  Stream<AuthState> get authStateChanges {
    return _auth.authStateChanges().map((user) {
      if (user != null) return AuthState.authenticated(user);
      return const AuthState.unauthenticated();
    });
  }

  // Iniciar sesión
  Future<AuthState> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthState.authenticated(credential.user!);
    } on FirebaseAuthException catch (e) {
      return AuthState.error(_mapError(e.code));
    }
  }

  // Cerrar sesión
  Future<void> signOut() => _auth.signOut();

  // Traduce códigos de Firebase a mensajes legibles
  String _mapError(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No existe una cuenta con ese correo.';
      case 'wrong-password':
        return 'Contraseña incorrecta.';
      case 'invalid-credential':
        return 'Correo o contraseña incorrectos.';
      case 'too-many-requests':
        return 'Demasiados intentos. Intenta más tarde.';
      default:
        return 'Error inesperado. Intenta de nuevo.';
    }
  }
}