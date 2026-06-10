import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart'; //configuración de Firebase
import 'firebase_options.dart'; //configuración de Firebase
import 'package:app_convivencia/core/theme/theme.dart'; //estilos
//router para navegación entre pantallas
import 'core/router/app_router.dart';



void main() async {
  // Asegurarse de que Flutter esté completamente inicializado antes de ejecutar la app
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializar Firebase con la configuración específica para cada plataforma
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      child: AppRouter(),
    ),
  );
}

class AppRouter extends ConsumerWidget {
  const AppRouter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      routerConfig: router,
    );
  }
}
