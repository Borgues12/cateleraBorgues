import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_convivencia/features/presentation/screens/scr_counter.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: CounterScreen(),
      ),
    ),
  );
}