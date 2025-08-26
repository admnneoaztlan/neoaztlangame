import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame_module/neo_game.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GameWidget(game: NeoGame()),
    );
  }
}
