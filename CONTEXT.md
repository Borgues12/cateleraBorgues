# Requisitos del Proyecto: App de Convivencia Audiovisual

## Contexto

Aplicacion movil de uso privado entre dos personas (Jose Gallardo y Francis Gallardo) para gestionar y registrar las actividades establecidas en su Acuerdo de Convivencia Audiovisual. El proyecto tiene como proposito principal la practica de desarrollo con Flutter.

---

## Stack Tecnologico

- **Frontend**: Flutter (Android)
- **Backend**: Firebase (Firestore, Authentication, Cloud Functions)
- **Notificaciones**: Firebase Cloud Messaging
- **API externa**: TMDB API (busqueda de peliculas y series)

---

## Tema Visual Global

### Filosofía de Diseño
Estilo Art Decó clásico inspirado en la estética de cartelera de festival cinematográfico.
Atmósfera de cine de época: marquesinas, ornamentos geométricos, tipografía editorial.
Los bordes decorativos en L y los separadores con diamante central son los elementos
visuales recurrentes que dan cohesión entre módulos. Todo construido con primitivas
nativas, sin imágenes ni assets externos.

---

### Paleta de Colores

| Token            | Hex       | Descripción                                                  |
|------------------|-----------|--------------------------------------------------------------|
| `colorBg`        | `#292824` | Fondo principal. Base oscura y cálida de toda la interfaz    |
| `colorSurface`   | `#64584a` | Superficies elevadas sobre el fondo: tarjetas y relieves     |
| `colorMuted`     | `#a29783` | Información secundaria, etiquetas, elementos inactivos       |
| `colorGold`      | `#d5b880` | Acento primario: títulos, acciones, ornamentos y bordes clave|
| `colorCrimson`   | `#934538` | Exclusivamente semántico: faltas, alertas y penalizaciones   |

`colorGold` es el único color de acento interactivo de la app.
`colorCrimson` nunca se usa con intención decorativa.

---

### Tipografía

| Familia              | Variante           | Rol                                                             |
|----------------------|--------------------|-----------------------------------------------------------------|
| `Playfair Display`   | Bold / Black       | Títulos de pantalla y números prominentes (horas, contadores)   |
| `Cormorant Garamond` | Light Italic / 400 | Subtítulos, notas de apoyo y texto secundario de tono literario |
| `Josefin Sans`       | Ultralight / 300   | Etiquetas funcionales, navegación y badges — siempre en mayúsculas con espaciado amplio |

`Playfair Display` y `Cormorant Garamond` son tipografías de display: aparecen en
jerarquías altas y textos de lectura. `Josefin Sans` cubre todo lo funcional y navegacional.

---

### Ornamentos Visuales

- **Esquinas en L** — bordes parciales en dos lados que enmarcan secciones y tarjetas
- **Separador con diamante** — figura romboidal central entre dos líneas horizontales, usado como divisor entre bloques de contenido
- **Bordes de tarjeta** — línea delgada en `colorGold` con baja opacidad
- **Radio de esquina mínimo** — el estilo Art Decó evita bordes redondeados; se usan ángulos rectos o radios casi imperceptibles

---

## Usuarios

Dos usuarios fijos con roles simetricos:
- Jose Gallardo
- Francis Gallardo

Ambos acceden desde sus propios dispositivos. No hay registro publico ni nuevos usuarios.

---

## Reglas de Negocio Generales

- El horario habitual de sesion es a las 20:30
- El limite maximo para iniciar una sesion es las 21:00
- Si no se registra llegada antes de las 21:00, se genera una falta automatica al dia siguiente
- Una sesion no iniciada antes de las 21:00 se declara perdida, sin recuperacion, salvo fuerza mayor acordada manualmente por ambas partes
- Retraso mayor a 5 minutos equivale a una falta
- Inasistencia sin aviso con al menos 1 hora de anticipacion, si no aparece en 15 minutos, genera una falta agravada adicional

---

## Modulo 1: Faltas

