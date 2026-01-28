import 'package:flutter/material.dart';
import 'dart:ui'; // Para el ImageFilter (blur)

class AjustesScreen extends StatefulWidget {
  const AjustesScreen({super.key});

  @override
  State<AjustesScreen> createState() => _AjustesScreenState();
}

class _AjustesScreenState extends State<AjustesScreen> {
  // --- ESTADOS (Equivalente a useState) ---
  double musicVolume = 70;
  double sfxVolume = 85;
  double voiceVolume = 100;
  bool vibration = true;
  String graphicsQuality = "high"; // low, medium, high
  bool neonEffects = true;
  bool batterySaver = false;
  bool fps60 = true;
  bool notifConstruction = true;
  bool notifTroops = true;
  bool notifAttack = true;
  bool notifAlliance = true;
  bool notifRewards = true;
  bool confirmPurchases = true;
  bool allianceChat = true;
  bool showEnemyPower = true;

  // Color Neón Principal
  final Color neonCyan = const Color(0xFF00E5FF); // Cyan brillante
  final Color bgBlack = const Color(0xFF050505);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      body: Stack(
        children: [
          // 1. FONDO CON GRID (Background effects)
          Positioned.fill(
            child: CustomPaint(
              painter: GridPainter(color: neonCyan.withOpacity(0.05)),
            ),
          ),

          // 2. CONTENIDO PRINCIPAL
          Column(
            children: [
              // --- HEADER ---
              _buildHeader(context),

              // --- LISTA SCROLLABLE ---
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SECCIÓN AUDIO
                      _buildSectionTitle("Audio"),
                      _buildAudioControls(),

                      // SECCIÓN GRÁFICOS
                      _buildSectionTitle("Gráficos"),
                      _buildGraphicsControls(),

                      // SECCIÓN NOTIFICACIONES
                      _buildSectionTitle("Notificaciones"),
                      _buildNotificationControls(),

                      // SECCIÓN JUEGO
                      _buildSectionTitle("Juego"),
                      _buildGameControls(),

                      // SECCIÓN CUENTA
                      _buildSectionTitle("Cuenta"),
                      _buildAccountControls(),

                      // BOTÓN CERRAR SESIÓN
                      const SizedBox(height: 30),
                      _buildLogoutButton(),

                      // VERSIÓN
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          "NEOAZTLAN v1.2.4 (Build 2177)",
                          style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 10),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // 3. CAPA CRT / SCANLINES (Overlay)
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.1),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
                child: CustomPaint(painter: ScanlinePainter()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGETS AUXILIARES ---

  Widget _buildHeader(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: const EdgeInsets.only(top: 50, bottom: 15, left: 16, right: 16),
          decoration: BoxDecoration(
            color: bgBlack.withOpacity(0.8),
            border: Border(bottom: BorderSide(color: neonCyan.withOpacity(0.2))),
          ),
          child: Row(
            children: [
              // Botón Atrás
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: neonCyan.withOpacity(0.4), width: 2),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                  ),
                  child: Icon(Icons.arrow_back_ios_new, color: neonCyan, size: 18),
                ),
              ),
              const SizedBox(width: 15),
              // Título
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "AJUSTES",
                    style: TextStyle(
                      color: neonCyan,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      shadows: [
                        Shadow(color: neonCyan.withOpacity(0.5), blurRadius: 10),
                      ],
                    ),
                  ),
                  Text(
                    "TLAHTOLNAHUATILLI",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 10,
                      letterSpacing: 3,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 10, left: 4),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Colors.white.withOpacity(0.5),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  // --- COMPONENTES DE CONTROL ---

  Widget _buildAudioControls() {
    return Column(
      children: [
        _buildVolumeSlider("Música", Icons.music_note, musicVolume, (v) => setState(() => musicVolume = v)),
        const SizedBox(height: 8),
        _buildVolumeSlider("Efectos", Icons.volume_up, sfxVolume, (v) => setState(() => sfxVolume = v)),
        const SizedBox(height: 8),
        _buildVolumeSlider("Voces", Icons.record_voice_over, voiceVolume, (v) => setState(() => voiceVolume = v)),
        const SizedBox(height: 8),
        _buildSettingRow(
          icon: Icons.vibration,
          label: "Vibración",
          trailing: _buildSwitch(vibration, (v) => setState(() => vibration = v)),
        ),
      ],
    );
  }

  Widget _buildGraphicsControls() {
    return Column(
      children: [
        // Selector de Calidad (Low/Med/High)
        Container(
          padding: const EdgeInsets.all(12),
          decoration: _boxDecoration(),
          child: Column(
            children: [
              Row(
                children: [
                  _iconBox(Icons.monitor),
                  const SizedBox(width: 12),
                  const Text("Calidad", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _qualityButton("Baja", "low"),
                  const SizedBox(width: 8),
                  _qualityButton("Media", "medium"),
                  const SizedBox(width: 8),
                  _qualityButton("Alta", "high"),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _buildSettingRow(
          icon: Icons.bolt,
          label: "Efectos Neón",
          sublabel: "Brillos y resplandores",
          trailing: _buildSwitch(neonEffects, (v) => setState(() => neonEffects = v)),
        ),
        const SizedBox(height: 8),
        _buildSettingRow(
          icon: Icons.battery_saver,
          label: "Ahorro de batería",
          sublabel: "Reduce efectos visuales",
          trailing: _buildSwitch(batterySaver, (v) => setState(() => batterySaver = v)),
        ),
        const SizedBox(height: 8),
        _buildSettingRow(
          icon: Icons.smartphone,
          label: "60 FPS",
          sublabel: "Mayor fluidez",
          trailing: _buildSwitch(fps60, (v) => setState(() => fps60 = v)),
        ),
      ],
    );
  }

  Widget _buildNotificationControls() {
    return Column(
      children: [
        _buildSettingRow(
            icon: Icons.notifications, label: "Construcción completada",
            trailing: _buildSwitch(notifConstruction, (v) => setState(() => notifConstruction = v))),
        const SizedBox(height: 8),
        _buildSettingRow(
            icon: Icons.notifications, label: "Tropas listas",
            trailing: _buildSwitch(notifTroops, (v) => setState(() => notifTroops = v))),
        const SizedBox(height: 8),
        _buildSettingRow(
            icon: notifAttack ? Icons.notifications_active : Icons.notifications_off, label: "Ataque enemigo",
            trailing: _buildSwitch(notifAttack, (v) => setState(() => notifAttack = v))),
        const SizedBox(height: 8),
        _buildSettingRow(
            icon: Icons.notifications, label: "Eventos de alianza",
            trailing: _buildSwitch(notifAlliance, (v) => setState(() => notifAlliance = v))),
        const SizedBox(height: 8),
        _buildSettingRow(
            icon: Icons.notifications, label: "Recompensas disponibles",
            trailing: _buildSwitch(notifRewards, (v) => setState(() => notifRewards = v))),
      ],
    );
  }

  Widget _buildGameControls() {
    return Column(
      children: [
        _buildSettingRow(
            icon: Icons.refresh, label: "Reiniciar tutorial", showArrow: true, onTap: () {}),
        const SizedBox(height: 8),
        _buildSettingRow(
            icon: Icons.security, label: "Confirmar compras", sublabel: "Pedir confirmación antes",
            trailing: _buildSwitch(confirmPurchases, (v) => setState(() => confirmPurchases = v))),
        const SizedBox(height: 8),
        _buildSettingRow(
            icon: Icons.chat, label: "Chat de alianza",
            trailing: _buildSwitch(allianceChat, (v) => setState(() => allianceChat = v))),
        const SizedBox(height: 8),
        _buildSettingRow(
            icon: Icons.remove_red_eye, label: "Mostrar poder enemigo",
            trailing: _buildSwitch(showEnemyPower, (v) => setState(() => showEnemyPower = v))),
      ],
    );
  }

  Widget _buildAccountControls() {
    return Column(
      children: [
        _buildSettingRow(icon: Icons.person, label: "Vincular cuenta", sublabel: "Google, Apple, Facebook", showArrow: true, onTap: () {}),
        const SizedBox(height: 8),
        _buildSettingRow(icon: Icons.language, label: "Idioma", sublabel: "Español", showArrow: true, onTap: () {}),
        const SizedBox(height: 8),
        _buildSettingRow(icon: Icons.qr_code, label: "Centro de códigos", sublabel: "Canjear códigos promo", showArrow: true, onTap: () {}),
        const SizedBox(height: 8),
        _buildSettingRow(icon: Icons.help_outline, label: "Soporte / Ayuda", showArrow: true, onTap: () {}),
        const SizedBox(height: 8),
        _buildSettingRow(icon: Icons.description, label: "Términos y privacidad", showArrow: true, onTap: () {}),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0xFFFF003C).withOpacity(0.1), // Neon Red background
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFF003C).withOpacity(0.5), width: 2),
      ),
      child: TextButton.icon(
        onPressed: () {
          // Lógica de logout aquí
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.logout, color: Color(0xFFFF003C)),
        label: const Text(
          "CERRAR SESIÓN",
          style: TextStyle(color: Color(0xFFFF003C), fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
      ),
    );
  }

  // --- ELEMENTOS DE UI REUTILIZABLES ---

  // Slider de Volumen Customizado
  Widget _buildVolumeSlider(String label, IconData icon, double value, Function(double) onChanged) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _boxDecoration(),
      child: Column(
        children: [
          Row(
            children: [
              _iconBox(icon),
              const SizedBox(width: 12),
              Expanded(child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500))),
              Text("${value.toInt()}%", style: TextStyle(color: neonCyan, fontSize: 12)),
            ],
          ),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 6,
              activeTrackColor: neonCyan,
              inactiveTrackColor: Colors.white.withOpacity(0.2),
              thumbColor: Colors.black,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              overlayColor: neonCyan.withOpacity(0.2),
            ),
            child: Slider(
              value: value,
              min: 0,
              max: 100,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  // Fila de Ajuste Genérica
  Widget _buildSettingRow({
    required IconData icon,
    required String label,
    String? sublabel,
    Widget? trailing,
    bool showArrow = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: _boxDecoration(),
        child: Row(
          children: [
            _iconBox(icon),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                  if (sublabel != null)
                    Text(sublabel, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 11)),
                ],
              ),
            ),
            if (trailing != null) trailing,
            if (showArrow) Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.3)),
          ],
        ),
      ),
    );
  }

  // Botón de Calidad Gráfica
  Widget _qualityButton(String text, String value) {
    bool isSelected = graphicsQuality == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => graphicsQuality = value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? neonCyan : Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected ? [BoxShadow(color: neonCyan.withOpacity(0.5), blurRadius: 10)] : [],
          ),
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white.withOpacity(0.6),
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }

  // Switch Customizado (Estilo Pastilla)
  Widget _buildSwitch(bool value, Function(bool) onChanged) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 50,
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: value ? neonCyan : Colors.white.withOpacity(0.2),
          boxShadow: value ? [BoxShadow(color: neonCyan.withOpacity(0.5), blurRadius: 10)] : [],
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              left: value ? 24 : 2,
              top: 2,
              child: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Decoración de Caja común (Border + Fondo)
  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.05),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.white.withOpacity(0.1)),
    );
  }

  // Caja para Íconos
  Widget _iconBox(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: neonCyan.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: neonCyan, size: 20),
    );
  }
}

// --- PAINTERS PARA EFECTOS VISUALES ---

// Dibuja la cuadrícula de fondo
class GridPainter extends CustomPainter {
  final Color color;
  GridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    const double spacing = 40.0;

    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Dibuja líneas de escaneo (Scanlines) estilo CRT
class ScanlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.1)
      ..strokeWidth = 1;

    for (double i = 0; i < size.height; i += 4) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}