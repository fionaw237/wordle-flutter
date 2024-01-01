import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_flutter/models/app_model.dart';
import 'package:wordle_flutter/views/keyboard/keyboard_view.dart';
import 'package:wordle_flutter/views/letter_grid_view.dart';

class GameScreen extends StatefulWidget {
  GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    final model = context.read<AppModel>();

    return Consumer<AppModel>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text("Wordle"),
          actions: [
            IconButton(
              onPressed: () => model.resetPressed(),
              icon: Icon(Icons.refresh),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 25),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: LetterGridView(cellModels: value.gridCellModels),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: KeyboardView(
                    keyModels: value.keyboardLetterKeyModels,
                    onEnterPress: () => model.enterPressed(),
                    onDeletePress: () => model.deletePressed(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