### Funcionalidades
- Boton de "registrar llegada" con hora automatica del sistema
- Al registrar llegada tarde (mas de 5 minutos despues de las 20:30), se solicita un motivo corto obligatorio
- Si no se registra llegada antes de las 21:00, la falta se genera automaticamente via Cloud Functions al dia siguiente
- Contador de faltas visible por persona
- Historial de faltas con: fecha, hora de llegada, minutos de retraso y motivo

### Escala de penalizaciones
- 3 faltas: se marca visualmente la Carta de Ventaja como disponible para el proximo lunes de seleccion de peliculas. Se elimina automaticamente al finalizar ese dia, se haya usado o no
- 5 faltas: se muestra alerta de que la parte infractora debe entregar una botana o dulce de maximo $1.00
- 7 faltas: se muestra alerta de Beneficio de Inmunidad para el proximo sorteo de series. El contador se reinicia a cero

### Notificaciones
- Notificacion a las 20:25 recordando el inicio de sesion a ambos usuarios

---

## Modulo 2: Peliculas

### Funcionalidades
- Busqueda de peliculas mediante TMDB API (portada, sinopsis, duracion, genero)
- Cada parte registra sus 2 propuestas para la semana
- Ganador y perdedor del sorteo se marcan manualmente despues del sorteo fisico con cartas
- Si una parte tiene Carta de Ventaja activa, se muestra visualmente como item disponible en la pantalla de seleccion semanal
- Historial de peliculas con: titulo, quien la propuso, si gano o perdio el sorteo y fecha de visualizacion

### Notas
- El sorteo fisico se realiza con cartas reales, la app no lo simula
- La Carta de Ventaja es solo visual, no es interactiva mas alla de mostrarse y eliminarse automaticamente

---

## Modulo 3: Series

### Funcionalidades
- Busqueda de series mediante TMDB API (portada, sinopsis, numero de episodios, duracion promedio por episodio, genero)
- Cada parte propone 2 series para el sorteo
- Ruleta visual dentro de la app para el sorteo entre las 4 series propuestas
- Al seleccionar una serie ganadora, la app calcula un cronograma aproximado basado en:
  - Numero de episodios de la temporada
  - Duracion promedio por episodio
  - Reglas del contrato segun tipo de episodio (corto, medio, largo)
- Marcado manual de inicio y fin de temporada
- Durante los 3 dias de descanso entre temporadas, la opcion de proponer nuevas series permanece bloqueada
- Historial de series con temporada, fechas y quien la propuso

### Reglas de calculo del cronograma
- Episodios menores a 15 minutos: 4 episodios por sesion
- Episodios entre 15 y 30 minutos: 2 episodios por sesion
- Episodios mayores a 40 minutos: 1 episodio por sesion

### Notas
- El duelo de dados se realiza de manera fisica, la app no lo simula
- Solo se usa la ruleta virtual para el sorteo final

---

## Modulo 4: Cine (simple, no prioritario)

### Funcionalidades
- Registro de visita programada al cine
- Marcar asistencia por persona
- Si una parte no asistio, se registra penalizacion automatica (dulce o presente de maximo $1.00)
- Si ambas partes acuerdan no ir, se registra el aplazamiento a la semana siguiente

---

## Prioridad de Desarrollo

1. Modulo de Faltas (logica central y notificaciones)
2. Modulo de Peliculas (con integracion TMDB)
3. Modulo de Series (con ruleta y cronograma)
4. Modulo de Cine

---

## Funcionalidades Descartadas (posibles actualizaciones futuras)

- Simulador de dados
- Sorteo de cartas digital
- Registro de canciones por ronda musical
- Estadisticas y metricas de uso
- Control detallado de temporadas y dias restantes

---

## Decisiones Tecnicas (Cerradas)

### Manejo de Estado
- **Riverpod** como unica solucion de manejo de estado en todo el proyecto
- Razones: moderno, seguro en tiempo de compilacion, estandar actual de la industria Flutter
- No mezclar con `setState` salvo para estado puramente local de un widget (ej: controlador de un input)

