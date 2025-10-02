import 'package:flame/components.dart';
import 'package:flutter/material.dart';
// Importamos las subclases
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
      textRenderer: TextPaint(style: TextStyle(color: Colors.white)),
    );
    add(avatarText);

    vidaText = TextComponent(
      text: 'VIDA 30/30',
      anchor: Anchor.topCenter,
      textRenderer: TextPaint(style: TextStyle(color: Colors.red)),
    );
    add(vidaText);

    // === ZONA DE ARTEFACTOS ===
    zonaArtefactos =
        RectangleComponent(paint: Paint()..color = Colors.blue.shade900);
    add(zonaArtefactos);

    zonaArtefactosText = TextComponent(
      text: 'ZONA DE ARTEFACTOS',
      anchor: Anchor.center,
      textRenderer: TextPaint(style: TextStyle(color: Colors.cyan)),
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
      textRenderer: TextPaint(style: TextStyle(color: Colors.white)),
    );
    add(mazoText);

    quedanCartasText = TextComponent(
      text: "QUEDAN 'N' cartas",
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(style: TextStyle(color: Colors.white)),
    );
    add(quedanCartasText);

    // === CEMENTERIO (Frente - COLOR) ===
    cementerio.clear();
    for (int i = 0; i < 4; i++) {
      final cementerioCarta = _crearCartaAleatoria(i + 4, Vector2.zero());
      cementerioCarta.voltear(); // Voltear para que muestre el color
      cementerio.add(cementerioCarta);
      add(cementerioCarta);
    }

    cementerioText = TextComponent(
      text: 'CEMENTERIO ENEMIGO',
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(style: TextStyle(color: Colors.white)),
    );
    add(cementerioText);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    reacomodar();
  }

  void reacomodar() {
    final zonaW = size.x;
    final zonaH = size.y;

    final cardH = zonaH * 0.20;

    const double cardAspectRatio = 2 / 3;
    final cardW = cardH * cardAspectRatio;

    final textFontSizeH = 0.06 * zonaH;
    final textFontSizeV = 0.08 * zonaH;
    final textFontSizeSmall = 0.02 * zonaH;

    avatarText.textRenderer = TextPaint(
        style: TextStyle(color: Colors.white, fontSize: textFontSizeH));
    vidaText.textRenderer =
        TextPaint(style: TextStyle(color: Colors.red, fontSize: textFontSizeV));
    mazoText.textRenderer = TextPaint(
        style:
            TextStyle(color: Colors.white, fontSize: textFontSizeSmall * 1.5));
    cementerioText.textRenderer = TextPaint(
        style:
            TextStyle(color: Colors.white, fontSize: textFontSizeSmall * 1.5));
    quedanCartasText.textRenderer = TextPaint(
        style: TextStyle(color: Colors.white, fontSize: textFontSizeSmall));
    zonaArtefactosText.textRenderer = TextPaint(
        style: TextStyle(color: Colors.cyan, fontSize: textFontSizeSmall));

    if (zonaW > zonaH) {
      // HORIZONTAL

      // === Elementos Principales (Tamaños y Posiciones ORIGINALES) ===
      avatar.size = Vector2(zonaW * 0.20, zonaH * 0.25); // ORIGINAL
      avatar.position = Vector2(zonaW * 0.05, zonaH * 0.10); // ORIGINAL
      avatarText.position = Vector2(zonaW * 0.15, zonaH * 0.40); // ORIGINAL
      vidaText.position = Vector2(zonaW * 0.15, zonaH * 0.48); // ORIGINAL

      zonaArtefactos.size = Vector2(zonaW * 0.40, zonaH * 0.20); // ORIGINAL
      zonaArtefactos.position = Vector2(zonaW * 0.05, zonaH * 0.65); // ORIGINAL
      zonaArtefactosText.position =
          Vector2(zonaW * 0.25, zonaH * 0.75); // ORIGINAL

      // === MAZO ===
      mazoText.position = Vector2(zonaW * 0.58, zonaH * 0.12);
      quedanCartasText.position = Vector2(zonaW * 0.60, zonaH * 0.43);

      for (int i = 0; i < mazo.length; i++) {
        mazo[i].size =
            Vector2(cardW, cardH); // TAMAÑO CORREGIDO (Proporción Fija)
        mazo[i].position = Vector2(
            zonaW * 0.60 + i * zonaW * 0.02, zonaH * 0.20 + i * zonaH * 0.02);
      }

      // === CEMENTERIO ===
      cementerioText.position = Vector2(zonaW * 0.58, zonaH * 0.62);

      for (int i = 0; i < cementerio.length; i++) {
        cementerio[i].size =
            Vector2(cardW, cardH); // TAMAÑO CORREGIDO (Proporción Fija)
        cementerio[i].position = Vector2(
            zonaW * 0.60 + i * zonaW * 0.02, zonaH * 0.70 + i * zonaH * 0.02);
      }
    } else {
      // VERTICAL

      // === Elementos Principales (Tamaños y Posiciones ORIGINALES) ===
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
        mazo[i].size =
            Vector2(cardW, cardH); // TAMAÑO CORREGIDO (Proporción Fija)
        mazo[i].position = Vector2(
            zonaW * 0.75 + i * zonaW * 0.01, zonaH * 0.15 + i * zonaH * 0.01);
      }

      // === CEMENTERIO ===
      cementerioText.position = Vector2(zonaW * 0.72, zonaH * 0.68);

      for (int i = 0; i < cementerio.length; i++) {
        cementerio[i].size =
            Vector2(cardW, cardH); // TAMAÑO CORREGIDO (Proporción Fija)
        cementerio[i].position = Vector2(
            zonaW * 0.75 + i * zonaW * 0.01, zonaH * 0.74 + i * zonaH * 0.01);
      }
    }
  }
}
