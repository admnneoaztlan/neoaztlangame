import 'package:flutter/material.dart';

// ==========================================================
//  VARIABLES GLOBALES
//
// ==========================================================
String nombreJugador = 'Jugador 1';
String avatarJugador = 'avatar_default.png';
String correoJugador = 'correo@ejemplo.com';
String contrasenaJugador = '123456';
String nacionalidadJugador = 'México';
bool cuentaEliminada = false;
bool notificacionesActivas = true;
// ==========================================================

//  Este mapa guarda los valores ANTERIORES al editarse .
Map<String, dynamic> _valoresIniciales = {};

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

  // Variable local para manejar el estado del Switch y de la cuenta.
  late bool _notificacionesActivasLocal;
  late bool _cuentaEliminadaLocal; // Para mostrar el estado en el botón

  // Creamos un controlador de scroll
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    //  Almacenar los valores INICIALES al abrir el formulario
    _valoresIniciales = {
      'nombre': nombreJugador,
      'avatar': avatarJugador,
      'correo': correoJugador,
      'contrasena': contrasenaJugador,
      'nacionalidad': nacionalidadJugador,
      'notificaciones': notificacionesActivas,
      'eliminada': cuentaEliminada,
    };

    // Inicializamos controladores con los valores actuales (globales)
    _nombreController = TextEditingController(text: nombreJugador);
    _avatarController = TextEditingController(text: avatarJugador);
    _correoController = TextEditingController(text: correoJugador);
    _contrasenaController = TextEditingController(text: contrasenaJugador);
    _nacionalidadController = TextEditingController(text: nacionalidadJugador);

    // Inicializamos variables locales para los Toggles
    _notificacionesActivasLocal = notificacionesActivas;
    _cuentaEliminadaLocal = cuentaEliminada;

    //  Añadir listeners AQUI (solo una vez)
    // Esto obliga a llamar a setState() cada vez que el texto cambia,
    // actualizando el mensaje de "Valor anterior" en tiempo real.
    _nombreController.addListener(() => setState(() {}));
    _avatarController.addListener(() => setState(() {}));
    _correoController.addListener(() => setState(() {}));
    _contrasenaController.addListener(() => setState(() {}));
    _nacionalidadController.addListener(() => setState(() {}));
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
        thickness: 6.0, // Scrollbar más delgado pero visible
        radius: const Radius.circular(10),
        trackVisibility: true,
        scrollbarOrientation: ScrollbarOrientation.right,

        child: SingleChildScrollView(
          controller: _scrollController,
          // Padding interno para que el scrollbar no se pegue al texto
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
              _campo(
                  'Nombre', 'Escribe tu nombre', _nombreController, 'nombre'),
              _campo(
                  'Avatar', 'Nombre del avatar', _avatarController, 'avatar'),
              _campo(
                  'Correo', 'ejemplo@correo.com', _correoController, 'correo'),
              _campo(
                  'Contraseña', '******', _contrasenaController, 'contrasena',
                  obscure: true),
              _campo('Nacionalidad', 'País de origen', _nacionalidadController,
                  'nacionalidad'),

              const SizedBox(height: 25),

              // APARTADO: Notificaciones
              _seccionNotificaciones(),
              const SizedBox(height: 15),

              //  APARTADO: Términos y Condiciones
              _seccionTerminos(context),
              const SizedBox(height: 25),

              // --- BOTÓN GUARDAR ---
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent.withOpacity(0.4),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Lógica de Guardado: Actualiza las variables globales
                  setState(() {
                    nombreJugador = _nombreController.text;
                    avatarJugador = _avatarController.text;
                    correoJugador = _correoController.text;
                    contrasenaJugador = _contrasenaController.text;
                    nacionalidadJugador = _nacionalidadController.text;
                    notificacionesActivas = _notificacionesActivasLocal;
                  });

                  Navigator.of(context).pop(); // Cierra el diálogo
                },
                child: const Text('Guardar'),
              ),

              const SizedBox(height: 15),

              //  BOTÓN Dar de Baja Cuenta
              _seccionEliminarCuenta(context),

              const SizedBox(height: 50), // Espacio extra para el scroll final
            ],
          ),
        ),
      ),
    );
  }

  // --- HELPERS (Funciones de Soporte) ---

  //  Sección de Notificaciones
  Widget _seccionNotificaciones() {
    final original = _valoresIniciales['notificaciones'] as bool;
    final estadoOriginal = original ? 'Activas' : 'Inactivas';
    final estadoActual = _notificacionesActivasLocal ? 'Activas' : 'Inactivas';
    final isChanged = original != _notificacionesActivasLocal;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Notificaciones Activas',
              style: TextStyle(color: Colors.white, fontSize: 14),
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
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
          child: Text(
            isChanged
                ? 'Original: $estadoOriginal'
                : 'Estado: $estadoActual (Sin cambios)',
            style: TextStyle(
              color: isChanged ? Colors.yellow.shade200 : Colors.white54,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  // Botón de Términos
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

  //  Sección Eliminar Cuenta
  Widget _seccionEliminarCuenta(BuildContext context) {
    final original = _valoresIniciales['eliminada'] as bool;
    final estadoOriginal = original ? 'Sí (Eliminada)' : 'No (Activa)';
    final isChanged = original != _cuentaEliminadaLocal;

    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.withOpacity(0.3),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            // Lógica de Advertencia y Eliminación
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
                        _cuentaEliminadaLocal = true;
                      });
                      Navigator.of(context).pop(); // Cierra el AlertDialog
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
        Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
          child: Text(
            'Estado anterior: $estadoOriginal. Modificación: ${isChanged ? 'Dada de baja' : 'Ninguna'}',
            style: TextStyle(
              color: isChanged ? Colors.yellow.shade200 : Colors.white54,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  /// Campo reutilizable
  Widget _campo(String label, String hint, TextEditingController controller,
      String key, // Parámetro 'key' para buscar en el mapa inicial
      {bool obscure = false}) {
    // Obtener el valor original del mapa
    final valorOriginal = _valoresIniciales[key] ?? '';
    final isEdited =
        valorOriginal != controller.text; // Comprobar si fue editado

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: TextInputType.text,
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
        ),
        // 💡 Mostrar el valor anterior
        Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 4.0, bottom: 8.0),
          child: Text(
            isEdited ? 'Valor anterior: $valorOriginal' : 'Valor actual.',
            style: TextStyle(
              color: isEdited ? Colors.yellow.shade200 : Colors.white54,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
