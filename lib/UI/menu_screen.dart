import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'NEOAZTLAN',
              style: TextStyle(
                fontFamily: 'NeoAztec',
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent,
                shadows: [
                  Shadow(blurRadius: 15.0, color: Colors.cyan),
                  Shadow(blurRadius: 5.0, color: Colors.cyanAccent),
                ],
              ),
            ),
            const SizedBox(height: 100),


            _buildMenuButton(
              context,
              label: 'COMENZAR LA PARTIDA',
              icon: Icons.flash_on,
              onPressed: () {

                Navigator.of(context).pushNamed('/partida');
              },
            ),
            const SizedBox(height: 20),

            _buildMenuButton(
              context,
              label: 'ILHUICATL: AJUSTES',
              icon: Icons.cloud_queue,
              onPressed: () {/* ... */},
            ),
            const SizedBox(height: 20),

            _buildMenuButton(
              context,
              label: 'MICTLÁN: BÓVEDA',
              icon: Icons.archive,
              onPressed: () {/* ... */},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, {required String label, required IconData icon, required VoidCallback onPressed}) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.cyan.withOpacity(0.4),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black.withOpacity(0.8),
          foregroundColor: Colors.cyanAccent,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.cyanAccent, width: 2),
          ),
        ),
        icon: Icon(icon, size: 24),
        label: Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}