import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:neoaztlan/backend/model/rules/guardarNuevoUsuario.dart';

Future<UserCredential?> authServiceGoogle() async {
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

    if (userCredential.user != null) {
      await guardarNuevoUsuario(userCredential.user!);
    }
    return userCredential;
  } catch (e) {
    // Si llegas aquí, hubo un error. Imprime el error para depurar.
    print('Error durante el inicio de sesión con Google: $e');
    return null;
  }
}
