import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class ZonaOponente extends PositionComponent {
  @override
  bool get debugMode => true;

  final RectangleComponent carta = RectangleComponent(
    size: Vector2(60, 90),
    paint: Paint()..color = Colors.red,
  );

  @override
  Future<void> onLoad() async {
    add(carta);
  }

  void reacomodar() {
    // Centrar la carta en la zona automáticamente
    carta.position = size / 2 - carta.size / 2;
  }
}
