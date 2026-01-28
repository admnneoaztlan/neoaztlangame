import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TUS IMPORTS:
import 'package:neoaztlan/UI/menu_screen.dart';
import 'package:neoaztlan/UI/partida_screen.dart';
import 'package:neoaztlan/UI/resultados_screen.dart';
import 'package:neoaztlan/screens/shop_screen.dart';
// import 'package:neoaztlan/screens/community_screen.dart'; // <--- YA NO NECESITAS ESTE PARA AJUSTES

// IMPORTA EL NUEVO ARCHIVO:
import 'package:neoaztlan/UI/ajustes_screen.dart';

void main() {
  runApp(
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
      initialRoute: '/menu',
      routes: {
        '/menu': (context) => const MenuScreen(),
        '/partida': (context) => const PartidaScreen(),
        '/resultados': (context) => const ResultadosScreen(victoria: true, gemasGanadas: 100),
        '/boveda': (context) => const ShopScreen(), // Asegúrate de poner const si el constructor lo permite

        // --- AQUÍ ESTÁ EL CAMBIO ---
        '/ajustes': (context) => const AjustesScreen(), // Ahora apunta al archivo nuevo
      },
    );
  }
}