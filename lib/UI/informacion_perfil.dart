import 'package:flutter/material.dart';

/// 🔹 Variables globales compartidas (simulan almacenamiento temporal)
String nombreJugador = "Jugador 1";
String avatarJugador = "avatar_default.png";
int nivelJugador = 1;
String correoJugador = "correo@ejemplo.com";
String contrasenaJugador = "123456";
String nacionalidadJugador = "México";
bool cuentaEliminada = false;

/// Widget principal
class InformacionPerfil extends StatefulWidget {
  const InformacionPerfil({super.key});

  @override
  State<InformacionPerfil> createState() => _InformacionPerfilState();
}

class _InformacionPerfilState extends State<InformacionPerfil> {
  late TextEditingController _nombreController;
  late TextEditingController _avatarController;
  late TextEditingController _nivelController;
  late TextEditingController _correoController;
  late TextEditingController _contrasenaController;
  late TextEditingController _nacionalidadController;

  @override
  void initState() {
    super.initState();
    // Inicializamos con los valores actuales
    _nombreController = TextEditingController(text: nombreJugador);
    _avatarController = TextEditingController(text: avatarJugador);
    _nivelController = TextEditingController(text: nivelJugador.toString());
    _correoController = TextEditingController(text: correoJugador);
    _contrasenaController = TextEditingController(text: contrasenaJugador);
    _nacionalidadController = TextEditingController(text: nacionalidadJugador);
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _avatarController.dispose();
    _nivelController.dispose();
    _correoController.dispose();
    _contrasenaController.dispose();
    _nacionalidadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 500,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.cyanAccent, width: 2),
      ),
      child: SingleChildScrollView(
        // 🔹 Para poder desplazarse
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

            _campo('Nombre', 'Escribe tu nombre', _nombreController),
            const SizedBox(height: 10),
            _campo('Avatar', 'Nombre del avatar', _avatarController),
            const SizedBox(height: 10),
            _campo('Nivel', '0', _nivelController),
            const SizedBox(height: 10),
            _campo('Correo', 'ejemplo@correo.com', _correoController),
            const SizedBox(height: 10),
            _campo('Contraseña', '******', _contrasenaController,
                obscure: true),
            const SizedBox(height: 10),
            _campo('Nacionalidad', 'País de origen', _nacionalidadController),

            const SizedBox(height: 25),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent.withOpacity(0.2),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // 🔹 Guardamos los cambios globalmente
                setState(() {
                  nombreJugador = _nombreController.text;
                  avatarJugador = _avatarController.text;
                  nivelJugador =
                      int.tryParse(_nivelController.text) ?? nivelJugador;
                  correoJugador = _correoController.text;
                  contrasenaJugador = _contrasenaController.text;
                  nacionalidadJugador = _nacionalidadController.text;
                });

                Navigator.of(context).pop(); // 🔹 Cierra el diálogo
              },
              child: const Text('Guardar'),
            ),

            const SizedBox(height: 15),

            // 🔹 Botón Términos y condiciones
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    title: const Text(
                      "Términos y Condiciones",
                      style: TextStyle(color: Colors.cyanAccent),
                    ),
                    content: const Text(
                      "Al usar esta aplicación aceptas que los datos mostrados "
                      "son de carácter informativo y pueden cambiar en futuras versiones.",
                      style: TextStyle(color: Colors.white70),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Aceptar",
                            style: TextStyle(color: Colors.cyanAccent)),
                      ),
                    ],
                  ),
                );
              },
              child: const Text(
                "Ver Términos y Condiciones",
                style: TextStyle(color: Colors.cyanAccent),
              ),
            ),

            const SizedBox(height: 10),

            // 🔹 Botón Eliminar cuenta
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.withOpacity(0.3),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                setState(() {
                  cuentaEliminada = true;
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cuenta eliminada (simulado)'),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              },
              child: const Text('Eliminar cuenta'),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Campo reutilizable
  Widget _campo(String label, String hint, TextEditingController controller,
      {bool obscure = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
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
          borderSide: const BorderSide(color: Colors.cyanAccent, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
