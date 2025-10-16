import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:neoaztlan/Componentes/carta.dart'
    show CartaGuerrero, CartaMito, CartaLeyenda, CartaDios, Carta;

class ZonaOponente extends PositionComponent {
  RectangleComponent avatar = RectangleComponent();
  TextComponent avatarText = TextComponent(text: '');
  TextComponent vidaText = TextComponent(text: '');
  RectangleComponent zonaArtefactos = RectangleComponent();
  TextComponent zonaArtefactosText = TextComponent(text: '');
  List<Carta> mazo = [];
  TextComponent mazoText = TextComponent(text: '');
  TextComponent quedanCartasText = TextComponent(text: '');
  List<Carta> cementerio = [];
  TextComponent cementerioText = TextComponent(text: '');

  // Almacenar los overlays grises
  List<RectangleComponent> overlaysGrises = [];

  ZonaOponente() : super(position: Vector2.zero(), size: Vector2.zero());

  // Función auxiliar: Crea una carta de un tipo específico
  Carta _crearCartaAleatoria(int index, Vector2? posicion) {
    switch (index % 4) {
      case 0:
        return CartaGuerrero(position: posicion);
      case 1:
        return CartaMito(position: posicion);
      case 2:
        return CartaLeyenda(position: posicion);
      case 3:
        return CartaDios(position: posicion);
      default:
        return CartaGuerrero(position: posicion);
    }
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    _inicializarElementos();
    // El reacomodo se hace al final para aplicar posiciones y tamaños correctos.
    reacomodar();
  }

  void _inicializarElementos() {
    // === AVATAR ===
    avatar = RectangleComponent(paint: Paint()..color = Colors.deepPurple);
    add(avatar);

    avatarText = TextComponent(
      text: 'AVATAR',
      anchor: Anchor.center,
      textRenderer: TextPaint(style: const TextStyle(color: Colors.white)),
    );
    add(avatarText);

    vidaText = TextComponent(
      text: 'VIDA 30/30',
      anchor: Anchor.topCenter,
      textRenderer: TextPaint(style: const TextStyle(color: Colors.red)),
    );
    add(vidaText);

    // === ZONA DE ARTEFACTOS ===
    zonaArtefactos =
        RectangleComponent(paint: Paint()..color = Colors.blue.shade900);
    add(zonaArtefactos);

    zonaArtefactosText = TextComponent(
      text: 'ZONA DE ARTEFACTOS',
      anchor: Anchor.center,
      textRenderer: TextPaint(style: const TextStyle(color: Colors.cyan)),
    );
    add(zonaArtefactosText);

    // === MAZO (Reverso - IMAGEN) ===
    mazo.clear();
    for (int i = 0; i < 4; i++) {
      final mazoCarta = _crearCartaAleatoria(i, Vector2.zero());
      mazo.add(mazoCarta);
      add(mazoCarta);
    }

    mazoText = TextComponent(
      text: 'MAZO ENEMIGO (22 CARTAS)',
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(style: const TextStyle(color: Colors.white)),
    );
    add(mazoText);

    quedanCartasText = TextComponent(
      text: "QUEDAN 'N' cartas",
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(style: const TextStyle(color: Colors.white)),
    );
    add(quedanCartasText);

    // === CEMENTERIO  ===
    cementerio.clear();
    overlaysGrises.clear();

    for (int i = 0; i < 4; i++) {
      final cementerioCarta = _crearCartaAleatoria(i + 4, Vector2.zero());
      cementerioCarta.voltear(); // Voltear para que muestre el color

      //  Asignar prioridad basada en la posición en la pila.
      // Cuanto más alto el índice (i), más arriba en la pila y más alta la prioridad.
      cementerioCarta.priority = 100 + (i * 10);

      cementerio.add(cementerioCarta);
      add(cementerioCarta);

      //  Crear el filtro gris inmediatamente después de crear la carta
      _crearOverlayGris(cementerioCarta);
    }

    cementerioText = TextComponent(
      text: 'CEMENTERIO ENEMIGO',
      //anchor: Anchor.center,
      textRenderer: TextPaint(style: const TextStyle(color: Colors.white)),
      priority: 999,
    );
    add(cementerioText);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    this.size = size;
    reacomodar();
  }

