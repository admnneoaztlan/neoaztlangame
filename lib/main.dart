import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:neoaztlan/backend/AuthWrapper.dart';
import 'package:neoaztlan/database/firebase/firebase_options.dart';
import 'package:neoaztlan/backend/viewLogin.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(NeoaztlanApp());
}

class NeoaztlanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neoaztlan Game',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AuthWrapper(),
    );
  }
}
