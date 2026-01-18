import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Importa las nuevas pantallas de flujo (debes crearlas en lib/UI/)
import 'package:neoaztlan/UI/menu_screen.dart';
import 'package:neoaztlan/UI/partida_screen.dart';
import 'package:neoaztlan/UI/resultados_screen.dart';

import 'package:neoaztlan/UI/login_screen.dart';

void main() {
  runApp(
    // Riverpod debe envolver la aplicación para acceso global al estado
    const ProviderScope(
      child: NeoaztlanApp(),
    ),
  );
}

class NeoaztlanApp extends StatelessWidget {
  const NeoaztlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neoaztlan',
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF00B3B3),
        scaffoldBackgroundColor: Colors.black,
      ),

      // La aplicación inicia en el Menú (o puedes cambiar a '/login')
      initialRoute: '/menu',

      // Definición de las Rutas de Navegación
      routes: {
        '/login': (context) => const LoginScreen(),
        '/menu': (context) => const MenuScreen(),
        '/partida': (context) => const PartidaScreen(),
        // Nota: Los resultados deben pasarse por argumentos si los datos son dinámicos.
        '/resultados': (context) => const ResultadosScreen(victoria: true, gemasGanadas: 100),
      },
    );
  }
}

// --- PLACEHOLDER: lib/UI/login_screen.dart ---
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Simular Login exitoso y navegar al Menú
            Navigator.of(context).pushReplacementNamed('/menu');
          },
          child: const Text('Acceder al Neoaztlan (Simulado)'),
        ),
      ),
    );
  }
}