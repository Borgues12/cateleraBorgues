import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart'; //configuración de Firebase
import 'firebase_options.dart'; //configuración de Firebase
import 'package:app_convivencia/core/theme/theme.dart'; //estilos
//router para navegación entre pantallas
import 'core/router/app_router.dart';

//test
import 'features/faltas/presentation/prov_falta.dart';
import 'features/faltas/domain/d_faltas.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestFaltasScreen(),
    );
  }
}

class TestFaltasScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(faltasRepositoryProvider);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final falta = Falta(
              id: 'test-001',
              userId: 'jose',
              fecha: DateTime.now(),
              horaLlegada: DateTime.now(),
              minutosRetraso: 10,
              motivo: 'Prueba de escritura',
              creadaEn: DateTime.now(),
            );

            await repo.registrarFalta(falta);

            final faltas = await repo.obtenerFaltasPorUsuario('jose');
            for (final f in faltas) {
              debugPrint('Falta encontrada: ${f.id} - ${f.motivo}');
            }
          },
          child: const Text('Registrar falta de prueba'),
        ),
      ),
    );
  }
}

// void main() async {
//   // Asegurarse de que Flutter esté completamente inicializado antes de ejecutar la app
//   WidgetsFlutterBinding.ensureInitialized();
//   // Inicializar Firebase con la configuración específica para cada plataforma
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(
//     ProviderScope(
//       child: AppRouter(),
//     ),
//   );
// }

// class AppRouter extends ConsumerWidget {
//   const AppRouter({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final router = ref.watch(routerProvider);

//     return MaterialApp.router(
//       debugShowCheckedModeBanner: false,
//       theme: AppTheme.theme,
//       routerConfig: router,
//     );
//   }
// }
