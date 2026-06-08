import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_convivencia/features/presentation/screens/scr_counter.dart';
import 'package:app_convivencia/core/theme/theme.dart'; //estilos

void main() {
  // Asegurarse de que Flutter esté completamente inicializado antes de ejecutar la app
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      child: MaterialApp(
        // Deshabilitar banner de debug
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: CounterScreen(),
      ),
    ),
  );
}