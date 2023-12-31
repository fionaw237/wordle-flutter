import 'package:flutter/material.dart';
import 'package:wordle_flutter/models/keyboard_letter_key_model.dart';
import 'package:wordle_flutter/models/letter_grid_cell_model.dart';

class AppModel extends ChangeNotifier {

  List<LetterGridCellModel> gridCellModels =
      List.filled(30, LetterGridCellModel(letter: ""));

  List<KeyboardLetterKeyModel> keyboardLetterKeyModels =
      "QWERTYUIOPASDFGHJKLZXCVBNM"
          .split("")
          .map((letter) => KeyboardLetterKeyModel(
              onPress: () => {},
              value: letter,
              isDisabled: false,
              backgroundColour: Colors.grey))
          .toList();

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
