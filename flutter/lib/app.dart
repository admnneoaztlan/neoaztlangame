import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'features/home/home_page.dart';

class NeoAztlanApp extends StatelessWidget {
  const NeoAztlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeoAztlan',
      theme: buildTheme(),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
