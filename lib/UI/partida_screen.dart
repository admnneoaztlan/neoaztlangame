import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neoaztlan/Game/playscreen.dart';
import 'package:neoaztlan/UI/gems_display.dart';
import 'package:neoaztlan/UI/healt_bar.dart';
import 'package:neoaztlan/UI/overlay_perfil.dart';

// BORRAMOS LA LÍNEA QUE ESTABA AQUÍ (final playscreen...)

class PartidaScreen extends StatelessWidget {
  const PartidaScreen({super.key});

  // El mapa de overlays está bien aquí
  Map<String, Widget Function(BuildContext, Playscreen)> get _overlayBuilderMap => {
    'perfilOverlay': (context, game)=> PerfilOverlay(
      onClose: ()=> game.overlays.remove('perfilOverlay'),
    ),
    'hud': (context, game)=> const Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HealthBar(),
            SizedBox(height: 8),
            GemsDisplay(),
          ],
        ),
      ),
    ),
  };

  @override
  Widget build (BuildContext context){
    // ¡AQUÍ ES DONDE DEBE IR!
    // Creamos una NUEVA partida cada vez que se construye la pantalla.
    final playscreen = Playscreen();

    return Scaffold(
      body: GameWidget<Playscreen>(
        game: playscreen,
        overlayBuilderMap: _overlayBuilderMap,
        initialActiveOverlays: const ['hud'],
      ),
    );
  }
}