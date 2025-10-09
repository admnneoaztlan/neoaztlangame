import 'package:flutter/material.dart';

class InformacionPerfil extends StatelessWidget {
  const InformacionPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: Colors.black.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.cyanAccent, width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Editar Perfil',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _campo('Nombre', 'Escribe tu nombre'),
          const SizedBox(height: 10),
          _campo('Avatar', 'Nombre del avatar'),
          const SizedBox(height: 10),
          _campo('Nivel', '0'),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              // ignore: deprecated_member_use
              backgroundColor: Colors.cyanAccent.withOpacity(0.2),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Guardar'),
          )
        ],
      ),
    );
  }

  Widget _campo(String label, String hint) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.cyanAccent),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.cyanAccent),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Colors.cyanAccent, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
