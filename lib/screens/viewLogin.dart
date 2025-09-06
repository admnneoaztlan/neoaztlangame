import 'package:flutter/material.dart';
import 'package:neoaztlan/backend/widgets/correo.dart';
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Facebook(),
            Google(),
          ],
        ),
      ),
    );
  }
}
