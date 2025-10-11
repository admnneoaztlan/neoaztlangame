import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

Future<void> cerrarSesion() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;

  // 1. Si no hay usuario, limpiamos los SDKs por si acaso.
  if (user == null) {
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
    await auth.signOut(); // Cierra el estado de Firebase por seguridad
    print('Sesión cerrada (no había usuario activo).');
    return;
  }

  // 2. Identificar el proveedor con el que inició sesión
  String providerId = 'password'; // Asumimos password/email por defecto

  // providerData contiene todos los proveedores vinculados, buscamos el que usó para iniciar sesión
  for (final provider in user.providerData) {
    // Si el proveedor no es 'firebase' (genérico), tomamos el ID social.
    if (provider.providerId != 'firebase') {
      providerId = provider.providerId;
      break;
    }
  }

  // 3. Ejecutar el cierre de sesión específico del SDK externo
  if (providerId == 'google.com') {
    // Limpia las credenciales del SDK de Google
    await GoogleSignIn().signOut();
  } else if (providerId == 'facebook.com') {
    // Limpia las credenciales del SDK de Facebook
    await FacebookAuth.instance.logOut();
  }

  // 4. Cerrar la sesión general en Firebase (lo cual limpia el estado de persistencia)
  await auth.signOut();

  print('Sesión cerrada universalmente. Proveedor usado: $providerId');
}
