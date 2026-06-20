import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//importanciones externas
import '../../auth/presentation/prov_auth.dart';
import '../../auth/domain/auth_state.dart';
import '../../asistencias/presentation/widgets/wgt_registrarLlegada.dart';



class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

// Obtenemos el estado de autenticación para mostrar información relevante o permitir acciones como cerrar sesión
    final authState = ref.watch(authStateProvider);

// Extraemos el ID del usuario autenticado para mostrarlo o usarlo en otras partes de la UI solo cuando el usuario esté autenticado, evitando errores si el estado no es el esperado
    final userId = authState.valueOrNull?.maybeMap(
      authenticated: (state) => state.user.uid,
      orElse: () => 'Desconocido',
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenido',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 16),

            if(userId != null)
              RegistrarLlegadaButton(userId: userId),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(authNotifierProvider.notifier).signOut(),
              child: Text(
                'CERRAR SESIÓN',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}