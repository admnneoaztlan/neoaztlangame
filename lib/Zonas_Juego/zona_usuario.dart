import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:neoaztlan/Componentes/carta.dart';

class ZonaUsuario extends PositionComponent {
  RectangleComponent avatar = RectangleComponent();
  TextComponent avatarText = TextComponent();
  TextComponent vidaText = TextComponent();

  RectangleComponent zonaArtefactos = RectangleComponent();
  TextComponent zonaArtefactosText = TextComponent();

  List<Carta> mazo = [];
  TextComponent mazoText = TextComponent();
  TextComponent quedanCartasText = TextComponent();

  List<Carta> cementerio = [];
  TextComponent cementerioText = TextComponent();

  List<Carta> mano = [];
  TextComponent manoText = TextComponent();

  int vidaActual = 30;
  int vidaMaxima = 30;

  ZonaUsuario() : super(position: Vector2.zero(), size: Vector2(800, 600));

  // CARGA INICIAL
  @override
  Future<void> onLoad() async {
    super.onLoad();
    _configurarAvatar();
    _configurarZonaArtefactos();
    _configurarMazo();
    _configurarCementerio();
    _configurarMano();
    reacomodar();
  }

  @override
  void onGameResize(Vector2 newSize) {
    super.onGameResize(newSize);
    size = newSize;
    reacomodar();
  }

  // CONFIGURACIÓN DE ELEMENTOS
  void _configurarAvatar() {
    avatar = RectangleComponent(
      size: Vector2(size.x * 0.20, size.y * 0.25),
      paint: Paint()..color = Colors.deepPurple,
    );
    add(avatar);

    avatarText =
        _crearTexto('AVATAR', 0.06 * size.y, Colors.white, Anchor.center);
    add(avatarText);

    vidaText = _crearTexto('VIDA $vidaActual/$vidaMaxima', 0.08 * size.y,
        Colors.red, Anchor.topCenter);
    add(vidaText);
  }

  void _configurarZonaArtefactos() {
    zonaArtefactos = RectangleComponent(
      size: Vector2(size.x * 0.40, size.y * 0.20),
      paint: Paint()..color = Colors.blue.shade900,
    );
    add(zonaArtefactos);

    zonaArtefactosText = _crearTexto(
        'ZONA DE ARTEFACTOS', 0.02 * size.y, Colors.cyan, Anchor.center);
    add(zonaArtefactosText);
  }

  void _configurarMazo() {
    mazo.clear();
    final colores = [Colors.cyan, Colors.purple, Colors.red, Colors.brown];
    for (final color in colores) {
      final carta = Carta(
          size: Vector2(size.x * 0.12, size.y * 0.20), colorFrente: color);
      mazo.add(carta);
      add(carta);
    }
    mazoText = _crearTexto('MAZO (${mazo.length} CARTAS)', 0.03 * size.y,
        Colors.white, Anchor.topLeft);
    add(mazoText);

    quedanCartasText = _crearTexto('QUEDAN ${mazo.length} cartas',
        0.02 * size.y, Colors.white, Anchor.topLeft);
    add(quedanCartasText);
  }

  void _configurarCementerio() {
    cementerio.clear();
    final colores = [Colors.cyan, Colors.purple, Colors.red, Colors.brown];
    for (final color in colores) {
      final carta = Carta(
          size: Vector2(size.x * 0.12, size.y * 0.20), colorFrente: color);
      cementerio.add(carta);
      add(carta);
    }
    cementerioText =
        _crearTexto('CEMENTERIO', 0.03 * size.y, Colors.white, Anchor.topLeft);
    add(cementerioText);
  }

  void _configurarMano() {
    mano.clear();
    final colores = [
      Colors.orange,
      Colors.yellow,
      Colors.lightGreen,
      Colors.pink,
      Colors.teal
    ];
    for (final color in colores) {
      final carta = Carta(
          size: Vector2(size.x * 0.10, size.y * 0.18), colorFrente: color);
      mano.add(carta);
      add(carta);
    }
    manoText = _crearTexto('MANO (${mano.length} CARTAS)', 0.03 * size.y,
        Colors.white, Anchor.topLeft);
    add(manoText);
  }

