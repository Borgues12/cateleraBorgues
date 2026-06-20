# Progress

## Completado

- [x] Configurar dispositivo físico para debug USB
- [x] Prueba de concepto: contador con Riverpod + Freezed
- [x] Configurar tema visual global (paleta + tipografía)
- [x] Conectar Firebase al proyecto Flutter (CLI, autenticación, firebase_options.dart, inicialización en main.dart)
- [x] Fase 1 · Autenticación con Firebase Auth, manejo de estado con Riverpod, navegación condicional con go_router y persistencia de sesión
 [x] Feature `asistencias` · Domain layer: entidades `Asistencia` y `ConfiguracionHorarios`, interfaces de repositorio
- [x] Feature `asistencias` · Data layer: implementaciones Firestore (`dt_asistencias.dart`, `dt_horarios.dart`)
- [x] Feature `asistencias` · `core/utils/calcular_retraso.dart` como utilidad compartida
- [x] Feature `asistencias` · Providers Riverpod: consulta de asistencia del día, configuración de horarios y controlador de registro
- [x] Feature `asistencias` · Botón "Registrar llegada" con validación de una asistencia por día, cálculo de retraso y motivo obligatorio si hay tardanza
- [x] Feature `asistencias` · Colección `config/horarios` en Firestore con `horaSesion`, `limiteLlegada` y `minutosTolerancia`
- [x] Cloud Function `generarFaltasAutomaticas` · Revisión diaria de asistencias, generación automática de faltas para usuarios sin registro antes de la hora límite, lectura dinámica de usuarios desde Firebase Auth



## En progreso

## Pendiente
