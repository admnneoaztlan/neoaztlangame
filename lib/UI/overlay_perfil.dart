import 'package:flutter/material.dart';
import 'package:neoaztlan/UI/informacion_perfil.dart';

class PerfilOverlay extends StatefulWidget {
  final VoidCallback onClose;

  // Las variables originales
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
  State<PerfilOverlay> createState() => _PerfilOverlayState();
}

class _PerfilOverlayState extends State<PerfilOverlay> {
  late String _nombre;
  late String _avatarNombre;

  @override
  void initState() {
    super.initState();
    // : Inicializar las variables leyendo la memoria global.
    // Esto asegura que al inicio, tiene el último valor conocido.
    _nombre = nombreJugador;
    _avatarNombre = avatarJugador;
  }

  //  Esta función se llama justo antes de que el Dialog se cierre.
  // Su único propósito es forzar el redibujado de este Overlay.
  void _forzarActualizacion() {
    setState(() {
      // Al llamar a setState(), Flutter sabe que debe reconstruir el widget.
      // Ahora, _nombre y _avatarNombre leerán las variables globales *actualizadas* de nuevo.
      _nombre = nombreJugador;
      _avatarNombre = avatarJugador;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Usamos las variables de estado (_nombre, _avatarNombre, etc.)

    return GestureDetector(
      onTap: widget.onClose,
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
                        widget.titulo,
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
                          _avatarNombre, // <-- Usa la variable de estado
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _nombre, // <-- Usa la variable de estado
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Nivel ${widget.nivel}', // <-- Usa el valor original
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _infoBox('💎', widget.gemas.toString()),
                          const SizedBox(width: 40),
                          _infoBox('⭐', widget.estrellas.toString()),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _statBox('${widget.victorias}\nVictorias',
                              const Color(0xFF00B3B3)),
                          const SizedBox(width: 20),
                          _statBox(
                              '${widget.tasaVictoria.toStringAsFixed(0)}%\nTasa Victoria',
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

                  // Botón de editar
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
                          builder: (context) => Dialog(
                            backgroundColor: Colors.transparent,
                            // Ejecuta la función de actualización DESPUÉS de cerrar  formulario.
                            child: InformacionPerfil(),
                          ),
                        ).then((_) {
                          // El .then() espera a que el Dialog se cierre.
                          _forzarActualizacion();
                        });
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
