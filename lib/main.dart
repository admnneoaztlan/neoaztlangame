import 'package:flutter/material.dart';

void main() {
  runApp(const NeoAztlanApp());
}

class NeoAztlanApp extends StatelessWidget {
  const NeoAztlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeoAztlán',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF10593e),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NeoAztlán – Base')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Skeleton listo por ramas: team/flutter, team/flame, team/firebase'),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () {},
              child: const Text('¡A construir!'),
            ),
          ],
        ),
      ),
    );
  }
}