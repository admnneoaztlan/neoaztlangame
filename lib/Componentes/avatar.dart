import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

// ignore: deprecated_member_use
class Avatar extends PositionComponent with TapCallbacks, HasGameRef<FlameGame> {
  @override
  Future<void> onLoad() async {
    size = Vector2(150, 150);
    paint = Paint()..color = const Color(0xFF6A1B9A);
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

  late Paint paint;

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), paint);
  }
}
