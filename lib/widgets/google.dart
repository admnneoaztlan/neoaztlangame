import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neoaztlan/database/AuthServiceGoogle.dart';
import 'package:neoaztlan/screens/community_screen.dart';

class Google extends StatelessWidget {
  const Google({super.key});

  @override
  Widget build(BuildContext context) {
    // URL de un ícono de Google de dominio público para demostración.
    const googleIconUrl = 'assets/Google__G__logo.svg.png';

    return GestureDetector(
      onTap: () async {
        final UserCredential = await login();
        if (UserCredential != null) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CommunityScreen()));
        }
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                googleIconUrl,
                height: 24,
                width: 24,
                // Manejo de error en caso de que la imagen no cargue.
              ),
              const SizedBox(width: 10.0),
              Text(
                'Acceder con Google',
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
