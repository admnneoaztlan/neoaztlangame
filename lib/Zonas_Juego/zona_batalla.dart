import 'package:flame/components.dart';
// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:neoaztlan/Componentes/carta.dart';

class ZonaBatalla extends PositionComponent {
  @override
  bool get debugMode => true;

  final List<Carta> cartas = List.generate(8, (_) => Carta());
  
  @override
  Future<void> onLoad() async {
    // Agregamos las cartas a la zona
    for (var carta in cartas) {
      add(carta);
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
        carta.position = Vector2(x, y);
      }
      //oponente
      for (int i = 4; i < 8; i++) {
        final carta = cartas[i];
        final y = espacio * (i-3) + cartaHeight * (i-4);
        final x = (size.x - cartaWidth) / 8;
        carta.position = Vector2(x, y);
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
        carta.position = Vector2(x, y);
      }
      //oponente
      for (int i = 4; i < 8; i++) {
        final carta = cartas[i];
        final x = espacio * (i-3) + cartaWidth * (i-4);
        final y =(size.y - cartaHeight) / 8;
        carta.position = Vector2(x, y);
      }
    }

    for (var carta in cartas) {
      carta.size = Vector2(cartaWidth, cartaHeight);
    }
  }
}
