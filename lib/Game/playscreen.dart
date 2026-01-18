import 'package:flame/game.dart';
import 'package:flame/components.dart';
// ignore: unused_import
import 'package:flutter/material.dart';

import 'package:neoaztlan/Zonas_Juego/zona_usuario.dart';
import 'package:neoaztlan/Zonas_Juego/zona_oponente.dart';
import 'package:neoaztlan/Zonas_Juego/zona_batalla.dart';

class Playscreen extends FlameGame {
  Playscreen()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: 1080,
            height: 1920,
          ),
        );

  // Inicializar Zonas de juego
  final ZonaOponente zona1=ZonaOponente();
  final ZonaBatalla  zona2=ZonaBatalla();
  final ZonaUsuario  zona3=ZonaUsuario();


  @override
  Future<void> onLoad() async {
    add(zona1);
    add(zona2);
    add(zona3);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    final isPortrait = size.y > size.x;

     if (isPortrait) {
      // Horizontal
      //Medira 3/8
      zona1.position = Vector2(0, 0);
      zona1.size = Vector2(size.x,3*size.y/8);
      //Medira 2/8
      zona2.position = Vector2(0, zona1.size.y);
      zona2.size = Vector2(size.x,2*size.y/8);
      //Medira 3/8
      zona3.position = Vector2(0, zona1.size.y+zona2.size.y);
      zona3.size = Vector2(size.x,3*size.y/8);
    } else {
      // Vertical con las mismas medidas
      zona1.position = Vector2(0, 0);
      zona1.size = Vector2(3*size.x/8, size.y);

      zona2.position = Vector2(zona1.size.x, 0);
      zona2.size = Vector2(2*size.x/8, size.y);

      zona3.position = Vector2(zona1.size.x+zona2.size.x, 0);
      zona3.size = Vector2(3*size.x/8, size.y);
    }

    // Se reacomodan los elementos dentro de cada zona
    zona1.reacomodar();
    zona2.reacomodar();
    zona3.reacomodar();
  }
}