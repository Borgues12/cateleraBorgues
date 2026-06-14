/// Calcula los minutos de retraso comparando una hora dada (`momento`)
/// contra la hora esperada (`horaEsperada`, formato "HH:mm").
///
/// Retorna 0 si llegó a tiempo o antes; un valor positivo si llegó tarde.
int calcularRetraso(DateTime momento, String horaEsperada) {
  final partes = horaEsperada.split(':');
  final esperada = DateTime(
    momento.year,
    momento.month,
    momento.day,
    int.parse(partes[0]),
    int.parse(partes[1]),
  );

  final diferencia = momento.difference(esperada).inMinutes;
  return diferencia > 0 ? diferencia : 0;
}