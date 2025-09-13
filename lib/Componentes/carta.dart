import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Carta extends PositionComponent {
  @override
  bool get debugMode => true;

  Carta({
    Vector2? position, // <-- ya no es required
    Vector2? size,
    Color color = Colors.white,
    String? label,
  }) : super(
          position: position ??
              Vector2.zero(), // <-- si no pasas nada, inicia en (0,0)
          size: size,
        ) {
    // Agregar un rectángulo dentro de la carta
    add(RectangleComponent(
      size: size,
      paint: Paint()..color = color,
    ));

    if (label != null) {
      add(TextComponent(
        text: label,
        position: size! / 2,
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
    }
  }
}
