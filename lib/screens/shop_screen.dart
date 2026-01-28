import 'package:flutter/material.dart';
import 'dart:ui'; // Para el Blur

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  // Estado para las Tabs: "cofres", "recursos", "tributos"
  String activeTab = "cofres";

  // Colores del Tema
  final Color neonCyan = const Color(0xFF00E5FF);
  final Color neonGold = const Color(0xFFFFD700);
  final Color neonPurple = const Color(0xFFD500F9);
  final Color neonRed = const Color(0xFFFF1744);
  final Color neonEmerald = const Color(0xFF00E676);
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
          // Glow dorado de fondo (simulando el div blur-3xl)
          Positioned(
            left: MediaQuery.of(context).size.width * 0.25,
            top: MediaQuery.of(context).size.height * 0.3,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: neonGold.withOpacity(0.05),
              ),
            ),
          ),
          // Blur fuerte para el glow
          Positioned.fill(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  child: Container(color: Colors.transparent))),

          // 2. CONTENIDO PRINCIPAL
          Column(
            children: [
              // --- HEADER ---
              _buildHeader(context),

              // --- TABS ---
              _buildTabs(),

              // --- CONTENIDO SCROLLABLE ---
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  child: _buildContent(),
                ),
              ),
            ],
          ),

          // 3. CAPA CRT / SCANLINES (Overlay)
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(painter: ScanlinePainter()),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGETS PRINCIPALES ---

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "BÓVEDA",
                    style: TextStyle(
                      color: neonGold,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      shadows: [Shadow(color: neonGold.withOpacity(0.5), blurRadius: 10)],
                    ),
                  ),
                  Text(
                    "TEOCALLI DIGITAL",
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

  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: neonCyan.withOpacity(0.1))),
      ),
      child: Row(
        children: [
          _buildTabBtn("cofres", "Cofres", Icons.diamond),
          const SizedBox(width: 10),
          _buildTabBtn("recursos", "Recursos", Icons.flash_on),
          const SizedBox(width: 10),
          _buildTabBtn("tributos", "Tributos", Icons.card_giftcard),
        ],
      ),
    );
  }

  Widget _buildTabBtn(String id, String label, IconData icon) {
    bool isActive = activeTab == id;
    return GestureDetector(
      onTap: () => setState(() => activeTab = id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? neonCyan.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isActive ? [BoxShadow(color: neonCyan.withOpacity(0.3), blurRadius: 10)] : [],
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: isActive ? neonCyan : Colors.white.withOpacity(0.5)),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isActive ? neonCyan : Colors.white.withOpacity(0.5),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (activeTab == "cofres") return _buildCofresContent();
    if (activeTab == "recursos") return _buildRecursosContent();
    if (activeTab == "tributos") return _buildTributosContent();
    return Container();
  }

  // --- CONTENIDO: COFRES ---
  Widget _buildCofresContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("COFRES SAGRADOS"),
        const SizedBox(height: 10),
        // Grid de Cofres (Usamos Wrap o GridView, aquí Wrap para fluidez)
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildChestCard("Jade", "jade", timeLeft: "2h 15m"),
            _buildChestCard("Obsidiana", "obsidiana", isReady: true),
            _buildChestCard("Oro Solar", "oro", timeLeft: "5h 45m"),
            _buildChestCard("Jade", "jade", isLocked: true),
            _buildChestCard("Jade", "jade", isLocked: true),
            _buildChestCard("Jade", "jade", isLocked: true),
          ],
        ),
        const SizedBox(height: 20),
        _sectionTitle("RELIQUIAS"),
        const SizedBox(height: 10),
        _buildRelicCard(),
      ],
    );
  }

  // --- CONTENIDO: RECURSOS ---
  Widget _buildRecursosContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("MONEDAS"),
        const SizedBox(height: 10),
        Column(
          children: [
            _buildResourceRow(
              icon: Container(
                  width: 24, height: 24,
                  decoration: BoxDecoration(color: neonGold, shape: BoxShape.circle)
              ),
              name: "Teocuitlatl", amount: "12,547", color: neonGold,
            ),
            const SizedBox(height: 10),
            _buildResourceRow(
              icon: Icon(Icons.diamond, color: neonEmerald),
              name: "Chalchiuitl", amount: "89", color: neonEmerald,
            ),
            const SizedBox(height: 10),
            _buildResourceRow(
              icon: Icon(Icons.flash_on, color: neonCyan),
              name: "Nanochips", amount: "1,234", color: neonCyan,
            ),
          ],
        ),
        const SizedBox(height: 20),
        _sectionTitle("MATERIALES"),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 2.5,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            _buildMaterialCard(Colors.redAccent, "Obsidiana", "x 456"),
            _buildMaterialCard(Colors.blueAccent, "Jade Cyber", "x 123"),
            _buildMaterialCard(Colors.amber, "Plumas Sol", "x 78"),
            _buildMaterialCard(Colors.cyan, "Circuitos", "x 234"),
          ],
        ),
      ],
    );
  }

  // --- CONTENIDO: TRIBUTOS ---
  Widget _buildTributosContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _sectionTitle("TRIBUTO DIARIO"),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: neonCyan),
                const SizedBox(width: 4),
                Text("Día 5 de 7", style: TextStyle(color: neonCyan, fontSize: 12)),
              ],
            )
          ],
        ),
        const SizedBox(height: 10),
        // Fila de recompensas diarias
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildDailyItem(1, "500", true, false),
              _buildDailyItem(2, "750", true, false),
              _buildDailyItem(3, "1K", true, false),
              _buildDailyItem(4, "1.5K", true, false),
              _buildDailyItem(5, "2K", false, true), // Actual
              _buildDailyItem(6, "3K", false, false),
              _buildDailyItem(7, "5K", false, false),
            ],
          ),
        ),
        const SizedBox(height: 15),
        // Botón reclamar
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: neonGold.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: neonGold),
            boxShadow: [BoxShadow(color: neonGold.withOpacity(0.4), blurRadius: 20)],
          ),
          child: Center(
            child: Text(
              "RECLAMAR TRIBUTO DEL DÍA 5",
              style: TextStyle(color: neonGold, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ),
        const SizedBox(height: 25),
        _sectionTitle("OFRENDA SEMANAL"),
        const SizedBox(height: 10),
        _buildProgressBarCard(
          title: "Completa 20 misiones",
          subtitle: "Recompensa: Cofre de Oro Solar",
          progress: "14/20",
          percentage: 0.7,
        ),
        const SizedBox(height: 20),
        _sectionTitle("CALENDARIO LUNAR"),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: neonPurple.withOpacity(0.05),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: neonPurple.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 45, height: 45,
                decoration: BoxDecoration(
                  color: neonPurple.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: neonPurple.withOpacity(0.5)),
                ),
                child: const Center(child: Text("🌙", style: TextStyle(fontSize: 20))),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Luna de Mictlán", style: TextStyle(color: neonPurple, fontWeight: FontWeight.bold)),
                  Text("Evento especial en 2 días", style: TextStyle(color: Colors.white54, fontSize: 11)),
                  Text("x2 recompensas en Arena", style: TextStyle(color: neonPurple.withOpacity(0.7), fontSize: 10)),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  // --- HELPERS (COMPONENTES) ---

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.white.withOpacity(0.7), fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.5),
    );
  }

  Widget _buildChestCard(String name, String rarity, {String? timeLeft, bool isLocked = false, bool isReady = false}) {
    Color color;
    Color glowColor;
    switch (rarity) {
      case 'jade':
        color = neonEmerald;
        glowColor = neonEmerald.withOpacity(0.4);
        break;
      case 'obsidiana':
        color = neonPurple;
        glowColor = neonPurple.withOpacity(0.4);
        break;
      case 'oro':
        color = neonGold;
        glowColor = neonGold.withOpacity(0.4);
        break;
      default:
        color = Colors.white;
        glowColor = Colors.white.withOpacity(0.2);
    }

    // Calculamos el ancho para que quepan 3 en fila (aproximado)
    double width = (MediaQuery.of(context).size.width - 32 - 24) / 3;

    return Container(
      width: width,
      height: width * 1.2,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.6), width: 2),
        boxShadow: [BoxShadow(color: glowColor, blurRadius: 15)],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.diamond, color: color, size: 28),
              const SizedBox(height: 8),
              Text(name, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
              if (timeLeft != null && !isReady) ...[
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.access_time, color: Colors.white60, size: 10),
                    const SizedBox(width: 2),
                    Text(timeLeft, style: const TextStyle(color: Colors.white60, fontSize: 10)),
                  ],
                )
              ],
              if (isReady)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text("ABRIR", style: TextStyle(color: neonCyan, fontWeight: FontWeight.bold, fontSize: 10)),
                )
            ],
          ),
          if (isLocked)
            Container(
              decoration: BoxDecoration(
                color: bgBlack.withOpacity(0.8),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Center(child: Icon(Icons.lock, color: Colors.white38, size: 30)),
            ),
          if (isReady)
            Positioned(
              top: -5, right: -5,
              child: Container(
                width: 20, height: 20,
                decoration: BoxDecoration(color: neonRed, shape: BoxShape.circle, boxShadow: [BoxShadow(color: neonRed, blurRadius: 10)]),
                child: const Center(child: Text("!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildRelicCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: neonCyan.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: neonCyan.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      color: neonGold.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.star, color: neonGold),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Fragmentos del Códice", style: TextStyle(color: neonGold, fontWeight: FontWeight.bold)),
                      Text("12/50 para héroe legendario", style: TextStyle(color: Colors.white54, fontSize: 10)),
                    ],
                  ),
                ],
              ),
              Text("24%", style: TextStyle(color: neonCyan, fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.24,
              minHeight: 8,
              backgroundColor: Colors.white10,
              valueColor: AlwaysStoppedAnimation<Color>(neonGold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourceRow({required Widget icon, required String name, required String amount, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: bgBlack.withOpacity(0.5), borderRadius: BorderRadius.circular(10)),
            child: Center(child: icon),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name.toUpperCase(), style: const TextStyle(color: Colors.white70, fontSize: 10, letterSpacing: 1)),
              Text(amount, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMaterialCard(Color color, String name, String amount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        children: [
          Container(width: 30, height: 30, decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(5))),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
              Text(amount, style: const TextStyle(color: Colors.white54, fontSize: 10)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDailyItem(int day, String reward, bool isClaimed, bool isCurrent) {
    Color borderColor = isCurrent ? neonGold : (isClaimed ? Colors.white24 : neonCyan.withOpacity(0.3));
    Color bgColor = isCurrent ? neonGold.withOpacity(0.2) : (isClaimed ? Colors.white10 : neonCyan.withOpacity(0.05));

    return Container(
      width: 55, height: 70,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
        boxShadow: isCurrent ? [BoxShadow(color: neonGold.withOpacity(0.4), blurRadius: 15)] : [],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Día $day", style: const TextStyle(color: Colors.white60, fontSize: 9)),
          const SizedBox(height: 4),
          Text(reward, style: TextStyle(color: isCurrent ? neonGold : neonCyan, fontWeight: FontWeight.bold, fontSize: 12)),
          if (isClaimed) ...[
            const SizedBox(height: 2),
            Icon(Icons.star, color: neonGold, size: 10),
          ]
        ],
      ),
    );
  }

  Widget _buildProgressBarCard({required String title, required String subtitle, required String progress, required double percentage}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: neonCyan.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: neonCyan.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: neonCyan, fontWeight: FontWeight.bold, fontSize: 12)),
                  Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 10)),
                ],
              ),
              Text(progress, style: TextStyle(color: neonGold, fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: percentage,
              minHeight: 8,
              backgroundColor: Colors.white10,
              valueColor: AlwaysStoppedAnimation<Color>(neonGold), // Usamos gradiente simulado
            ),
          ),
        ],
      ),
    );
  }
}

// --- PAINTERS (IGUAL QUE EN AJUSTES) ---

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