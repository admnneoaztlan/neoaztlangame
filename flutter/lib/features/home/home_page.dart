import 'package:flutter/material.dart';
import '../game/game_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NeoAztlan')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const GamePage()),
          ),
          child: const Text('Iniciar juego'),
        ),
      ),
    );
  }
}
