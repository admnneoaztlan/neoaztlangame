import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Carta extends PositionComponent {
  @override
  bool get debugMode => true;

  Carta({
    Vector2? position,
    Vector2? size,
    Color color = Colors.white,
    String? label,
  }) : super(
          position: position ?? Vector2.zero(),
          size: size,
        ) {
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
