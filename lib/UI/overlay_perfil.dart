import 'package:flutter/material.dart';
import 'package:neoaztlan/UI/informacion_perfil.dart'; 

class PerfilOverlay extends StatelessWidget {
  final VoidCallback onClose;

  // Variables dinámicas del jugador
  final String titulo;
  final String nombre;
  final String avatarNombre;
  final int nivel;
  final int gemas;
  final int estrellas;
  final int victorias;
  final double tasaVictoria;

  const PerfilOverlay({
    super.key,
    required this.onClose,
    required this.titulo,
    required this.nombre,
    required this.avatarNombre,
    required this.nivel,
    required this.gemas,
    required this.estrellas,
    required this.victorias,
    required this.tasaVictoria,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose,
      child: Container(
        // ignore: deprecated_member_use
        color: Colors.black.withOpacity(0.8),
        child: Center(
          child: GestureDetector(
            onTap: () {}, // Evita que el tap dentro cierre el overlay
            child: Container(
              width: 320,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.cyanAccent, width: 2),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.cyanAccent.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        titulo,
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CircleAvatar(
                        radius: 50,
                        // ignore: deprecated_member_use
                        backgroundColor: Colors.cyanAccent.withOpacity(0.3),
                        child: Text(
                          avatarNombre,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        nombre,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Nivel $nivel',
                        style:
                            const TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _infoBox('💎', gemas.toString()),
                          const SizedBox(width: 40),
                          _infoBox('⭐', estrellas.toString()),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _statBox('$victorias\nVictorias',
                              const Color(0xFF00B3B3)),
                          const SizedBox(width: 20),
                          _statBox(
                              '${tasaVictoria.toStringAsFixed(0)}%\nTasa Victoria',
                              const Color(0xFFB3B300)),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Toca fuera para cerrar',
                        style: TextStyle(color: Colors.white54, fontSize: 10),
                      ),
                    ],
                  ),

                  //  Botón de editar 
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        // ignore: deprecated_member_use
                        backgroundColor: Colors.cyanAccent.withOpacity(0.2),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const Dialog(
                            backgroundColor: Colors.transparent,
                            child: InformacionPerfil(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit, size: 18),
                      label: const Text(
                        'Editar',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoBox(String icon, String value) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 24)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 16)),
      ],
    );
  }

  Widget _statBox(String text, Color color) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}

