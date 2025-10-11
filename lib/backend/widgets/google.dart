import 'package:flutter/material.dart';
import 'package:neoaztlan/backend/model/AuthServiceGoogle.dart';
import 'package:neoaztlan/screens/inicio.dart';

// Cambiamos a StatefulWidget para usar 'mounted'
class Google extends StatefulWidget {
  const Google({super.key});

  @override
  State<Google> createState() => _GoogleState();
}

class _GoogleState extends State<Google> {
  // El método de manejo de tap ahora está dentro del State
  Future<void> _handleSignIn() async {
    final UserCredential = await authServiceGoogle();

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
    // La URL googleIconUrl se usa solo en Image.asset,
    // por lo que no es necesario aquí.

    return GestureDetector(
      onTap: _handleSignIn, // Llama a la función asíncrona
      child: Container(
        height: 40,
        width: 240,
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/Google__G__logo.svg.png',
                height: 20,
                width: 20,
              ),
              const SizedBox(width: 10.0),
              const Text(
                // Se hizo const si no tiene variables dinámicas
                'Sign in with Google',
                style: TextStyle(
                  color: Colors.black,
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
