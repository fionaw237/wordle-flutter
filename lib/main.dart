import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_flutter/providers/app_model.dart';
import 'package:wordle_flutter/views/game_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppModel(),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameScreen(),
    );
  }
}