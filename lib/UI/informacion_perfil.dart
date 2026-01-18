import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neoaztlan/State/player_state.dart';


Map<String, dynamic> _valoresIniciales = {};

class InformacionPerfil extends ConsumerStatefulWidget {
  const InformacionPerfil({super.key});

  @override
  ConsumerState<InformacionPerfil> createState() => _InformacionPerfilState();
}

class _InformacionPerfilState extends ConsumerState<InformacionPerfil> {
  late TextEditingController _nombreController;
  late TextEditingController _avatarController;
  late TextEditingController _correoController;
  late TextEditingController _contrasenaController;
  late TextEditingController _nacionalidadController;

  late bool _notificacionesActivasLocal;
  late bool _cuentaEliminadaLocal;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController();
    _avatarController = TextEditingController();
    _correoController = TextEditingController();
    _contrasenaController = TextEditingController();
    _nacionalidadController = TextEditingController();

    _notificacionesActivasLocal = false;
    _cuentaEliminadaLocal = false;
    _nombreController.addListener(() => setState(() {}));
    _avatarController.addListener(() => setState(() {}));
    _correoController.addListener(() => setState(() {}));
    _contrasenaController.addListener(() => setState(() {}));
    _nacionalidadController.addListener(() => setState(() {}));
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final data = ref.read(PlayerProvider);
    _nombreController.text = data.nombre;
    _avatarController.text = data.avatarNombre;
    _correoController.text = data.correo;
    _nacionalidadController.text = data.nacionalidad;
    _contrasenaController.text = '';
    _notificacionesActivasLocal = data.notificacionesActivas;
    _valoresIniciales = {
      'nombre': data.nombre,
      'avatar': data.avatarNombre,
      'correo': data.correo,
      'nacionalidad': data.nacionalidad,
    };
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
    final playerNotifier = ref.read(PlayerProvider.notifier);
    return Container(
      width: 400,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.cyanAccent.withOpacity(0.8), width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Editar Perfil',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyanAccent)),
          const SizedBox(height: 20),

          Flexible(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  _campo(_nombreController, 'Nombre', 'nombre'),
                  _campo(_avatarController, 'Nombre de Avatar', 'avatar'),
                  _campo(_correoController, 'Correo Electrónico', 'correo'),
                  _campo(_contrasenaController, 'Nueva Contraseña', 'contrasena',
                      obscure: true),
                  _campo(_nacionalidadController, 'Nacionalidad', 'nacionalidad'),
                  _seccionNotificaciones(),
                  _seccionTerminos(),
                  _seccionEliminarCuenta(),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  playerNotifier.updateProfile(
                    nombre: _nombreController.text,
                    avatarNombre: _avatarController.text,
                    correo: _correoController.text,
                    nacionalidad: _nacionalidadController.text,
                    notificacionesActivas: _notificacionesActivasLocal,
                  );

                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  foregroundColor: Colors.black,
                ),
                child: const Text('Guardar Cambios'),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _seccionNotificaciones() {
    return SwitchListTile(
      title: const Text('Notificaciones Activas', style: TextStyle(color: Colors.white)),
      subtitle: Text(_notificacionesActivasLocal ? 'Activadas' : 'Desactivadas',
          style: TextStyle(
              color: _notificacionesActivasLocal ? Colors.greenAccent : Colors.redAccent)),
      value: _notificacionesActivasLocal,
      onChanged: (bool value) {
        setState(() {
          _notificacionesActivasLocal = value;
        });
      },
      activeColor: Colors.cyanAccent,
    );
  }

  Widget _seccionTerminos() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextButton(
        onPressed: () {},
        child: const Text('Leer Términos y Condiciones',
            style: TextStyle(color: Colors.cyanAccent)),
      ),
    );
  }

  Widget _seccionEliminarCuenta() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextButton.icon(
        onPressed: () {
          setState(() {
            _cuentaEliminadaLocal = true;
          });
        },
        icon: Icon(Icons.delete_forever,
            color: _cuentaEliminadaLocal ? Colors.grey : Colors.redAccent),
        label: Text(
          _cuentaEliminadaLocal ? 'Cuenta Marcada para Eliminación' : 'Eliminar Cuenta',
          style: TextStyle(
              color: _cuentaEliminadaLocal ? Colors.grey : Colors.redAccent),
        ),
      ),
    );
  }

  Widget _campo(
      TextEditingController controller, String label, String key, {bool obscure = false}) {
    final valorOriginal = _valoresIniciales[key] ?? '';
    final isEdited = controller.text.isNotEmpty && valorOriginal != controller.text;

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
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
              hintText: 'Ingresa tu $label',
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
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 4.0, bottom: 8.0),
            child: Text(
              isEdited
                  ? 'Nuevo valor ingresado.'
                  : (valorOriginal.isNotEmpty && key != 'contrasena')
                  ? 'Valor actual: $valorOriginal'
                  : 'Valor actual.',
              style: TextStyle(
                color: isEdited ? Colors.yellow.shade200 : Colors.white54,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}