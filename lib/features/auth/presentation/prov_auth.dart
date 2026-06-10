import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/dt_auth.dart';
import '../domain/auth_state.dart';

// Instancia única del repositorio
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(),
);

// Escucha el stream de Firebase en tiempo real
final authStateProvider = StreamProvider<AuthState>(
  (ref) => ref.watch(authRepositoryProvider).authStateChanges,
);

// Maneja el login/logout desde los widgets
class AuthNotifier extends AsyncNotifier<AuthState> {
  @override
  Future<AuthState> build() async => const AuthState.initial();

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.signIn(email, password);
    state = AsyncValue.data(result);
  }

  Future<void> signOut() async {
    final repo = ref.read(authRepositoryProvider);
    await repo.signOut();
    state = const AsyncValue.data(AuthState.unauthenticated());
  }
}

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);