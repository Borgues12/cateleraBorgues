import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_convivencia/features/counter_notifier.dart';

final counterProvider = StateNotifierProvider<CounterNotifier, int>(
  (ref) => CounterNotifier(),
);