import 'package:flutter/material.dart';
import 'dart:ui'; // Para el Blur

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with SingleTickerProviderStateMixin {
  bool soundOn = true;

  // Colores del Tema (Coherencia visual)
  final Color neonCyan = const Color(0xFF00E5FF);
  final Color neonGold = const Color(0xFFFFD700);
  final Color neonRed = const Color(0xFFFF1744);
  final Color bgBlack = const Color(0xFF050505);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      body: Stack(
        children: [
          // 1. FONDO ANIMADO Y GLOWS
          // Grid
          Positioned.fill(
            child: CustomPaint(
              painter: GridPainter(color: neonCyan.withOpacity(0.05)),
            ),
          ),
          // Glow Cyan (Arriba Izquierda)
          Positioned(
            left: -50, top: 100,
            child: _buildAmbientGlow(neonCyan),
          ),
          // Glow Gold (Abajo Derecha)
          Positioned(
            right: -50, bottom: 150,
            child: _buildAmbientGlow(neonGold),
          ),
          // Blur general del fondo
          Positioned.fill(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  child: Container(color: Colors.transparent))),

          // 2. CONTENIDO PRINCIPAL (SafeArea para evitar notch)
          SafeArea(
            child: Column(
              children: [
                // --- TOP BAR (Recursos) ---
                _buildTopBar(),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        // --- TÍTULO ---
                        _buildTitleSection(),

                        const SizedBox(height: 40),

                        // --- MENÚ PRINCIPAL ---
                        // Botón Campaña (Destacado en Oro)
                        _buildMenuButton(
                          label: "CAMPAÑA",
                          sublabel: "Capítulo 7 - Tenochtitlán",
                          icon: Icons.map_outlined, // O Icons.swords si tienes un paquete externo
                          isMain: true,
                          onTap: () => Navigator.pushNamed(context, '/partida'),
                        ),
                        const SizedBox(height: 15),

                        // Botón Arena
                        _buildMenuButton(
                          label: "ARENA PVP",
                          sublabel: "Rango: Jaguar Élite",
                          icon: Icons.emoji_events_outlined,
                          badge: "3",
                          onTap: () { /* Acción futura */ },
                        ),
                        const SizedBox(height: 15),

                        // Botón Alianza
                        _buildMenuButton(
                          label: "ALIANZA",
                          sublabel: "Hijos del Quinto Sol",
                          icon: Icons.group_outlined,
                          badge: "!",
                          onTap: () { /* Acción futura */ },
                        ),
                        const SizedBox(height: 15),

                        // Botón Códices
                        _buildMenuButton(
                          label: "CÓDICES",
                          sublabel: "Colección de guerreros",
                          icon: Icons.auto_stories_outlined, // Icono de libro/rollo
                          onTap: () { /* Acción futura */ },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // --- BOTTOM BAR (Botones pequeños) ---
                _buildBottomBar(context),
              ],
            ),
          ),

          // 3. OVERLAY CRT (Scanlines + Viñeta)
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(painter: ScanlinePainter()),
            ),
          ),
          // Viñeta Oscura (Radial Gradient)
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 1.0,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.6),
                    ],
                    stops: const [0.6, 1.0],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGETS AUXILIARES ---

  Widget _buildAmbientGlow(Color color) {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.15),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Nivel Jugador
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bgBlack.withOpacity(0.8),
              border: Border.all(color: neonCyan.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(
                    color: neonGold.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(color: neonGold),
                  ),
                  child: Center(
                    child: Text("42", style: TextStyle(color: neonGold, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("TLATOANI", style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 9, letterSpacing: 1)),
                    Text("Guerrero Sol", style: TextStyle(color: neonCyan, fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                )
              ],
            ),
          ),

          // Recursos
          Row(
            children: [
              _buildResourcePill("ORO", "12.5K", neonGold, Icons.circle),
              const SizedBox(width: 8),
              _buildResourcePill("PODER", "847", neonCyan, Icons.flash_on),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildResourcePill(String label, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 8)),
              Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      children: [
        Text(
          "ANNO 2177",
          style: TextStyle(fontFamily: 'Courier', color: neonGold.withOpacity(0.8), letterSpacing: 5, fontSize: 10),
        ),
        const SizedBox(height: 5),
        Text(
          "NEOAZTLAN",
          style: TextStyle(
            color: neonCyan,
            fontSize: 42,
            fontWeight: FontWeight.w900,
            letterSpacing: 6,
            shadows: [
              Shadow(color: neonCyan.withOpacity(0.8), blurRadius: 20),
              Shadow(color: Colors.blueAccent.withOpacity(0.5), blurRadius: 40),
            ],
          ),
        ),
        // Separador Pirámide
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: 1, width: 40, decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, neonGold]))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.change_history, color: neonGold, size: 16), // Triángulo/Pirámide
            ),
            Container(height: 1, width: 40, decoration: BoxDecoration(gradient: LinearGradient(colors: [neonGold, Colors.transparent]))),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          "CONQUISTA EL IMPERIO DIGITAL",
          style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 10, letterSpacing: 3),
        ),
      ],
    );
  }

  Widget _buildMenuButton({
    required String label,
    required String sublabel,
    required IconData icon,
    required VoidCallback onTap,
    bool isMain = false,
    String? badge,
  }) {
    Color baseColor = isMain ? neonGold : neonCyan;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 320,
        margin: const EdgeInsets.symmetric(horizontal: 20), // Margen lateral
        padding: EdgeInsets.symmetric(vertical: isMain ? 18 : 14, horizontal: 20),
        decoration: BoxDecoration(
          color: isMain ? baseColor.withOpacity(0.15) : bgBlack.withOpacity(0.6),
          border: Border.all(color: baseColor.withOpacity(isMain ? 0.8 : 0.4), width: isMain ? 2 : 1),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: baseColor.withOpacity(isMain ? 0.25 : 0.1),
              blurRadius: isMain ? 20 : 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              children: [
                // Icon Box
                Container(
                  width: 45, height: 45,
                  decoration: BoxDecoration(
                    color: baseColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: baseColor.withOpacity(0.3)),
                  ),
                  child: Icon(icon, color: baseColor, size: 24),
                ),
                const SizedBox(width: 15),
                // Textos
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color: baseColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 1.5,
                        shadows: [Shadow(color: baseColor.withOpacity(0.6), blurRadius: 8)],
                      ),
                    ),
                    Text(
                      sublabel,
                      style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 11, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ],
            ),
            // Esquinas decorativas
            Positioned(top: -5, left: -5, child: _corner(baseColor)),
            Positioned(top: -5, right: -5, child: RotatedBox(quarterTurns: 1, child: _corner(baseColor))),
            Positioned(bottom: -5, left: -5, child: RotatedBox(quarterTurns: 3, child: _corner(baseColor))),
            Positioned(bottom: -5, right: -5, child: RotatedBox(quarterTurns: 2, child: _corner(baseColor))),

            // Badge (Notificación)
            if (badge != null)
              Positioned(
                right: -10,
                top: -10,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: neonRed,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: neonRed.withOpacity(0.8), blurRadius: 10)],
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _corner(Color color) {
    return SizedBox(
      width: 10, height: 10,
      child: CustomPaint(
        painter: CornerPainter(color: color),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: bgBlack.withOpacity(0.9),
        border: Border(top: BorderSide(color: neonCyan.withOpacity(0.2))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // Eliminamos "gap: 15" y usamos SizedBox
        children: [
          _smallButton(Icons.shopping_bag_outlined, "2", onTap: () {}),
          const SizedBox(width: 15), // Espaciado manual

          _smallButton(Icons.inventory_2_outlined, "1", onTap: () => Navigator.pushNamed(context, '/boveda')),
          const SizedBox(width: 15), // Espaciado manual

          _smallButton(Icons.settings_outlined, null, onTap: () => Navigator.pushNamed(context, '/ajustes')),
          const SizedBox(width: 15), // Espaciado manual

          _smallButton(
            soundOn ? Icons.volume_up : Icons.volume_off,
            null,
            onTap: () => setState(() => soundOn = !soundOn),
          ),
        ],
      ),
    );
  }
  Widget _smallButton(IconData icon, String? badge, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 55, height: 55,
            decoration: BoxDecoration(
              color: bgBlack.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: neonCyan.withOpacity(0.4), width: 2),
              boxShadow: [BoxShadow(color: neonCyan.withOpacity(0.1), blurRadius: 10)],
            ),
            child: Icon(icon, color: neonCyan, size: 24),
          ),
          if (badge != null)
            Positioned(
              right: -5, top: -5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: neonRed,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: neonRed.withOpacity(0.6), blurRadius: 5)],
                ),
                child: Text(badge, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            )
        ],
      ),
    );
  }
}

// --- PAINTERS (Reutilizados para coherencia) ---

class GridPainter extends CustomPainter {
  final Color color;
  GridPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..strokeWidth = 1;
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

class ScanlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withOpacity(0.05)..strokeWidth = 1;
    for (double i = 0; i < size.height; i += 4) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CornerPainter extends CustomPainter {
  final Color color;
  CornerPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}