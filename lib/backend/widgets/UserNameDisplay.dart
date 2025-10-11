import 'package:flutter/material.dart';
import 'package:neoaztlan/backend/model/rules/obtenerDatosUsuarioActual.dart';

class UserNameDisplay extends StatelessWidget {
  final bool showExitButton;
  final TextStyle? textStyle;

  const UserNameDisplay({
    super.key,
    this.showExitButton = true,
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
        final datosUsuario = snapshot.data!;
        final nombre = datosUsuario['nombreDeUsuario'] ?? 'Sin nombre';

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              nombre,
              style: textStyle ??
                  const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
            ),
          ],
        );
      },
    );
  }
}
