import 'package:flutter/material.dart';
import 'package:wordle_flutter/models/keyboard_letter_key_model.dart';
import 'package:wordle_flutter/models/letter_grid_cell_model.dart';
import 'package:wordle_flutter/views/keyboard/keyboard_view.dart';
import 'package:wordle_flutter/views/letter_grid_view.dart';

class GameScreen extends StatelessWidget {
  GameScreen({super.key});

  final List<LetterGridCellModel> gridCellModels =
      List.filled(30, LetterGridCellModel(letter: ""));

  final List<KeyboardLetterKeyModel> keyboardLetterKeyModels =
      "QWERTYUIOPASDFGHJKLZXCVBNM"
          .split("")
          .map((letter) => KeyboardLetterKeyModel(
              onPress: () => print("Letter $letter pressed!"),
              value: letter,
              isDisabled: false,
              backgroundColour: Colors.grey))
          .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wordle"),
        actions: [
          IconButton(
            onPressed: () => print("Reset!"),
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
              child: LetterGridView(cellModels: gridCellModels),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: KeyboardView(
                  keyModels: keyboardLetterKeyModels,
                  onEnterPress: () => print("Enter pressed!"),
                  onDeletePress: () => print("Delete pressed!"),
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
