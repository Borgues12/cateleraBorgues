import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_convivencia/core/utils/calcular_retraso.dart'; //utils
import '../domain/d_asistencias.dart';
import '../domain/d_horarios.dart';
import '../domain/repository/d_asistenciaRepository.dart';
import '../domain/repository/d_horariosRepository.dart';
import '../data/dt_asistencias.dart';
import '../data/dt_horarios.dart';


/// Provider del repositorio de asistencias
final asistenciaRepositoryProvider = Provider<AsistenciaRepository>((ref) {
  return AsistenciaRepositoryImpl(FirebaseFirestore.instance);
});

/// Provider del repositorio de horarios/config
final horariosRepositoryProvider = Provider<HorariosRepository>((ref) {
  return HorariosRepositoryImpl(FirebaseFirestore.instance);
});

/// Obtiene la configuración vigente de horarios desde Firestore
final configuracionHorariosProvider =
    FutureProvider<ConfiguracionHorarios>((ref) async {
  final repo = ref.watch(horariosRepositoryProvider);
  return repo.getConfiguracionHorarios();
});

/// Verifica si el usuario ya registró asistencia hoy
final asistenciaHoyProvider =
    FutureProvider.family<Asistencia?, String>((ref, userId) async {
  final repo = ref.watch(asistenciaRepositoryProvider);
  return repo.getAsistenciaHoy(userId);
});

/// Controlador que ejecuta el registro de llegada
/// con el formato de la collecion "asistencias" y la lógica de cálculo de retraso
class RegistrarLlegadaController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> registrar({
    required String userId,
    String? motivo,
  }) async {
    state = const AsyncLoading();

    try {
      final asistenciaRepo = ref.read(asistenciaRepositoryProvider);
      final horarios = await ref.read(configuracionHorariosProvider.future);

      final ahora = DateTime.now();
      final minutosRetraso = calcularRetraso(ahora, horarios.horaSesion);

      final asistencia = Asistencia(
        id: '', // se ignora, el repo genera el id por userId+fecha
        userId: userId,
        fecha: DateTime(ahora.year, ahora.month, ahora.day),
        horaLlegada: ahora,
        minutosRetraso: minutosRetraso,
        motivo: motivo,
      );

      await asistenciaRepo.newAsistencia(asistencia);

      // Invalida el cache para refrescar el estado "ya registró hoy"
      ref.invalidate(asistenciaHoyProvider);

      state = const AsyncData(null); // éxito sin valor de retorno
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

// Provider para el controlador de registrar llegada, que maneja la lógica de negocio y el estado de carga/error durante el proceso de registro.
final registrarLlegadaControllerProvider =
    AsyncNotifierProvider<RegistrarLlegadaController, void>(
  () => RegistrarLlegadaController(),
);