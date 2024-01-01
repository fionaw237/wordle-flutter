import 'package:flutter/material.dart';
import 'package:wordle_flutter/models/keyboard_letter_key_model.dart';
import 'package:wordle_flutter/models/letter_grid_cell_model.dart';
import 'package:wordle_flutter/models/word_generator.dart';

class AppModel extends ChangeNotifier {

  final IWordGenerator wordGenerator;
  String answer = "";
  
  List<LetterGridCellModel> gridCellModels =
      List.filled(30, LetterGridCellModel(letter: ""));

  late List<KeyboardLetterKeyModel> keyboardLetterKeyModels =
      "QWERTYUIOPASDFGHJKLZXCVBNM"
          .split("")
          .map((letter) => KeyboardLetterKeyModel(
              onPress: () => letterKeyPressed(letter),
              value: letter,
              isDisabled: false,
              backgroundColour: Colors.grey))
          .toList();

  AppModel({required this.wordGenerator});

  void newGame() {
    answer = wordGenerator.generateWord();
  }

  void resetPressed() {
    print("Reset pressed!");
  }

  void enterPressed() {
    print("Enter pressed!");
  }

  void deletePressed() {
    print("Delete pressed!");
  }

  void letterKeyPressed(String letter) {
    print("Letter $letter pressed!");
  }
}
