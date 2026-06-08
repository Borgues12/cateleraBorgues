# Plan de Desarrollo: App de Convivencia Audiovisual

## Filosofia del Plan

Este plan sigue un **enfoque iterativo MVP-driven**: primero se construyen versiones minimas funcionales de los 4 modulos para empezar a usar la app cuanto antes, y luego se refinan basandose en feedback real de uso.

**Regla central:** Cada fase tiene un criterio de cierre. No se avanza a la siguiente fase sin haber cumplido el criterio anterior.

---

## Resumen Visual del Plan

| Fase | Nombre | Duracion estimada | Tipo |
|------|--------|-------------------|------|
| 0 | Setup tecnico y fundamentos | 3-5 dias | Base |
| 1 | Esqueleto del proyecto | 2-3 dias | Base |
| 2 | Modulo Faltas - Ola 1 (MVP) | 4-5 dias | MVP |
| 3 | Modulo Peliculas - Ola 1 (MVP) | 4-5 dias | MVP |
| 4 | Modulo Series - Ola 1 (MVP) | 5-6 dias | MVP |
| 5 | Modulo Cine - Ola 1 (MVP) | 2 dias | MVP |
| **CHECKPOINT** | **Uso real durante 1-2 semanas** | **7-14 dias** | **Validacion** |
| 6+ | Olas 2 (refinamiento) | Variable | Refinamiento |

**Total estimado hasta primer uso real:** 3-4 semanas a ritmo intensivo, 6-8 semanas a ritmo de hobbyista.

---

## FASE 0: Setup Tecnico y Fundamentos

**Duracion estimada:** 3-5 dias

### Objetivo
Tener el entorno completamente funcional y entender el modelo mental de Flutter + Riverpod antes de escribir codigo de produccion.

### Tareas
1. Activar **Opciones de desarrollador** en celular Android (tocar 7 veces "Numero de compilacion" en Ajustes)
2. Activar **Depuracion USB** dentro de Opciones de desarrollador
3. Conectar el cable USB, aceptar la huella RSA
4. Verificar con `flutter devices` que el celular aparezca
5. Correr `flutter run` y ver la app en el celular
6. Probar **Hot Reload** modificando texto
7. Crear repo Git con `.gitignore` correcto para Flutter
8. Estudiar conceptos clave (no tutoriales largos, solo entender):
   - Arbol de widgets y reconstruccion
   - `StatelessWidget` vs `StatefulWidget` (cuando usar cada uno)
   - `BuildContext` y por que importa
   - Ciclo de vida de widgets (`initState`, `dispose`, `build`)
9. Instalar dependencias base:
   - `flutter_riverpod`
   - `freezed` + `json_serializable` (+ `build_runner` como dev_dependency)
   - `go_router`
   - `intl`

### Skills nuevas adquiridas
- Conexion fisica de dispositivo Android
- Flujo Hot Reload / Hot Restart
- Configuracion inicial de Riverpod
- Generacion de codigo con `build_runner`

### Criterio de Cierre
Una pantalla con un **contador funcionando con Riverpod** (no con `setState`) corriendo en tu celular, con repo Git inicializado y primer commit hecho.

---

## FASE 1: Esqueleto del Proyecto

**Duracion estimada:** 2-3 dias

### Objetivo
Dejar la estructura de carpetas, navegacion, theme y autenticacion basica listos antes de implementar logica de negocio.

### Tareas
1. Crear estructura Clean Architecture segun el contexto:
   ```
   lib/
   ├── core/
   ├── features/{faltas, peliculas, series, cine}/{data, domain, presentation}/
   ├── shared/
   └── main.dart
   ```
2. Configurar `theme.dart` con paleta de colores y tipografia global
3. Configurar `go_router` con rutas para las 4 pantallas de modulo
4. Crear pantalla `HomeScreen` con navegacion a los 4 modulos (pantallas vacias por ahora)
5. Crear proyecto Firebase en consola
6. Conectar FlutterFire CLI al proyecto
7. Habilitar Firebase Authentication (email/password)
8. Crear manualmente los 2 usuarios (Jose y Francis) en la consola
9. Pantalla de login basica
10. `AuthRepository` y `authProvider` con Riverpod
11. Logica de sesion persistente (si ya esta logueado, ir directo a Home)

### Skills nuevas adquiridas
- Navegacion declarativa con `go_router`
- Configuracion de Firebase en Flutter
- Repository Pattern aplicado a autenticacion
- Riverpod globales y persistencia de sesion

### Criterio de Cierre
Ambos usuarios pueden hacer login en sus dispositivos y navegar entre las 4 pantallas vacias desde la Home. Sesion persistente al cerrar y reabrir la app.

---

## FASE 2: Modulo Faltas - Ola 1 (MVP)

**Duracion estimada:** 4-5 dias

### Objetivo
Tener el modulo de faltas funcional al minimo para empezar a usarlo en la vida real.