  // REACOMODO RESPONSIVE
  void reacomodar() {
    final zonaW = size.x;
    final zonaH = size.y;
    final esHorizontal = zonaW > zonaH;

    // ÁREAS
    final avatarArea =
        Rect.fromLTWH(zonaW * 0.05, zonaH * 0.05, zonaW * 0.20, zonaH * 0.25);

    final artefactosArea = Rect.fromLTWH(zonaW * 0.05,
        esHorizontal ? zonaH * 0.40 : zonaH * 0.35, zonaW * 0.40, zonaH * 0.20);

    final mazoArea =
        Rect.fromLTWH(zonaW * 0.60, zonaH * 0.10, zonaW * 0.30, zonaH * 0.25);

    final cementerioArea = Rect.fromLTWH(zonaW * 0.60,
        esHorizontal ? zonaH * 0.45 : zonaH * 0.55, zonaW * 0.30, zonaH * 0.25);

    final manoArea =
        Rect.fromLTWH(zonaW * 0.15, zonaH * 0.80, zonaW * 0.70, zonaH * 0.18);

    // ELEMENTOS
    // Avatar
    avatar.size = Vector2(avatarArea.width, avatarArea.height);
    avatar.position = Vector2(avatarArea.left, avatarArea.top);
    avatarText.position = _centrar(avatarArea, avatarText.size);
    vidaText.position =
        Vector2(avatarArea.center.dx, avatarArea.bottom + (zonaH * 0.02));

    // Zona de artefactos
    zonaArtefactos.size = Vector2(artefactosArea.width, artefactosArea.height);
    zonaArtefactos.position = Vector2(artefactosArea.left, artefactosArea.top);
    zonaArtefactosText.position =
        _centrar(artefactosArea, zonaArtefactosText.size);

    // Mazo
    _acomodarCartas(mazo, mazoArea.left + zonaW * 0.02,
        mazoArea.top + zonaH * 0.02, zonaW * 0.02, zonaH * 0.02);
    mazoText.position = Vector2(mazoArea.left, mazoArea.top - zonaH * 0.03);
    quedanCartasText.position =
        Vector2(mazoArea.left, mazoArea.bottom + zonaH * 0.01);

    // Cementerio
    _acomodarCartas(cementerio, cementerioArea.left + zonaW * 0.02,
        cementerioArea.top + zonaH * 0.02, zonaW * 0.02, zonaH * 0.02);
    cementerioText.position =
        Vector2(cementerioArea.left, cementerioArea.top - zonaH * 0.03);

    // Mano
    final spacing = manoArea.width / (mano.length + 1);
    _acomodarCartasLinea(
        mano, manoArea.left + spacing, manoArea.center.dy, spacing);
    manoText.position =
        Vector2(manoArea.center.dx, manoArea.top - zonaH * 0.03);
  }

  // HELPERS
  TextComponent _crearTexto(
      String texto, double size, Color color, Anchor anchor) {
    return TextComponent(
      text: texto,
      anchor: anchor,
      textRenderer: TextPaint(style: TextStyle(color: color, fontSize: size)),
    );
  }

  Vector2 _centrar(Rect area, Vector2 sizeElemento) {
    return Vector2(
      area.left + (area.width - sizeElemento.x) / 2,
      area.top + (area.height - sizeElemento.y) / 2,
    );
  }

  void _acomodarCartas(List<Carta> cartas, double startX, double startY,
      double offsetX, double offsetY) {
    for (int i = 0; i < cartas.length; i++) {
      cartas[i].position = Vector2(startX + i * offsetX, startY + i * offsetY);
    }
  }

  void _acomodarCartasLinea(
      List<Carta> cartas, double startX, double y, double spacing) {
    for (int i = 0; i < cartas.length; i++) {
      cartas[i].position = Vector2(startX + i * spacing, y);
    }
  }

  // ACTUALIZACIÓN METODOS
  void actualizarVida(int nuevaVida) {
    vidaActual = nuevaVida.clamp(0, vidaMaxima);
    vidaText.text = 'VIDA $vidaActual/$vidaMaxima';
  }

  void actualizarCartasMazo(int total, int restantes) {
    mazoText.text = 'MAZO ($total CARTAS)';
    quedanCartasText.text = 'QUEDAN $restantes cartas';
  }
}
