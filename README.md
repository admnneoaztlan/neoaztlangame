# NeoAztlán – Flutter Monorepo Skeleton

Este esqueleto está listo para subirse a **tres ramas** del mismo repositorio:
- `team/flutter` – UI, navegación, widgets, estados.
- `team/flame` – Gameplay con Flame, sistemas ECS, assets del juego.
- `team/firebase` – Integraciones (auth, firestore, storage, functions), reglas y config.

> La **misma base** se sube a cada rama. Después **cada equipo genera sus plataformas** localmente con `flutter create` y agrega sus dependencias. Así evitamos conflictos cruzados en nativos.

---

## 1) Requisitos
- Flutter 3.22+ (`flutter --version`)
- Dart SDK incluido en Flutter
- Git
- (opcional) Android Studio / Xcode según plataforma

---

## 2) Crear plataformas por rama (local)
> Las carpetas nativas `android/ ios/ windows/ macos/ linux/ web/` **no se versionan** en este esqueleto inicial. Cada equipo las genera en su rama.

```bash
# Ejemplo para generar TODAS las plataformas
flutter create . --platforms=android,ios,windows,macos,linux,web
```

- **Flutter team**: genera todas o las de escritorio/web según necesiten para UI.
- **Flame team**: genera las plataformas objetivo del juego.
- **Firebase team**: puede enfocarse en Android/iOS/Web.

> Si una rama necesita subir los nativos (recomendado en etapas de build), simplemente elimina esas rutas del `.gitignore` y commitea.

---

## 3) Dependencias por rama (sugerencias)

### team/flutter
```bash
flutter pub add go_router riverpod flutter_hooks
```

### team/flame
```bash
flutter pub add flame flame_audio flame_tiled
```

### team/firebase
```bash
flutter pub add firebase_core firebase_auth cloud_firestore firebase_storage
# Web setup: flutterfire configure (si lo requieren)
```

---

## 4) Scripts útiles

- Generar todas las plataformas:
  ```bash
  bash scripts/setup_all_platforms.sh
  ```

- Limpiar y reconstruir:
  ```bash
  flutter clean && flutter pub get
  ```

---

## 5) Estructura

```
.
├── lib/
│  └── main.dart
├── test/
│  └── widget_test.dart
├── scripts/
│  └── setup_all_platforms.sh
├── analysis_options.yaml
├── pubspec.yaml
├── .gitignore
└── README.md
```

---

## 6) Convenciones de ramas

- `main`: solo releases estables.
- `dev`: integración temporal si lo necesitan.
- `team/flutter`, `team/flame`, `team/firebase`: trabajo diario de cada equipo.

Para **PRs entre equipos**, abrir contra `dev` y luego `dev -> main` cuando haya hitos.

---

## 7) Checklist por equipo

**Flutter**
- [ ] Generar plataformas necesarias
- [ ] Definir rutas (go_router)
- [ ] Layout base y tema

**Flame**
- [ ] Generar plataformas de target
- [ ] Crear `Game` base en `lib/game/`
- [ ] Cargar assets y sistemas

**Firebase**
- [ ] `flutterfire configure` si aplicable
- [ ] Inicializar Firebase en `main.dart` condicional por flavor
- [ ] Reglas y emuladores

¡Listo para trabajar! 🚀