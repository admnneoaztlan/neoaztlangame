import 'package:flutter/material.dart';

class ResultadosScreen extends StatelessWidget {
  final bool victoria;
  final int gemasGanadas;

  const ResultadosScreen({
    super.key,
    required this.victoria,
    this.gemasGanadas = 0,
  });

  @override
  Widget build(BuildContext context) {
    final titulo = victoria ? '¡NEOAZTLAN ES TUYO!' : 'SUEÑO DETENIDO...';
    final color = victoria ? Colors.greenAccent : Colors.redAccent;
    final icono = victoria ? Icons.emoji_events : Icons.sentiment_dissatisfied;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color, width: 3),
            boxShadow: [BoxShadow(color: color.withOpacity(0.4), blurRadius: 25)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icono, size: 60, color: color),
              const SizedBox(height: 10),
              Text(
                titulo,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 32, fontWeight: FontWeight.bold, color: color),
              ),
              const SizedBox(height: 20),
              Text('Gemas Obtenidas: $gemasGanadas ✨',
                  style: const TextStyle(fontSize: 20, color: Colors.white70)),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {

                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                child: const Text('Volver al Anáhuac (Menú)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}