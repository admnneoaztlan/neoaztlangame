import 'dart:math'; 
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:neoaztlan/Componentes/carta.dart';
import 'package:neoaztlan/Componentes/avatar.dart';

class ZonaUsuario extends PositionComponent {
  PositionComponent avatar = Avatar();
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

  // Función auxiliar
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
  void onGameResize(Vector2 size) { 
    super.onGameResize(size);
    this.size = size;
    reacomodar();
  }

  // CONFIGURACIÓN DE ELEMENTOS
  void _configurarAvatar() {
    avatar = Avatar();
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
    zonaArtefactosText =
        _crearTexto('ZONA DE ARTEFACTOS', 0.02 * size.y, Colors.cyan, Anchor.center);
    add(zonaArtefactosText);
  }

  void _configurarMazo() {
    mazo.clear();
    for (int i = 0; i < 4; i++) {
      final mazoCarta = _crearCartaAleatoria(i, Vector2.zero());
      mazo.add(mazoCarta);
      add(mazoCarta);
    }
    mazoText = _crearTexto(
        'MAZO (${mazo.length} CARTAS)', 0.03 * size.y, Colors.white, Anchor.topLeft);
    add(mazoText);
    quedanCartasText = _crearTexto(
        'QUEDAN ${mazo.length} cartas', 0.02 * size.y, Colors.white, Anchor.topLeft);
    add(quedanCartasText);
  }

  void _configurarCementerio() {
    cementerio.clear();
    for (int i = 0; i < 4; i++) {
      final cementerioCarta = _crearCartaAleatoria(i + 4, Vector2.zero());
      cementerioCarta.voltear();
      cementerio.add(cementerioCarta);
      add(cementerioCarta);
    }
    cementerioText =
        _crearTexto('CEMENTERIO', 0.03 * size.y, Colors.white, Anchor.topLeft);
    add(cementerioText);
  }

  void _configurarMano() {
    mano.clear();
    for (int i = 0; i < 4; i++) {
      final manoCarta = _crearCartaAleatoria(i, Vector2.zero());
      manoCarta.voltear();
      mano.add(manoCarta);
      add(manoCarta);
    }
    manoText = _crearTexto(
        'MANO (${mano.length} CARTAS)', 0.03 * size.y, Colors.white, Anchor.topLeft);
    add(manoText);
  }


  // REACOMODO DE CARTAS 

  void reacomodar() {
    final zonaW = size.x;
    final zonaH = size.y;
    final esHorizontal = zonaW > zonaH;

    // ÁREAS BASE
    final avatarArea =
        Rect.fromLTWH(zonaW * 0.05, zonaH * 0.05, zonaW * 0.20, zonaH * 0.25);
    
    // CEMENTERIO
    final cementerioArea =
        Rect.fromLTWH(zonaW * 0.45, zonaH * 0.15, zonaW * 0.12, zonaH * 0.25);
    
    final mazoArea =
        Rect.fromLTWH(zonaW * 0.80, zonaH * 0.45, zonaW * 0.12, zonaH * 0.25);
    
    final artefactosArea = Rect.fromLTWH(
        zonaW * 0.05,
        esHorizontal ? zonaH * 0.40 : zonaH * 0.35,
        zonaW * 0.40,
        zonaH * 0.20);
    
    final manoArea =
        Rect.fromLTWH(zonaW * 0.15, zonaH * 0.78, zonaW * 0.70, zonaH * 0.18);

    // ELEMENTOS PRINCIPALES
    avatar.size = Vector2(avatarArea.width, avatarArea.height);
    avatar.position = Vector2(avatarArea.left, avatarArea.top);
    avatarText.position = _centrar(avatarArea, avatarText.size);
    vidaText.position =
        Vector2(avatarArea.center.dx, avatarArea.bottom + (zonaH * 0.02));

    zonaArtefactos.size = Vector2(artefactosArea.width, artefactosArea.height);
    zonaArtefactos.position = Vector2(artefactosArea.left, artefactosArea.top);
    zonaArtefactosText.position =
        _centrar(artefactosArea, zonaArtefactosText.size);

    // 🔹 MAZO
    _acomodarCartasApiladas(
      mazo,
      Vector2(mazoArea.left + zonaW * 0.01, mazoArea.top + zonaH * 0.02),
      offset: Vector2(2, 3),
    );
    mazoText.position = Vector2(mazoArea.left, mazoArea.top - zonaH * 0.03);
    quedanCartasText.position =
        Vector2(mazoArea.left, mazoArea.bottom + zonaH * 0.01);

    // 🔹 CEMENTERIO
    _acomodarCartasApiladas(
      cementerio,
      Vector2(cementerioArea.left + zonaW * 0.01, cementerioArea.top + zonaH * 0.02),
      offset: Vector2(3, 2),
      rotarAleatorio: true,
    );
    cementerioText.position =
        Vector2(cementerioArea.left, cementerioArea.top - zonaH * 0.03);

    // 🔹 MANO: línea curva inferior
    _acomodarCartasCurva(
      mano,
      centro: Vector2(manoArea.center.dx, manoArea.center.dy + zonaH * 0.02),
      ancho: manoArea.width * 0.8,
      amplitud: zonaH * 0.05,
    );
    manoText.position =
        Vector2(manoArea.center.dx, manoArea.top - zonaH * 0.03);
  }

  // HELPERS DE TEXTO Y POSICIÓN
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


  // MÉTODOS DE ACOMODO

  void _acomodarCartasApiladas(List<Carta> cartas, Vector2 inicio,
      {Vector2? offset, bool rotarAleatorio = false}) {
    offset ??= Vector2(2, 2);
    for (int i = 0; i < cartas.length; i++) {
      final carta = cartas[i];
      carta.position = inicio + Vector2(i * offset.x, i * offset.y);
      if (rotarAleatorio) {
        carta.angle = (i.isEven ? -0.05 : 0.05);
      } else {
        carta.angle = 0;
      }
    }
  }

  void _acomodarCartasCurva(List<Carta> cartas,
      {required Vector2 centro, required double ancho, double amplitud = 40}) {
    final n = cartas.length;
    if (n == 0) return;
    final espacio = ancho / (n - 1);
    for (int i = 0; i < n; i++) {
      final x = centro.x - ancho / 2 + i * espacio;
      final y = centro.y + sin((i - (n - 1) / 2) * 0.4) * amplitud;
      cartas[i].position = Vector2(x, y);
      cartas[i].angle = ((i - (n - 1) / 2) * 0.05);
    }
  }

  // ACTUALIZACIÓN MÉTODOS
  void actualizarVida(int nuevaVida) {
    vidaActual = nuevaVida.clamp(0, vidaMaxima);
    vidaText.text = 'VIDA $vidaActual/$vidaMaxima';
  }

  void actualizarCartasMazo(int total, int restantes) {
    mazoText.text = 'MAZO ($total CARTAS)';
    quedanCartasText.text = 'QUEDAN $restantes cartas';
  }
}
