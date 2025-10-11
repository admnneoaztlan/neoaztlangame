import 'package:flutter/material.dart';
import 'package:neoaztlan/backend/model/rules/obtenerDatosUsuarioActual.dart';

import 'package:neoaztlan/backend/widgets/exit.dart';

class UserInfoDisplay extends StatelessWidget {
  final bool showExitButton;
  final bool showAllData; // Si quieres mostrar todos los campos
  final TextStyle? textStyle;

  const UserInfoDisplay({
    super.key,
    this.showExitButton = true,
    this.showAllData = true,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: obtenerDatosUsuarioActual(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Cargando...");
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Text("No se encontraron datos del usuario");
        }

        final datos = snapshot.data!;
        final nombre = datos['nombreDeUsuario'] ?? 'Sin nombre';
        final rango = datos['rango'] ?? 'Sin rango';
        final nivel = datos['nivel']?.toString() ?? '0';
        final polvo = datos['polvoArcano']?.toString() ?? '0';

        if (!showAllData) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(nombre, style: textStyle ?? const TextStyle(fontSize: 18)),
              if (showExitButton) const Exit(),
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nombre,
                    style: textStyle ??
                        const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text("Rango: $rango"),
                  Text("Nivel: $nivel"),
                  Text("Polvo Arcano: $polvo"),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
