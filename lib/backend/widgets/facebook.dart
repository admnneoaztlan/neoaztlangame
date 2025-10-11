import 'package:flutter/material.dart';
import 'package:neoaztlan/backend/model/AuthServiceFacebook.dart';
import 'package:neoaztlan/screens/inicio.dart';

class Facebook extends StatefulWidget {
  const Facebook({super.key});

  @override
  State<Facebook> createState() => _FacebookState();
}

class _FacebookState extends State<Facebook> {
  Future<void> _handleSignIn() async {
    final UserCredential = await authServiceFacebook();

    // 💥 CORRECCIÓN CLAVE: Verificar si el widget sigue en el árbol antes de navegar.
    if (!mounted) return;

    if (UserCredential != null) {
      // Usar pushReplacement es mejor aquí para que el usuario no pueda
      // regresar a la pantalla de login con el botón de atrás.
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Inicio()));
    }
  }

  @override
  Widget build(BuildContext context) {
    const facebookIconUrl = 'assets/Facebook_icon.svg.png';

    return GestureDetector(
      onTap: _handleSignIn,
      child: Container(
        height: 40,
        width: 240,
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
                'Login with Facebook',
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
