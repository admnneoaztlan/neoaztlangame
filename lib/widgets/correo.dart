import 'package:flutter/material.dart';

class Correo extends StatelessWidget {
  const Correo({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Implementar la lógica de autenticación de correo aquí.
        print('Botón de Correo electrónico presionado.');
      },
      child: Container(
        height: 50,
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
              const Icon(
                Icons.email,
                color: Colors.black,
                size: 24,
              ),
              const SizedBox(width: 10.0),
              const Text(
                'Correo electronico',
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