### Arquitectura
- **Clean Architecture simplificada** con 3 capas por feature: `data`, `domain`, `presentation`
- Organizacion por **features** (carpeta por modulo), no por tipo de archivo
- Cada feature es independiente y autocontenida

### Patron de Acceso a Datos
- **Repository Pattern obligatorio** para todo acceso a Firestore, APIs externas o cualquier fuente de datos
- Los widgets nunca acceden directamente a Firestore ni hacen llamadas HTTP
- Cada feature expone repositorios a traves de providers de Riverpod
- Los datasources (Firestore, TMDB) se encapsulan dentro de los repositorios

### Estructura de Firestore
- Colecciones planas por dominio: `users/`, `faltas/`, `peliculas/`, `series/`, `cine/`, `config/`
- Sin anidaciones profundas para facilitar consultas y mejorar rendimiento

### Estructura de Carpetas
```
lib/
├── core/
│   ├── constants/         (horarios, reglas del contrato)
│   ├── theme/             (colores, fuentes globales)
│   ├── utils/             (helpers de fecha, validaciones)
│   └── errors/            (excepciones personalizadas)
├── features/
│   ├── faltas/
│   │   ├── data/          (repositorios, fuentes de datos)
│   │   ├── domain/        (entidades, casos de uso)
│   │   └── presentation/  (pantallas, widgets, providers)
│   ├── peliculas/
│   ├── series/
│   └── cine/
├── shared/
│   ├── widgets/           (botones, cards reutilizables)
│   └── services/          (Firebase, notificaciones)
└── main.dart
```

### Stack de Paquetes Base
- `flutter_riverpod` (manejo de estado)
- `freezed` + `json_serializable` (modelos inmutables con generacion de codigo)
- `go_router` (navegacion declarativa)
- `dio` (HTTP client, preferido sobre `http` por soporte de interceptors y manejo de errores)
- `cached_network_image` (cache de imagenes de TMDB)
- `intl` (manejo de fechas y formato regional)

---

## Filosofia de Desarrollo

### Enfoque Iterativo (MVP-Driven)
- **Prioridad absoluta: prototipos funcionales sobre perfeccion**
- Cada modulo se divide en dos olas de desarrollo:
  - **Ola 1 (MVP):** Lo minimo necesario para que el modulo sea utilizable en la vida real
  - **Ola 2 (Refinamiento):** Reglas avanzadas, validaciones, animaciones, UI pulida
- Entre olas, los dos usuarios **deben usar la app real** durante varios dias para detectar problemas reales antes de refinar
- No avanzar a la fase de refinamiento de un modulo sin haber usado el MVP al menos 3-5 dias
- El orden de las Olas 2 se decide segun feedback de uso real, no segun el orden original del documento

### Reglas No Negociables
1. **Commits semanticos en Git desde el dia 1** (`feat:`, `fix:`, `refactor:`, `docs:`, etc.)
2. **README del repositorio en ingles**, pensando en su uso futuro como portafolio internacional
3. **No copiar codigo sin entenderlo**; preferir aprender con analogias antes de implementar
4. **Refactorizar al cerrar cada modulo**, no al final del proyecto
5. **No avanzar de fase sin cumplir el criterio de cierre** establecido en el plan
6. **El widget jamas accede directamente a Firestore o APIs**; siempre pasa por un repositorio

---

## Estilo de Ensenanza y Nivel

Este proyecto es para práctica personal de Flutter. Tengo poco más de 1 año de experiencia como desarrollador, así que comprendo la mayoría de conceptos básicos e intermedios y puedo adaptarme con cierta rapidez. Puedes armar decisiones técnicas y planes de trabajo más complejos que los de un principiante absoluto (patrones de arquitectura, manejo de estado, estructura modular, etc.), sin necesidad de explicar cada fundamento desde cero.

Cuando pida explicaciones, hazlo de la manera más simple posible y usa analogías básicas y cotidianas para comparar los conceptos. No asumas conocimiento avanzado en temas específicos salvo que yo lo demuestre en la conversación (por ejemplo, Flutter, Firebase, Cloud Functions o arquitecturas concretas).