### Funcionalidades Incluidas en el MVP
- Boton grande "Registrar llegada" con hora automatica
- Guardado en Firestore con hora exacta y usuario
- Contador simple de faltas por persona
- Lista de las ultimas 10 faltas con fecha, hora y minutos de retraso
- Calculo automatico de minutos de retraso vs 20:30

### Funcionalidades EXCLUIDAS del MVP (se postergan a Ola 2)
- Generacion automatica a las 21:00 via Cloud Functions
- Modal obligatorio de motivo en llegada tarde
- Logica de escalas (3, 5, 7 faltas con Carta de Ventaja, Botana, Inmunidad)
- Notificaciones push a las 20:25
- Filtros del historial
- Animaciones y UI pulida

### Tareas
1. Crear modelo `Falta` con `freezed` (id, fecha, persona, horaLlegada, minutosRetraso)
2. Crear `FaltasRepository` (interfaz en `domain/`, implementacion en `data/`)
3. Crear `FaltasFirestoreDatasource` que encapsula acceso a Firestore
4. Crear `faltasRepositoryProvider` y `faltasListProvider` con Riverpod
5. Centralizar reglas de tiempo en `ReglasContrato` (en `core/constants/`)
6. Implementar pantalla principal del modulo
7. Implementar pantalla de historial basico

### Skills nuevas adquiridas
- Modelos inmutables con Freezed
- Repository Pattern completo (interfaz + implementacion)
- Streams de Firestore con Riverpod
- Manejo de fechas y horas con `intl`

### Criterio de Cierre
Ambos pueden registrar llegada desde sus celulares, los datos se sincronizan en tiempo real entre ambos dispositivos, y el contador refleja correctamente las faltas acumuladas.

---

## FASE 3: Modulo Peliculas - Ola 1 (MVP)

**Duracion estimada:** 4-5 dias

### Objetivo
Tener integracion basica con TMDB y permitir registrar las propuestas semanales.

### Funcionalidades Incluidas en el MVP
- Registro en TMDB y obtencion de API key
- Pantalla de busqueda con TMDB API
- Resultados con poster, titulo, sinopsis, duracion y genero
- Cada usuario puede agregar sus 2 propuestas de la semana
- Pantalla "Propuestas de esta semana" mostrando las 4 peliculas

### Funcionalidades EXCLUIDAS del MVP
- Marcado manual de ganador/perdedor del sorteo
- Historial filtrable por mes/persona
- Logica visual de Carta de Ventaja
- Cache avanzado de imagenes
- Debounce optimizado en busqueda

### Tareas
1. Registro en TMDB y obtener API key
2. Configurar `TMDBService` con `dio` (interceptors para API key)
3. Crear modelo `Pelicula` con Freezed
4. Crear `PeliculasRepository` y `peliculasRepositoryProvider`
5. Pantalla de busqueda con resultados en lista
6. Card visual de pelicula
7. Pantalla "Propuestas de la semana" leyendo de Firestore
8. Logica simple de limite (max 2 propuestas por persona por semana)

### Skills nuevas adquiridas
- Consumo de APIs REST con Dio
- Interceptors HTTP
- Manejo de imagenes remotas
- Logica de negocio basada en fechas (semana actual)

### Criterio de Cierre
Ambos pueden buscar peliculas en TMDB, agregar sus 2 propuestas semanales, y ver las propuestas combinadas en la pantalla compartida.

---

## FASE 4: Modulo Series - Ola 1 (MVP)

**Duracion estimada:** 5-6 dias

### Objetivo
Permitir el registro de propuestas de series y el marcado manual del ganador, sin ruleta animada ni cronograma automatico.

### Funcionalidades Incluidas en el MVP
- Busqueda de series en TMDB
- Datos visibles: portada, sinopsis, numero de episodios, duracion promedio, genero
- Cada usuario propone 2 series (4 totales)
- Marcado manual de la serie ganadora del sorteo
- Lista de series en curso e historial basico

### Funcionalidades EXCLUIDAS del MVP
- Ruleta animada (queda para Ola 2)
- Calculo automatico del cronograma segun duracion de episodios
- Bloqueo de propuestas durante 3 dias de descanso
- Marcado de inicio/fin de temporada con estados complejos

### Tareas
1. Reutilizar `TMDBService` extendiendolo para endpoints de series
2. Crear modelo `Serie` con Freezed
3. Crear `SeriesRepository` y `seriesRepositoryProvider`
4. Pantalla de busqueda especifica para series
5. Card visual con datos relevantes (episodios, duracion promedio)
6. Pantalla "Propuestas de series" mostrando las 4
7. Boton manual "Marcar como ganadora" en cada propuesta
8. Lista basica de series finalizadas

### Skills nuevas adquiridas
- Reutilizacion de servicios HTTP entre features
- Modelado de entidades mas complejas
- Estados simples de entidad (propuesta / ganadora / finalizada)

### Criterio de Cierre
Ambos pueden proponer series, ver las 4 propuestas, marcar manualmente la ganadora, y consultar las series ya vistas.

