import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/neodex_screen.dart';
import 'screens/play_screen.dart';
import 'screens/community_screen.dart';
import 'screens/shop_screen.dart';

void main() {
  runApp(NeoaztlanApp());
}

class NeoaztlanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neoaztlan Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    NeodexScreen(),
    PlayScreen(),
    CommunityScreen(),
    ShopScreen(),
  ];

  void _setActiveIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D1117),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF0B141D),
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MenuItem(
                index: 0,
                icon: Icons.home,
                label: 'Inicio',
                isActive: _currentIndex == 0,
                onTap: () => _setActiveIndex(0),
              ),
              MenuItem(
                index: 1,
                icon: Icons.apps,
                label: 'NeoDex',
                isActive: _currentIndex == 1,
                onTap: () => _setActiveIndex(1),
              ),
              // Espaciador para el botón de Batalla
              Container(),
              MenuItem(
                index: 3,
                icon: Icons.group,
                label: 'Clanes',
                isActive: _currentIndex == 3,
                onTap: () => _setActiveIndex(3),
              ),
              MenuItem(
                index: 4,
                icon: Icons.store,
                label: 'Tienda',
                isActive: _currentIndex == 4,
                onTap: () => _setActiveIndex(4),
              ),
            ],
          ),
        ),
      ),
      // Botón flotante de "Batalla"
      floatingActionButton: GestureDetector(
        onTap: () => _setActiveIndex(2),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFF0D1117),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.cyan.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 20,
              ),
            ],
          ),
          child: Icon(Icons.sports_esports, size: 50, color: Colors.cyan),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class MenuItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const MenuItem({
    required this.index,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: isActive ? Colors.cyan : Colors.white),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.cyan : Colors.white70,
              fontSize: 12,
            ),
          ),
          if (isActive)
            Container(
              margin: EdgeInsets.only(top: 5),
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.cyan,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
