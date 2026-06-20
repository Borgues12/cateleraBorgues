import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart'; //configuración de Firebase
import 'firebase_options.dart'; //configuración de Firebase
import 'package:app_convivencia/core/theme/theme.dart'; //estilos
//router para navegación entre pantallas
import 'core/router/app_router.dart';

import 'firebase_options.dart'; // 2. IMPORTANTE: Importa tus opciones generadas por FlutterFire


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    // Riverpod requiere un ProviderScope en la raíz para manejar el estado
    const ProviderScope(
      child: AppRoot(),
    ),
  );
}

class AppRoot extends ConsumerWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider); // Obtenemos la configuración de rutas desde el provider
    return MaterialApp.router(
      title: 'App Convivencia',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      routerConfig: router //ahora se encarga el enrutador de mostrar la pantalla correcta según el estado de autenticación
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Control de Convivencia'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 '¡Bienvenido!',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 'Registra tu asistencia diaria a continuación:',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.grey),
//               ),
//               const SizedBox(height: 32),
              
//               // Aquí incrustamos tu botón real mapeado con tu ID de desarrollo para prueba
//               RegistrarLlegadaButton(
//                 userId: 'goI8YvNg3nNGE8txjgtzDpOsznM2',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