---

## FASE 5: Modulo Cine - Ola 1 (MVP)

**Duracion estimada:** 2 dias

### Objetivo
El modulo mas simple. Programar una visita al cine y marcar asistencia.

### Funcionalidades Incluidas en el MVP
- Pantalla para programar una visita (fecha, pelicula opcional)
- Dos checkboxes: "Jose asistio" / "Francis asistio"
- Visualizacion del estado actual

### Funcionalidades EXCLUIDAS del MVP
- Penalizacion automatica si una parte no asiste
- Logica de aplazamiento si ambos acuerdan no ir
- Historial de visitas

### Tareas
1. Crear modelo `VisitaCine` con Freezed
2. Crear `CineRepository`
3. Pantalla con un formulario simple
4. Estado en Firestore

### Skills nuevas adquiridas
- Aplicacion rapida de patrones ya aprendidos
- Reutilizacion de estructura sin friccion

### Criterio de Cierre
Ambos pueden programar una visita y marcar quien asistio.

---

## CHECKPOINT CRITICO: USO REAL DE LA APP

**Duracion sugerida:** 7-14 dias

### Objetivo
Validar el MVP completo con uso real diario antes de invertir tiempo en refinamiento.

### Reglas durante el Checkpoint
- Ambos usuarios deben usar la app en su rutina diaria
- Anotar problemas, friccion, cosas que faltan, cosas que sobran
- NO programar nada nuevo durante este periodo (salvo bugs criticos que impidan el uso)

### Documento de Feedback
Llevar una lista compartida con:
1. **Bugs criticos** (impiden usar el modulo)
2. **Friccion de UX** (funciona pero incomoda)
3. **Funcionalidades urgentes** (extranas mucho su ausencia)
4. **Funcionalidades sobrantes** (estan pero no se usan)

### Criterio de Cierre
Lista de feedback consolidada y priorizada por ambos usuarios. Con esa lista se redefine el orden de las Olas 2.

---

## FASES 6+: Olas 2 (Refinamiento)

**Importante:** El orden de estas fases NO es fijo. Se decide segun el feedback del checkpoint, no segun el orden original del documento de requisitos.

A continuacion el alcance de cada Ola 2, en orden orientativo:

### Faltas - Ola 2
- Modal obligatorio de motivo en llegada tarde
- Logica de escalas (3, 5, 7 faltas)
- Banners visuales para Carta de Ventaja, Botana, Inmunidad
- Reinicio automatico del contador en 7 faltas
- Filtros de historial (por persona, por mes)
- **Cloud Function** programada a las 21:01 para generar faltas automaticas
- **FCM** notificaciones a las 20:25
- Deep linking desde notificacion a "Registrar llegada"

### Peliculas - Ola 2
- Marcado manual de ganador/perdedor del sorteo
- Logica visual de Carta de Ventaja
- Historial filtrable
- Cache de imagenes con `cached_network_image`
- Debounce en busqueda

### Series - Ola 2
- Ruleta visual animada (con `flutter_fortune_wheel` o `AnimationController` + `CustomPainter`)
- Algoritmo de cronograma segun reglas del contrato:
  - < 15 min: 4 episodios por sesion
  - 15-30 min: 2 episodios por sesion
  - > 40 min: 1 episodio por sesion
- Estados completos: propuestas → ruleta → ganadora → en curso → finalizada
- Bloqueo de propuestas durante 3 dias de descanso

### Cine - Ola 2
- Penalizacion automatica por inasistencia
- Logica de aplazamiento
- Historial de visitas

### Pulido General
- Refactorizacion de codigo debil de fases tempranas
- Tests unitarios de reglas criticas (faltas, cronograma de series)
- Manejo robusto de errores (sin internet, Firebase caido, TMDB caido)
- Animaciones de transicion
- Loading skeletons en vez de spinners genericos
- Modo oscuro

---

## FASE FINAL: Distribucion Interna

**Duracion estimada:** 2 dias

### Tareas
1. Firmar APK con keystore propio
2. Instalar APK firmado en ambos celulares (sin pasar por Play Store)
3. Redactar README en ingles para portafolio internacional
4. Capturar screenshots y GIFs del funcionamiento

### Criterio de Cierre
App instalada en ambos dispositivos como version definitiva v1.0, con repo publico/privado documentado.

---

## Reglas Operativas del Plan

1. **No saltar fases.** Aunque emocione una funcionalidad de una fase posterior, no se programa antes.
2. **Cada criterio de cierre es checkpoint.** Si no se cumple, se repite la fase.
3. **Commits semanticos desde el dia 1** (`feat:`, `fix:`, `refactor:`, `docs:`, `chore:`).
4. **Refactorizar al cerrar cada modulo**, no al final del proyecto.
5. **El checkpoint de uso real es obligatorio**, no opcional. Es donde se aprende mas del proyecto.
6. **El orden de las Olas 2 lo decide el feedback**, no el orden de este documento.