import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class ZonaUsuario extends PositionComponent {
  @override
  bool get debugMode => true;

  final CircleComponent ficha = CircleComponent(
    radius: 30,
    paint: Paint()..color = Colors.green,
  );

  @override
  Future<void> onLoad() async {
    add(ficha);
  }

  void reacomodar() {
    ficha.position = size / 2 - ficha.size / 2;
  }
}
