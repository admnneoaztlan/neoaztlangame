import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> guardarNuevoUsuario(User user) async {
  final DocumentReference userDocref =
      FirebaseFirestore.instance.collection('users').doc(user.uid);
  final DocumentSnapshot userSnapshot = await userDocref.get();

  if (!userSnapshot.exists) {
    final Map<String, int> carsinicio = {'card_001': 1};
    await userDocref.set({
      'nombreDeUsuario': user.displayName,
      'rango': '',
      'nivel': 1,
      'polvoArcano': 200,
      'creationDate': FieldValue.serverTimestamp(),
      'coleccionDeCartas': carsinicio,
    });
    print('Nuevo usuario creado en Firestore con UID: ${user.uid}');
  } else {
    print(
        'El usuario con UID: ${user.uid} ya existe en Firestore. No se sobrescribió.');
  }
}
