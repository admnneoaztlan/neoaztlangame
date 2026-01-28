import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neoaztlan/State/player_state.dart';
import 'package:neoaztlan/UI/informacion_perfil.dart';

class PerfilOverlay extends ConsumerWidget {
  final VoidCallback onClose;


  const PerfilOverlay({
    super.key,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final playerData = ref.watch(PlayerProvider);
    const String titulo = 'Guardián Estelar';
    final String nombre = playerData.nombre;
    final String avatarNombre = playerData.avatarNombre;
    final int nivel = playerData.nivel;
    final int gemas = playerData.gemas;
    final int estrellas = playerData.estrellas;
    final double tasaVictoria = playerData.tasaVictoria;
    final int victorias = playerData.victorias;


    return GestureDetector(
      onTap: onClose,
      child: Container(
        color: Colors.black.withOpacity(0.8),
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: 350,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.9),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.cyanAccent.withOpacity(0.8), width: 2),
                boxShadow: [
                  BoxShadow(
                      color: Colors.cyanAccent.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 2),
                ],
              ),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(titulo, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w300, color: Colors.white70)),
                      const SizedBox(height: 10),
                      // ... (Resto del código visual del perfil) ...
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.cyanAccent.withOpacity(0.3),
                        child: Text(
                          avatarNombre.substring(0, 1),
                          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.cyanAccent),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(nombre, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 4),
                      Text('Nivel $nivel', style: const TextStyle(fontSize: 16, color: Colors.cyanAccent)),
                      const SizedBox(height: 20),

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
                          _statBox(
                              '${victorias}\nVictorias', const Color(0xFF00B3B3)),
                          const SizedBox(width: 20),
                          _statBox(
                              '${tasaVictoria.toStringAsFixed(1)}%\nTasa Victoria',
                              const Color(0xFFB3B300)),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text('Toca fuera para cerrar', style: TextStyle(color: Colors.white54, fontSize: 10)),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  SizedBox(
                    width: double.infinity, // Que ocupe el ancho disponible
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.redAccent, width: 1.5),
                        foregroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        // 1. Limpiamos los datos del jugador en Riverpod
                        ref.read(PlayerProvider.notifier).logout();

                        // 2. Navegamos al Login y borramos todo el historial (Seguridad)
                        Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                      },
                      icon: const Icon(Icons.logout_rounded),
                      label: const Text(
                        'CERRAR SESIÓN',
                        style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Text('Toca fuera para cerrar', style: TextStyle(color: Colors.white54, fontSize: 10)),

                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white54, width: 1),
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
                      label: const Text('Editar', style: TextStyle(fontSize: 14)),
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
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 14, shadows: [
          Shadow(color: color, blurRadius: 5),
        ]),
      ),
    );
  }


}