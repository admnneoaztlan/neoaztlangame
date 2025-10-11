import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:neoaztlan/database/model/rules/guardarusuario.dart';

Future<UserCredential?> signInWithFacebook() async {
  try {
    // 1. Iniciar el flujo de login de Facebook y solicitar permisos
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: ['email', 'public_profile'], // Asegúrate de pedir el email
    );

    if (result.status == LoginStatus.success) {
      final AccessToken? accessToken = result.accessToken;

      if (accessToken == null) {
        print('Error: Token de acceso de Facebook es nulo.');
        return null;
      }

      // 2. Usar el token para crear una credencial de Firebase.
      // 💥 IMPORTANTE: Se usa .tokenString para versiones recientes del paquete.
      final OAuthCredential credential = FacebookAuthProvider.credential(
        accessToken.tokenString,
      );

      // 3. Iniciar sesión en Firebase con la credencial de Facebook.
      // Firebase maneja automáticamente la creación del usuario o la actualización del usuario existente.
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // (Opcional) Si quieres obtener datos adicionales de Facebook, puedes usar:
      // final userData = await FacebookAuth.instance.getUserData();
      if (userCredential.user != null) {
        await guardarUsuario(userCredential.user!);
      }
      print(
          "Usuario logueado en Firebase vía Facebook: ${userCredential.user?.email}");

      // Este UserCredential es el que debes devolver a tu `AuthenticationRepositoryImpl`
      return userCredential;
    } else if (result.status == LoginStatus.cancelled) {
      print('El usuario canceló el inicio de sesión.');
      return null;
    } else {
      print('Error de login de Facebook: ${result.message}');
      return null;
    }
  } catch (e) {
    // Manejar cualquier excepción de Firebase o de la red.
    print('Excepción durante el inicio de sesión con Facebook: $e');
    return null;
  }
}
