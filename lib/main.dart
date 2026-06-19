import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart'; //configuración de Firebase
import 'firebase_options.dart'; //configuración de Firebase
import 'package:app_convivencia/core/theme/theme.dart'; //estilos
//router para navegación entre pantallas
import 'core/router/app_router.dart';

//test
import 'package:app_convivencia/features/asistencias/presentation/scr_registrarLlegada.dart';

void main() {
  runApp(
    // Riverpod requiere un ProviderScope en la raíz para manejar el estado
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Convivencia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control de Convivencia'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '¡Bienvenido!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Registra tu asistencia diaria a continuación:',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),
              
              // Aquí incrustamos tu botón real mapeado con tu ID de desarrollo
              const RegistrarLlegadaButton(userId: 'jose'),
            ],
          ),
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
