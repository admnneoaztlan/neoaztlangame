import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:neoaztlan/Componentes/carta.dart';

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

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final zonaW = size.x;
    final zonaH = size.y;

    // === AVATAR ===
    avatar = RectangleComponent(
      size: Vector2(zonaW * 0.20, zonaH * 0.25),
      paint: Paint()..color = Colors.deepPurple,
    );
    add(avatar);

    avatarText = TextComponent(
      text: 'AVATAR',
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: TextStyle(color: Colors.white, fontSize: 0.06 * zonaH),
      ),
    );
    add(avatarText);

    vidaText = TextComponent(
      text: 'VIDA 30/30',
      anchor: Anchor.topCenter,
      textRenderer: TextPaint(
        style: TextStyle(color: Colors.red, fontSize: 0.08 * zonaH),
      ),
    );
    add(vidaText);

    // === ZONA DE ARTEFACTOS ===
    zonaArtefactos = RectangleComponent(
      size: Vector2(zonaW * 0.40, zonaH * 0.20),
      paint: Paint()..color = Colors.blue.shade900,
    );
    add(zonaArtefactos);

    zonaArtefactosText = TextComponent(
      text: 'ZONA DE ARTEFACTOS',
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: TextStyle(color: Colors.cyan, fontSize: 0.02 * zonaH),
      ),
    );
    add(zonaArtefactosText);

    // === MAZO ===
    mazo.clear();
    for (int i = 0; i < 4; i++) {
      final carta = Carta(
        size: Vector2(zonaW * 0.12, zonaH * 0.20),
        color: [Colors.cyan, Colors.purple, Colors.red, Colors.brown][i],
      );
      mazo.add(carta);
      add(carta);
    }

    mazoText = TextComponent(
      text: 'MAZO ENEMIGO (22 CARTAS)',
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(
        style: TextStyle(color: Colors.white, fontSize: 0.03 * zonaH),
      ),
    );
    add(mazoText);

    quedanCartasText = TextComponent(
      text: "QUEDAN 'N' cartas",
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(
        style: TextStyle(color: Colors.white, fontSize: 0.02 * zonaH),
      ),
    );
    add(quedanCartasText);

    // === CEMENTERIO ===
    cementerio.clear();
    for (int i = 0; i < 4; i++) {
      final carta = Carta(
        size: Vector2(zonaW * 0.12, zonaH * 0.20),
        color: [Colors.cyan, Colors.purple, Colors.red, Colors.brown][i],
      );
      cementerio.add(carta);
      add(carta);
    }

    cementerioText = TextComponent(
      text: 'CEMENTERIO ENEMIGO',
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(
        style: TextStyle(color: Colors.white, fontSize: 0.03 * zonaH),
      ),
    );
    add(cementerioText);

    reacomodar();
  }

  void reacomodar() {
    final zonaW = size.x;
    final zonaH = size.y;

    if (zonaW > zonaH) {
      // HORIZONTAL
      avatar.position = Vector2(zonaW * 0.05, zonaH * 0.10);
      avatarText.position = Vector2(zonaW * 0.15, zonaH * 0.40);
      vidaText.position = Vector2(zonaW * 0.15, zonaH * 0.48);

      zonaArtefactos.position = Vector2(zonaW * 0.05, zonaH * 0.65);
      zonaArtefactosText.position = Vector2(zonaW * 0.25, zonaH * 0.75);

      for (int i = 0; i < mazo.length; i++) {
        mazo[i].position = Vector2(
            zonaW * 0.60 + i * zonaW * 0.02, zonaH * 0.20 + i * zonaH * 0.02);
      }
      mazoText.position = Vector2(zonaW * 0.58, zonaH * 0.12);
      quedanCartasText.position = Vector2(zonaW * 0.60, zonaH * 0.43);

      for (int i = 0; i < cementerio.length; i++) {
        cementerio[i].position = Vector2(
            zonaW * 0.60 + i * zonaW * 0.02, zonaH * 0.70 + i * zonaH * 0.02);
      }
      cementerioText.position = Vector2(zonaW * 0.58, zonaH * 0.62);
    } else {
      //  VERTICAL
      avatar.position = Vector2(zonaW * 0.10, zonaH * 0.05);
      avatarText.position = Vector2(zonaW * 0.19, zonaH * 0.35);
      vidaText.position = Vector2(zonaW * 0.2, zonaH * 0.40);

      zonaArtefactos.position = Vector2(zonaW * 0.085, zonaH * 0.7);
      zonaArtefactosText.position = Vector2(zonaW * 0.27, zonaH * 0.8);

      for (int i = 0; i < mazo.length; i++) {
        mazo[i].position = Vector2(
            zonaW * 0.75 + i * zonaW * 0.01, zonaH * 0.15 + i * zonaH * 0.01);
      }
      mazoText.position = Vector2(zonaW * 0.72, zonaH * 0.10);
      quedanCartasText.position = Vector2(zonaW * 0.75, zonaH * 0.41);

      for (int i = 0; i < cementerio.length; i++) {
        cementerio[i].position = Vector2(
            zonaW * 0.75 + i * zonaW * 0.01, zonaH * 0.74 + i * zonaH * 0.01);
      }
      cementerioText.position = Vector2(zonaW * 0.72, zonaH * 0.68);
    }
  }
}
