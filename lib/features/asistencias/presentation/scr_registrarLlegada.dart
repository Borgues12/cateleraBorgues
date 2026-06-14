import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_convivencia/core/utils/calcular_retraso.dart'; //utils
import '../providers/p_asistencias.dart';

class RegistrarLlegadaButton extends ConsumerWidget {
  final String userId;

  const RegistrarLlegadaButton({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //providers
    final asistenciaHoy = ref.watch(asistenciaHoyProvider(userId));
    final horarios = ref.watch(configuracionHorariosProvider);
    final controllerState = ref.watch(registrarLlegadaControllerProvider);

    return asistenciaHoy.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Text('Error: $e'),
      data: (asistencia) {
        if (asistencia != null) {
          return Text(
            'Llegada registrada a las '
            '${asistencia.horaLlegada.hour.toString().padLeft(2, '0')}:'
            '${asistencia.horaLlegada.minute.toString().padLeft(2, '0')}',
          );
        }

        return ElevatedButton(
          //muestrar un loading mientras se registra la llegada para evitar múltiples taps
          onPressed: controllerState.isLoading
              ? null
              : () => _onRegistrar(context, ref, horarios),
              // Si ya se está registrando, deshabilitar el botón para evitar múltiples taps
          child: controllerState.isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Registrar llegada'),
        );
      },
    );
  }

  Future<void> _onRegistrar(
    BuildContext context,
    WidgetRef ref,
    AsyncValue horarios,
  ) async {
    final ahora = DateTime.now();
    final config = horarios.value;

    String? motivo;

    // Si hay config y el retraso supera la tolerancia, pedir motivo
    if (config != null) {
      final retraso = calcularRetraso(ahora, config.horaSesion);

      if (retraso > config.minutosTolerancia) {
        motivo = await _pedirMotivo(context);
        if (motivo == null || motivo.trim().isEmpty) {
          return; // cancelado o vacío, no se registra
        }
      }
    }

    await ref
        .read(registrarLlegadaControllerProvider.notifier)
        .registrar(userId: userId, motivo: motivo);
  }

  Future<String?> _pedirMotivo(BuildContext context) {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Llegada tardía'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Motivo breve...'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, controller.text),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}