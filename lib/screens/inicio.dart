import 'package:flutter/material.dart';
import 'package:neoaztlan/screens/community_screen.dart';
import 'package:neoaztlan/screens/home_screen.dart';
import 'package:neoaztlan/screens/neodex_screen.dart';
import 'package:neoaztlan/screens/play_screen.dart';
import 'package:neoaztlan/screens/shop_screen.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
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
