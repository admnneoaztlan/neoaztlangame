import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:neoaztlan/Game/playscreen.dart';
import 'package:neoaztlan/UI/overlay_perfil.dart';

void main() {
  final playscreen = Playscreen();

  runApp(
    MaterialApp( 
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GameWidget(
          game: playscreen,
          overlayBuilderMap: {
            'perfilOverlay': (context, _) => PerfilOverlay(
                  onClose: () => playscreen.overlays.remove('perfilOverlay'),
                  titulo: 'Guardián estelar',
                  nombre: 'quetzal25',
                  avatarNombre: 'QUETAL',
                  nivel: 10,
                  gemas: 350,
                  estrellas: 2000,
                  victorias: 1247,
                  tasaVictoria: 79,
                ),
          },
        ),
      ),
    ),
  );
}
