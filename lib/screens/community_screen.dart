import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo oscuro
      appBar: AppBar(
        title: const Text('ILHUICATL (Ajustes)'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.cyanAccent, // Texto neón
      ),
      body: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.cyanAccent, width: 2),
            borderRadius: BorderRadius.circular(15),
            color: Colors.white.withOpacity(0.1),
            boxShadow: [
              BoxShadow(
                color: Colors.cyan.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
              )
            ],
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.settings, size: 50, color: Colors.cyanAccent),
              SizedBox(height: 20),
              Text(
                'PANEL DE CONTROL',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NeoAztec' // Si tienes la fuente
                ),
              ),
              SizedBox(height: 10),
              Divider(color: Colors.white24),
              SizedBox(height: 10),
              Text(
                'Volumen: 100%',
                style: TextStyle(color: Colors.white70),
              ),
              SizedBox(height: 5),
              Text(
                'Notificaciones: ACTIVAS',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}