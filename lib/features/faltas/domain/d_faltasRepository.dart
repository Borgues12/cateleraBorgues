import 'd_faltas.dart';

//Definición de la interfaz del repositorio de faltas, 
//que establece los métodos que deben implementarse para gestionar las faltas
abstract class FaltasRepository {
  Future<void> registrarFalta(Falta falta);
  Future<List<Falta>> obtenerFaltas();
  Future<List<Falta>> obtenerFaltasPorUsuario(String userId);
}