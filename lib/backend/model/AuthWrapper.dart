import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neoaztlan/screens/inicio.dart';
import 'package:neoaztlan/screens/viewLogin.dart'; // Tu pantalla de login

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Escucha los cambios en el estado de autenticación de Firebase.
    return StreamBuilder<User?>(
      // Este stream emite el usuario (User) si está logueado, o null si no lo está.
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // 1. Manejar el estado de carga/espera inicial
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Muestra una pantalla de carga mientras Firebase verifica el usuario persistido.
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 2. Comprobar si hay un usuario logueado (la clave de la persistencia)
        final User? user = snapshot.data;

        if (user == null) {
          // El usuario NO está logueado. Redirige a la pantalla de Login.
          return Viewlogin();
        } else {
          // El usuario SÍ está logueado. Redirige a la pantalla principal (Home).
          // La sesión persistida ha sido detectada automáticamente.
          return Inicio();
        }
      },
    );
  }
}
