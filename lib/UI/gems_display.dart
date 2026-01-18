import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neoaztlan/State/player_state.dart';

class GemsDisplay extends ConsumerWidget {
  const GemsDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gemas = ref.watch(PlayerProvider.select((data) => data.gemas));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(15),

        border: Border.all(color: Colors.amber.shade700, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '✨',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(width: 8),
          Text(
            '$gemas',
            style: const TextStyle(
              color: Colors.amberAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}