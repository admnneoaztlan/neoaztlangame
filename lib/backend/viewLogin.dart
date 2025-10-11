import 'package:flutter/material.dart';
import 'package:neoaztlan/backend/widgets/facebook.dart';
import 'package:neoaztlan/backend/widgets/google.dart';

class Viewlogin extends StatefulWidget {
  const Viewlogin({super.key});

  @override
  State<Viewlogin> createState() => _ViewloginState();
}

class _ViewloginState extends State<Viewlogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Inicia Sesión en Neoaztlan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Facebook(),

            const SizedBox(height: 10), // Espacio entre botones

            Google(),
          ],
        ),
      ),
    );
  }
}
