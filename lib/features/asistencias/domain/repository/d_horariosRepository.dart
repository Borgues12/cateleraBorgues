import '../d_horarios.dart';

abstract class ConfigRepository {
  /// Obtiene la configuración vigente de horarios
  Future<ConfiguracionHorarios> getConfiguracionHorarios();
}