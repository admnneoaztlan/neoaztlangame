import 'package:flutter/material.dart';

class Facebook extends StatelessWidget {
  const Facebook({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    const facebookIconUrl = 'assets/Facebook_icon.svg.png';

    return GestureDetector(
      onTap: () {
        // TODO: Implementar la lógica de autenticación de Facebook aquí.
        print('Botón de Continuar con Facebook presionado.');
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: const Color(0xFF1877F2), // Color azul oficial de Facebook
          borderRadius: BorderRadius.circular(25.0),
          border: Border.all(color: const Color(0xFF1877F2)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                facebookIconUrl,
                height: 24,
                width: 24,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.facebook, // Fallback icon si la imagen no carga
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 10.0),
              const Text(
                'Continuar con Facebook',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
