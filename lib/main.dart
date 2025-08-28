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
    NeoDexScreen(),
    PlayScreen(),
    CommunityScreen(),
    ShopScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories),
            label: 'NeoDex',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: 'Jugar',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Comunidad'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Tienda',
          ),
        ],
      ),
    );
  }
}
