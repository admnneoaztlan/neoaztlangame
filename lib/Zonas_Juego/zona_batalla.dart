import 'package:flame/components.dart';
import 'package:flutter/material.dart'; // Necesario para Colors, Paint, Canvas, etc.
import 'package:neoaztlan/Componentes/carta.dart';

class ZonaBatalla extends PositionComponent {
  // Desactivamos el debugMode para que nuestro renderizado se vea
  @override
  bool get debugMode => false;

  final List<Carta> cartas = List.generate(8, (_) => Carta());

  // Pines de Pintura para el renderizado de los slots
  final Paint slotPaint = Paint()
    ..color = const Color(0xFF6A1B9A).withOpacity(0.2) // Fondo morado oscuro semi-transparente
    ..style = PaintingStyle.fill;

  final Paint neonBorderPaint = Paint()
    ..color = Colors.deepPurpleAccent // Borde neón (Morado/Magenta)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0
    ..maskFilter = MaskFilter.blur(BlurStyle.outer, 1.5); // Brillo sutil

  @override
  Future<void> onLoad() async {
    // Agregamos las cartas a la zona
    for (var carta in cartas) {
      add(carta);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Dibujamos las 8 ranuras de batalla usando las dimensiones y posición de las cartas
    for (final carta in cartas) {
      // Obtenemos el rectángulo y lo redondeamos
      final rect = carta.toRect();
      final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(5));

      // 1. Dibujar el fondo del slot
      canvas.drawRRect(rrect, slotPaint);

      // 2. Dibujar el borde neón del slot
      canvas.drawRRect(rrect, neonBorderPaint);
    }
  }


  void reacomodar() {
    double espacio = 0;
    double cartaWidth=0;
    double cartaHeight=0;
    final isPortrait = size.y > size.x;

    if (isPortrait) {
      // Horizontal
      cartaWidth = size.x / 3;
      cartaHeight = size.y / 5;
      espacio = (size.y - (4* cartaHeight)) / 5;
      //usuario
      for (int i = 0; i < 4; i++) {
        final carta = cartas[i];
        final y = espacio * (i + 1) + cartaHeight * i;
        final x = size.x/2 + (size.x - cartaWidth) / 8;
        // Ajustamos la posición para que esté centrada en la ranura
        carta.position = Vector2(x + cartaWidth / 2, y + cartaHeight / 2);
      }
      //oponente
      for (int i = 4; i < 8; i++) {
        final carta = cartas[i];
        final y = espacio * (i-3) + cartaHeight * (i-4);
        final x = (size.x - cartaWidth) / 8;
        // Ajustamos la posición para que esté centrada en la ranura
        carta.position = Vector2(x + cartaWidth / 2, y + cartaHeight / 2);
      }
    } else {
      // Vertical
      cartaWidth = size.x / 5;
      cartaHeight = size.y / 3;
      espacio = (size.x - (4* cartaWidth)) / 5;
      //usuario
      for (int i = 0; i < 4; i++) {
        final carta = cartas[i];
        final x = espacio * (i + 1) + cartaWidth * i;
        final y = size.y/2 + (size.y - cartaHeight) / 8;
        // Ajustamos la posición para que esté centrada en la ranura
        carta.position = Vector2(x + cartaWidth / 2, y + cartaHeight / 2);
      }
      //oponente
      for (int i = 4; i < 8; i++) {
        final carta = cartas[i];
        final x = espacio * (i-3) + cartaWidth * (i-4);
        final y =(size.y - cartaHeight) / 8;
        // Ajustamos la posición para que esté centrada en la ranura
        carta.position = Vector2(x + cartaWidth / 2, y + cartaHeight / 2);
      }
    }

    for (var carta in cartas) {
      carta.size = Vector2(cartaWidth, cartaHeight);
    }
  }
}