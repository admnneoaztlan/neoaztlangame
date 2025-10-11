import 'package:flutter/material.dart';

// ==========================================================
// 🔹 VARIABLES GLOBALES (SIMULACIÓN DE BASE DE DATOS)
//    Se asume que estas variables son globales y actualizan el Overlay
// ==========================================================
String nombreJugador = 'Jugador 1';
String avatarJugador = 'avatar_default.png';
String correoJugador = 'correo@ejemplo.com';
String contrasenaJugador = '123456';
String nacionalidadJugador = 'México';
bool cuentaEliminada = false;
bool notificacionesActivas = true; //
// ==========================================================

/// Widget principal
class InformacionPerfil extends StatefulWidget {
  const InformacionPerfil({super.key});

  @override
  State<InformacionPerfil> createState() => _InformacionPerfilState();
}

class _InformacionPerfilState extends State<InformacionPerfil> {
  // Controladores de Edición
  late TextEditingController _nombreController;
  late TextEditingController _avatarController;
  late TextEditingController _correoController;
  late TextEditingController _contrasenaController;
  late TextEditingController _nacionalidadController;

  // Variable local para manejar el estado del Switch
  late bool _notificacionesActivasLocal;

  // Creamos un controlador de scroll
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Inicializamos con los valores actuales (globales)
    _nombreController = TextEditingController(text: nombreJugador);
    _avatarController = TextEditingController(text: avatarJugador);
    _correoController = TextEditingController(text: correoJugador);
    _contrasenaController = TextEditingController(text: contrasenaJugador);
    _nacionalidadController = TextEditingController(text: nacionalidadJugador);

    _notificacionesActivasLocal = notificacionesActivas;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _avatarController.dispose();
    _correoController.dispose();
    _contrasenaController.dispose();
    _nacionalidadController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.cyanAccent, width: 2),
      ),
      child: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        thickness: 8.0,
        radius: const Radius.circular(10), // Bordes redondeados
        trackVisibility: true,
        scrollbarOrientation: ScrollbarOrientation.right,

        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.only(right: 18.0),
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

              // --- CAMPOS DE EDICIÓN ---
              _campo('Nombre', 'Escribe tu nombre', _nombreController),
              const SizedBox(height: 10),
              _campo('Avatar', 'Nombre del avatar', _avatarController),
              const SizedBox(height: 10),
              _campo('Correo', 'ejemplo@correo.com', _correoController),
              const SizedBox(height: 10),
              _campo('Contraseña', '******', _contrasenaController,
                  obscure: true),
              const SizedBox(height: 10),
              _campo('Nacionalidad', 'País de origen', _nacionalidadController),

              const SizedBox(height: 25),

              //  APARTADO: Notificaciones (Switch)
              _seccionNotificaciones(),
              const SizedBox(height: 15),

              //  APARTADO: Términos y Condiciones
              _seccionTerminos(context),
              const SizedBox(height: 25),

              // --- BOTÓN GUARDAR (Visible con el scroll) ---
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent.withOpacity(0.4),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Lógica de Guardado
                  setState(() {
                    nombreJugador = _nombreController.text;
                    avatarJugador = _avatarController.text;
                    correoJugador = _correoController.text;
                    contrasenaJugador = _contrasenaController.text;
                    nacionalidadJugador = _nacionalidadController.text;
                    notificacionesActivas =
                        _notificacionesActivasLocal; // Actualiza global
                  });

                  Navigator.of(context).pop(); //  Cierra el diálogo
                },
                child: const Text('Guardar'),
              ),

              const SizedBox(height: 15),

              //  BOTÓN Dar de Baja Cuenta
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.withOpacity(0.3),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  //  Lógica de Advertencia y Eliminación
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      title: const Text(
                        "Advertencia de Eliminación",
                        style: TextStyle(color: Colors.redAccent),
                      ),
                      content: const Text(
                        "Al dar de baja tu cuenta, enfrentarás una pérdida de datos "
                        "permanente y no habrá reembolso de items pagados. ¿Deseas continuar?",
                        style: TextStyle(color: Colors.white70),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Simulación de eliminación si el usuario confirma
                            setState(() {
                              cuentaEliminada = true;
                            });
                            Navigator.of(context)
                                .pop(); // Cierra el AlertDialog
                            Navigator.of(context)
                                .pop(); // Cierra el InformacionPerfil Dialog
                          },
                          child: const Text("Sí, Dar de Baja",
                              style: TextStyle(color: Colors.redAccent)),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancelar",
                              style: TextStyle(color: Colors.cyanAccent)),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Dar de Baja Cuenta'),
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  // --- HELPERS (Funciones de Soporte) ---

  // Switch de Notificaciones
  Widget _seccionNotificaciones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Notificaciones Activas',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        Switch(
          value: _notificacionesActivasLocal,
          activeColor: Colors.cyanAccent,
          onChanged: (bool value) {
            setState(() {
              _notificacionesActivasLocal = value;
            });
          },
        ),
      ],
    );
  }

  //  Botón de Términos y condiciones
  Widget _seccionTerminos(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.black87,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: const Text(
              'Términos y Condiciones',
              style: TextStyle(color: Colors.cyanAccent),
            ),
            content: const Text(
              'Al usar esta aplicación aceptas que los datos mostrados '
              'son de carácter informativo y pueden cambiar en futuras versiones.',
              style: TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Aceptar',
                    style: TextStyle(color: Colors.cyanAccent)),
              ),
            ],
          ),
        );
      },
      child: const Text(
        'Acceder a Términos y Condiciones',
        style: TextStyle(
            color: Colors.cyanAccent, decoration: TextDecoration.underline),
      ),
    );
  }

  ///  Campo reutilizable
  Widget _campo(String label, String hint, TextEditingController controller,
      {bool obscure = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType:
          label == 'Nivel' ? TextInputType.number : TextInputType.text,
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
