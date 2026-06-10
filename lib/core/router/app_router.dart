import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/domain/auth_state.dart';
import '../../features/auth/presentation/prov_auth.dart';
import '../../features/auth/presentation/scr_login.dart';
import '../../core/theme/theme.dart';

// Pantalla temporal hasta construir el home real
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenido',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => ref.read(authNotifierProvider.notifier).signOut(),
              child: Text(
                'CERRAR SESIÓN',
                style: AppTextStyles.labelLarge().copyWith(letterSpacing: 4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Configuración de rutas con GoRouter, redirigiendo según el estado de autenticación
final routerProvider = Provider<GoRouter>((ref) {
  final authAsync = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggedIn = authAsync.valueOrNull?.maybeMap(
            authenticated: (_) => true,
            orElse: () => false,
          ) ?? false;
      final isOnLogin = state.matchedLocation == '/login';

      if (!isLoggedIn && !isOnLogin) return '/login';
      if (isLoggedIn && isOnLogin) return '/home';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
});