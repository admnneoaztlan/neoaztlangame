import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Orientacion extends FlameGame {
  Orientacion()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: 1080,
            height: 1920,
          ),
        );

  // Ya inicializados aquí
  final Tablero tablero = Tablero();
  final Carta carta = Carta();

  @override
  Future<void> onLoad() async {
    add(tablero);
    add(carta);
    
    
      
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    final isPortrait = size.y > size.x;

    if (isPortrait) {
      carta.position = Vector2(
        size.x / 2 - carta.size.x / 2,
        size.y - carta.size.y - 50,
      );
      
      
    } else {
      carta.position = Vector2(
        size.x - carta.size.x - 50,
        size.y / 2 - carta.size.y / 2,
      );
    }

    tablero.position = size / 2 - tablero.size / 2;
  }
}

class Tablero extends RectangleComponent {
  Tablero()
      : super(
          size: Vector2(800, 600),
          paint: Paint()..color = Colors.green,
        );
}

class Carta extends RectangleComponent {
  Carta()
      : super(
          size: Vector2(40, 60),
          paint: Paint()..color = Colors.red,
        );
}
