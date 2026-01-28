import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:neoaztlan/Componentes/carta.dart';
import 'package:neoaztlan/Componentes/avatar.dart';

class ZonaOponente extends PositionComponent {
  // Usamos PositionComponent directamente o tu clase Avatar si extiende de ahí
  PositionComponent avatar = Avatar();
  TextComponent avatarText = TextComponent();
  TextComponent vidaText = TextComponent();

  List<Carta> mano = [];
  // No necesitamos manoText para el oponente generalmente, pero lo dejamos por si acaso
  // TextComponent manoText = TextComponent();

  int vidaActual = 30;
  int vidaMaxima = 30;

  ZonaOponente() : super(position: Vector2.zero(), size: Vector2(800, 400));

  @override
  Future<void> onLoad() async { // <--- 'void' con minúscula
    super.onLoad();

    // Configuración del Avatar (asumiendo que Avatar tiene paint, si no, lo quitamos)
    // avatar.paint.color = Colors.red.shade900;
    add(avatar);

    avatarText = _crearTexto('Oponente', 0.05 * size.y, Colors.purpleAccent, Anchor.center, isNeon: true);
    add(avatarText);

    vidaText = _crearTexto('Vida $vidaActual/$vidaMaxima', 0.06 * size.y, Colors.redAccent, Anchor.topCenter, isNeon: true);
    add(vidaText);

    _crearManoOculta();
  }

  void _crearManoOculta() {
    mano.clear();
    for (int i = 0; i < 4; i++) {
      // Creamos cartas base. Al no voltearlas, quedan mostrando el reverso (perfecto para oponente)
      Carta c = Carta(position: Vector2.zero());
      mano.add(c);
      add(c);
    }
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

    // --- AVATAR ---
    final avatarArea = Rect.fromLTWH(zonaW * 0.75, zonaH * 0.1, zonaW * 0.20, zonaH * 0.50);

    // Corregido: Asignar tamaño y luego posición por separado
    avatar.size = Vector2(avatarArea.width, avatarArea.height);
    avatar.position = Vector2(avatarArea.left, avatarArea.top);

    avatarText.position = Vector2(avatarArea.center.dx, avatarArea.bottom + 10);
    vidaText.position = Vector2(avatarArea.center.dx, avatarArea.top - 20);

    // --- MANO OPONENTE ---
    final manoArea = Rect.fromLTWH(zonaW * 0.1, zonaH * 0.1, zonaW * 0.6, zonaH * 0.4);

    _acomodarCartasCurva(
        mano,
        centro: Vector2(manoArea.center.dx, manoArea.top),
        ancho: manoArea.width
    );
  }

  TextComponent _crearTexto(String t, double s, Color c, Anchor a, {bool isNeon = false}) {
    TextStyle st = TextStyle(color: c, fontSize: s);
    if (isNeon) {
      st = st.copyWith(
          shadows: [Shadow(blurRadius: 8, color: c.withOpacity(0.9))],
          fontWeight: FontWeight.bold
      );
    }
    return TextComponent(text: t, anchor: a, textRenderer: TextPaint(style: st));
  }

  // Corregido el nombre y completado el bucle
  void _acomodarCartasCurva(List<Carta> l, {required Vector2 centro, required double ancho}) {
    final n = l.length;
    if (n == 0) return;

    final esp = ancho / (n > 1 ? n - 1 : 1); // Evitar división por cero

    for (int i = 0; i < n; i++) {
      final carta = l[i];

      // Cálculo de posición en X
      final x = centro.x - ancho / 2 + i * esp;

      // Cálculo de curva (Seno) para que parezca una mano de cartas
      // Usamos una amplitud pequeña para que no se vea exagerado
      final y = centro.y + sin((i - (n - 1) / 2) * 0.5) * 30;

      carta.position = Vector2(x, y);

      // Rotación ligera para efecto abanico
      carta.angle = (i - (n - 1) / 2) * 0.1;
    }
  }
}