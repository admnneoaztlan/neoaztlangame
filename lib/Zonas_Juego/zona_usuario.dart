import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:neoaztlan/Componentes/carta.dart';

class ZonaUsuario extends PositionComponent {
  // Componentes de la zona
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
  List<Carta> mano = [];
  TextComponent manoText = TextComponent(text: '');

  ZonaUsuario() : super(position: Vector2.zero(), size: Vector2.zero());

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final zonaW = size.x;
    final zonaH = size.y;

    _configurarAvatar(zonaW, zonaH);
    _configurarZonaArtefactos(zonaW, zonaH);
    _configurarMazo(zonaW, zonaH);
    _configurarCementerio(zonaW, zonaH);
    _configurarMano(zonaW, zonaH);

    reacomodar();
  }

  void _configurarAvatar(double zonaW, double zonaH) {
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
  }

  void _configurarZonaArtefactos(double zonaW, double zonaH) {
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
  }

  void _configurarMazo(double zonaW, double zonaH) {
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
      text: 'MAZO (22 CARTAS)',
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
  }

  void _configurarCementerio(double zonaW, double zonaH) {
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
      text: 'CEMENTERIO',
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(
        style: TextStyle(color: Colors.white, fontSize: 0.03 * zonaH),
      ),
    );
    add(cementerioText);
  }

  void _configurarMano(double zonaW, double zonaH) {
    mano.clear();
    for (int i = 0; i < 5; i++) {
      final carta = Carta(
        size: Vector2(zonaW * 0.10, zonaH * 0.18),
        color: [Colors.orange, Colors.yellow, Colors.lightGreen, Colors.pink, Colors.teal][i],
      );
      mano.add(carta);
      add(carta);
    }

    manoText = TextComponent(
      text: 'MANO (5 CARTAS)',
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(
        style: TextStyle(color: Colors.white, fontSize: 0.03 * zonaH),
      ),
    );
    add(manoText);
  }

  void reacomodar() {
    final zonaW = size.x;
    final zonaH = size.y;

    if (zonaW > zonaH) {
      _reacomodarHorizontal(zonaW, zonaH);
    } else {
      _reacomodarVertical(zonaW, zonaH);
    }
  }

  void _reacomodarHorizontal(double zonaW, double zonaH) {
    // Avatar
    avatar.position = Vector2(zonaW * 0.05, zonaH * 0.10);
    avatarText.position = Vector2(zonaW * 0.15, zonaH * 0.40);
    vidaText.position = Vector2(zonaW * 0.15, zonaH * 0.48);

    // Zona de Artefactos
    zonaArtefactos.position = Vector2(zonaW * 0.05, zonaH * 0.65);
    zonaArtefactosText.position = Vector2(zonaW * 0.25, zonaH * 0.75);

    // Mazo 
    for (int i = 0; i < mazo.length; i++) {
      mazo[i].position = Vector2(
        zonaW * 0.60 + i * zonaW * 0.02, 
        zonaH * 0.20 + i * zonaH * 0.02
      );
    }
    mazoText.position = Vector2(zonaW * 0.58, zonaH * 0.12);
    quedanCartasText.position = Vector2(zonaW * 0.60, zonaH * 0.43);

    // Cementerio 
    for (int i = 0; i < cementerio.length; i++) {
      cementerio[i].position = Vector2(
        zonaW * 0.60 + i * zonaW * 0.02, 
        zonaH * 0.55 + i * zonaH * 0.02  // ↑ Subido de 0.70 a 0.55
      );
    }
    cementerioText.position = Vector2(zonaW * 0.58, zonaH * 0.47); // ↑ Subido de 0.62 a 0.47

    // Mano 
    for (int i = 0; i < mano.length; i++) {
      mano[i].position = Vector2(
        zonaW * 0.25 + i * zonaW * 0.10,  // ↔ Más espaciado horizontal
        zonaH * 0.88  // ↓ Bajado de 0.85 a 0.88
      );
    }
    manoText.position = Vector2(zonaW * 0.30, zonaH * 0.78); // ↓ Bajado de 0.75 a 0.78
  }

  void _reacomodarVertical(double zonaW, double zonaH) {
    // Avatar
    avatar.position = Vector2(zonaW * 0.10, zonaH * 0.05);
    avatarText.position = Vector2(zonaW * 0.19, zonaH * 0.35);
    vidaText.position = Vector2(zonaW * 0.2, zonaH * 0.40);

    // Zona de Artefactos
    zonaArtefactos.position = Vector2(zonaW * 0.085, zonaH * 0.7);
    zonaArtefactosText.position = Vector2(zonaW * 0.27, zonaH * 0.8);

    // Mazo 
    for (int i = 0; i < mazo.length; i++) {
      mazo[i].position = Vector2(
        zonaW * 0.75 + i * zonaW * 0.01, 
        zonaH * 0.15 + i * zonaH * 0.01
      );
    }
    mazoText.position = Vector2(zonaW * 0.72, zonaH * 0.10);
    quedanCartasText.position = Vector2(zonaW * 0.75, zonaH * 0.41);

    // Cementerio 
    for (int i = 0; i < cementerio.length; i++) {
      cementerio[i].position = Vector2(
        zonaW * 0.75 + i * zonaW * 0.01, 
        zonaH * 0.60 + i * zonaH * 0.01  // ↑ Subido de 0.74 a 0.60
      );
    }
    cementerioText.position = Vector2(zonaW * 0.72, zonaH * 0.54); // ↑ Subido de 0.68 a 0.54

    // Mano 
    for (int i = 0; i < mano.length; i++) {
      mano[i].position = Vector2(
        zonaW * 0.15 + i * zonaW * 0.14,  // ↔ Más espaciado horizontal
        zonaH * 0.88  // ↓ Bajado de 0.90 a 0.88
      );
    }
    manoText.position = Vector2(zonaW * 0.20, zonaH * 0.80); // ↓ Bajado de 0.82 a 0.80
  }
}
