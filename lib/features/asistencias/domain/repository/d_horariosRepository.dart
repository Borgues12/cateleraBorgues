import '../d_horarios.dart';

abstract class HorariosRepository {
  /// Obtiene la configuración vigente de horarios
  Future<ConfiguracionHorarios> getConfiguracionHorarios();
}