  void reacomodar() {
    final zonaW = size.x;
    final zonaH = size.y;

    //  TAMAÑO CARTA: Mantiene la proporción 2:3 fija para evitar estiramiento
    final cardH = zonaH * 0.20;
    const double cardAspectRatio = 2 / 3;
    final cardW = cardH * cardAspectRatio;

    // --- ESCALADO DE FUENTES
    final textFontSizeH = 0.06 * zonaH;
    final textFontSizeV = 0.08 * zonaH;
    final textFontSizeSmall = 0.02 * zonaH;

    avatarText.textRenderer = TextPaint(
        style: TextStyle(color: Colors.white, fontSize: textFontSizeH));
    vidaText.textRenderer =
        TextPaint(style: TextStyle(color: Colors.red, fontSize: textFontSizeV));

    //  reasignamos el textRenderer ANTES de calcular la posición.
    mazoText.textRenderer = TextPaint(
        style: TextStyle(color: Colors.white, fontSize: textFontSizeSmall));
    cementerioText.textRenderer = TextPaint(
        style: TextStyle(color: Colors.white, fontSize: textFontSizeSmall));

    quedanCartasText.textRenderer = TextPaint(
        style: TextStyle(color: Colors.white, fontSize: textFontSizeSmall));
    zonaArtefactosText.textRenderer = TextPaint(
        style: TextStyle(color: Colors.cyan, fontSize: textFontSizeSmall));
    // -------------------------------------------------

    //  COORDENADAS BASE PARA EL CEMENTERIO
    const double cementerioXVertical =
        0.72; // Posición X (cerca del borde derecho)
    const double cementerioYTextVertical =
        0.30; // Posición Y del texto (un punto fijo arriba)
    const double cementerioYCardsVertical =
        0.65; // Posición Y de la PRIMERA carta (debajo del texto)

    if (zonaW > zonaH) {
      // HORIZONTAL
      avatar.size = Vector2(zonaW * 0.20, zonaH * 0.25);
      avatar.position = Vector2(zonaW * 0.05, zonaH * 0.10);
      avatarText.position = Vector2(zonaW * 0.15, zonaH * 0.40);
      vidaText.position = Vector2(zonaW * 0.15, zonaH * 0.48);

      zonaArtefactos.size = Vector2(zonaW * 0.40, zonaH * 0.20);
      zonaArtefactos.position = Vector2(zonaW * 0.05, zonaH * 0.65);
      zonaArtefactosText.position = Vector2(zonaW * 0.25, zonaH * 0.75);

      // === MAZO ===
      mazoText.position = Vector2(zonaW * 0.58, zonaH * 0.12);
      quedanCartasText.position = Vector2(zonaW * 0.60, zonaH * 0.43);

      for (int i = 0; i < mazo.length; i++) {
        mazo[i].size = Vector2(cardW, cardH);
        mazo[i].position = Vector2(
            zonaW * 0.60 + i * zonaW * 0.02, zonaH * 0.20 + i * zonaH * 0.02);
      }

      cementerioText.position = Vector2(zonaW * 0.58, zonaH * 0.62);

      for (int i = 0; i < cementerio.length; i++) {
        cementerio[i].size = Vector2(cardW, cardH);
        cementerio[i].position = Vector2(
            zonaW * 0.60 + i * zonaW * 0.02, zonaH * 0.70 + i * zonaH * 0.02);
      }
    } else {
      // VERTICAL
      avatar.size = Vector2(zonaW * 0.20, zonaH * 0.25);
      avatar.position = Vector2(zonaW * 0.10, zonaH * 0.05);
      avatarText.position = Vector2(zonaW * 0.19, zonaH * 0.35);
      vidaText.position = Vector2(zonaW * 0.2, zonaH * 0.40);

      zonaArtefactos.size = Vector2(zonaW * 0.40, zonaH * 0.20);
      zonaArtefactos.position = Vector2(zonaW * 0.085, zonaH * 0.7);
      zonaArtefactosText.position = Vector2(zonaW * 0.27, zonaH * 0.8);

      // === MAZO ===
      mazoText.position = Vector2(zonaW * 0.72, zonaH * 0.10);
      quedanCartasText.position = Vector2(zonaW * 0.75, zonaH * 0.41);

      for (int i = 0; i < mazo.length; i++) {
        mazo[i].size = Vector2(cardW, cardH);
        mazo[i].position = Vector2(
            zonaW * 0.75 + i * zonaW * 0.01, zonaH * 0.15 + i * zonaH * 0.01);
      }

      cementerioText.position =
          Vector2(zonaW * cementerioXVertical, zonaH * cementerioYTextVertical);

      for (int i = 0; i < cementerio.length; i++) {
        cementerio[i].size = Vector2(cardW, cardH);

        cementerio[i].position = Vector2(zonaW * 0.75 + i * zonaW * 0.01,
            zonaH * cementerioYCardsVertical + i * zonaH * 0.01);
      }
    }

    // Actualizar la posición de los overlays grises después de mover las cartas
    _actualizarOverlaysGrises();
  }

