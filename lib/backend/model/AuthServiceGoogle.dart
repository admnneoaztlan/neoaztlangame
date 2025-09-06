import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential?> login() async {
  try {
    final GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();
    if (googleuser == null) {
      print('El usuario canceló la autenticación o hubo un problema.');
      return null;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleuser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final String? uid = userCredential.user?.uid;
    if (uid != null) {
      final DocumentReference userDocref =
          FirebaseFirestore.instance.collection('users').doc(uid);
      final DocumentSnapshot userSnapshot = await userDocref.get();
      if (!userSnapshot.exists) {
        final Map<String, int> carsinicio = {'card_001': 1};
        await userDocref.set({
          'nombreDeUsuario': userCredential.user?.displayName,
          'rango': '##Pendidente##',
          'nivel': 1,
          'polvoArcano': 200,
          'creationDate': FieldValue.serverTimestamp(),
          'coleccionDeCartas': carsinicio
        });
        print('Nuevo usuario creado en Firestore con UID: $uid');
      } else {
        print(
            'El usuario con UID: $uid ya existe en Firestore. No se sobrescribió.');
      }
    }
    return userCredential;
  } catch (e) {
    // Si llegas aquí, hubo un error. Imprime el error para depurar.
    print('Error durante el inicio de sesión con Google: $e');
    return null;
  }
}
