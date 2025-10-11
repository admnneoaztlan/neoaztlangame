import 'package:flutter/material.dart';
import 'package:neoaztlan/backend/widgets/UserInfoDisplay%20.dart';
import 'package:neoaztlan/backend/widgets/UserNameDisplay.dart';
import 'package:neoaztlan/backend/widgets/exit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NeoAztlán – Base')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
                'Skeleton listo por ramas: team/flutter, team/flame, team/firebase'),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () {},
              child: const Text('¡A construir!'),
            ),
            UserNameDisplay(),
            UserInfoDisplay(),
            Exit()
          ],
        ),
      ),
    );
  }
}