  // -------------------------------------------------------------
  // --- MÉTODOS DE OVERLAY GRIS                               ---
  // -------------------------------------------------------------

  void _crearOverlayGris(Carta carta) {
    // 1. Overlay de desaturación
    final overlay = RectangleComponent(
      size: carta.size,
      position: carta.position.clone(),
      anchor: carta.anchor,
      paint: Paint()
        ..color = Colors.grey.withAlpha((255 * 0.8).round())
        ..blendMode = BlendMode.saturation, // Efecto de escala de grises
    );

    // El overlay siempre debe estar encima de la carta
    carta.parent?.add(overlay); // Añadir al mismo padre que la carta
    overlaysGrises.add(overlay);

    // 2. Overlay oscuro (sombra) para efecto más intenso
    final overlayIntenso = RectangleComponent(
      size: carta.size,
      position: carta.position.clone(),
      anchor: carta.anchor,
      paint: Paint()
        ..color = Colors.black.withAlpha((255 * 0.3).round())
        ..blendMode = BlendMode.multiply,
    );

    carta.parent?.add(overlayIntenso); // Añadir al mismo padre que la carta
    overlaysGrises.add(overlayIntenso);

    //  Asignar prioridad de dibujo inicial
    overlay.priority = carta.priority + 1;
    overlayIntenso.priority = carta.priority + 2;
  }

  void _actualizarOverlaysGrises() {
    // Cada carta tiene 2 overlays (overlay1 y overlay2)
    for (int i = 0; i < cementerio.length; i++) {
      final carta = cementerio[i];
      final indexBase = i * 2; // El índice del primer overlay de esta carta

      if (indexBase < overlaysGrises.length) {
        final overlay1 = overlaysGrises[indexBase];
        final overlay2 = overlaysGrises[indexBase + 1];

        // El size, position y angle del overlay deben coincidir con la carta
        overlay1.position = carta.position.clone();
        overlay1.angle = carta.angle;
        overlay1.size = carta.size;

        overlay2.position = carta.position.clone();
        overlay2.angle = carta.angle;
        overlay2.size = carta.size;

        //  Reasignar la prioridad de dibujo de forma relativa a la carta
        // Esto asegura que los overlays (prioridad +1 y +2) se dibujen sobre la carta (prioridad N)
        // pero debajo de la siguiente carta apilada (prioridad N+10).
        overlay1.priority = carta.priority + 1;
        overlay2.priority = carta.priority + 2;
      }
    }
  }

  // MÉTODOS DE ACTUALIZACIÓN DE TEXTO (Tu lógica original)
  void actualizarVida(int nuevaVida) {
    // ...
  }

  void actualizarCartasMazo(int total, int restantes) {
    // ...
  }
}
