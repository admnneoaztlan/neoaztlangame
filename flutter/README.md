# NeoAztlan — Flutter App Base

Estructura base para trabajar en paralelo:
- **Flutter app** en `/flutter`
- **Flame engine/package** en `/flame` (consumido como dependencia local)
- **Firebase**: inicializar con `flutterfire configure` (genera `lib/firebase_options.dart`).

## Primeros pasos
```bash
# 1) Instala dependencias
cd flutter
flutter pub get

# 2) Genera firebase_options.dart (una sola vez)
dart pub global activate flutterfire_cli
flutterfire configure --platforms=android,ios,web

# 3) Corre la app
flutter run
```

## Estructura principal
- `lib/app.dart` — MaterialApp, tema, navegación
- `lib/main.dart` — init de Firebase y `runApp`
- `lib/features/home/home_page.dart` — Menú principal
- `lib/features/game/game_page.dart` — `GameWidget` que usa `NeoGame` del paquete `/flame`
- `/flame/lib/neo_game.dart` — punto de entrada del equipo Flame
