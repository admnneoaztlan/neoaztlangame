import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class ZonaBatalla extends PositionComponent {
  @override
  bool get debugMode => true;

  final RectangleComponent tablero = RectangleComponent(
    size: Vector2(200, 150),
    paint: Paint()..color = Colors.blue,
  );

  @override
  Future<void> onLoad() async {
    add(tablero);
  }

  void reacomodar() {
    tablero.position = size / 2 - tablero.size / 2;
  }
}
