import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neoaztlan/State/player_state.dart';

class HealthBar extends ConsumerWidget {
  const HealthBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vidaActual = ref.watch(PlayerProvider.select((data) => data.vidaActual));
    final vidaMaxima = ref.watch(PlayerProvider.select((data) => data.vidaMaxima));
    final nombre = ref.watch(PlayerProvider.select((data) => data.nombre));


    final progress = vidaActual / vidaMaxima;


    Color barColor;
    if (progress > 0.5) {
      barColor = Colors.greenAccent;
    } else if (progress > 0.2) {
      barColor = Colors.yellow;
    } else {
      barColor = Colors.red;
    }

    return Container(
      width: 250,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.cyan.shade700, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.cyan.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nombre,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),

          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress, // Valor entre 0.0 y 1.0
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation<Color>(barColor),
              minHeight: 15,
            ),
          ),
          const SizedBox(height: 4),

          Center(
            child: Text(
              '$vidaActual / $vidaMaxima',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                shadows: [Shadow(blurRadius: 2, color: Colors.black)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}