import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

// ignore: deprecated_member_use
class Avatar extends PositionComponent with TapCallbacks, HasGameRef<FlameGame> {

  // Pines de Pintura
  late Paint basePaint;
  late Paint neonBorderPaint;

  @override
  Future<void> onLoad() async {
    size = Vector2(150, 150);

    // 1. Fondo morado oscuro
    basePaint = Paint()..color = const Color(0xFF6A1B9A);

    // 2. Borde neón (Cian, como en el mockup)
    neonBorderPaint = Paint()
      ..color = Colors.cyanAccent.withOpacity(0.9) // Color neón brillante
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0 // Grosor del borde
    // Aplica el efecto de brillo
      ..maskFilter = MaskFilter.blur(BlurStyle.outer, 3.0);
  }

  @override
  void onTapDown(TapDownEvent event) {
    final overlays = gameRef.overlays;
    const overlayName = 'perfilOverlay';

    if (overlays.isActive(overlayName)) {
      overlays.remove(overlayName);
    } else {
      overlays.add(overlayName);
    }
  }

  @override
  void render(Canvas canvas) {
    // Definimos un Rectángulo Redondeado para un estilo más futurista
    final avatarRRect = RRect.fromRectAndRadius(size.toRect(), const Radius.circular(8));

    // 1. Dibujar el fondo sólido
    canvas.drawRRect(avatarRRect, basePaint);

    // 2. Dibujar el borde neón con efecto de brillo
    canvas.drawRRect(avatarRRect, neonBorderPaint);
  }
}