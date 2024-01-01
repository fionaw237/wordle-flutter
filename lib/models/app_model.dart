import 'package:flutter/material.dart';
import 'package:wordle_flutter/models/keyboard_letter_key_model.dart';
import 'package:wordle_flutter/models/letter_grid_cell_model.dart';
import 'package:wordle_flutter/models/word_generator.dart';

class AppModel extends ChangeNotifier {
  final IWordGenerator wordGenerator;

  AppModel({required this.wordGenerator});

  int numberOfGridCells = 30;
  int numberOfColumns = 5;

  String answer = "";
  String currentGuess = "";
  int currentRowIndex = 0;
  int get currentLetterIndex => (currentRowIndex * numberOfColumns) + currentGuess.length;
  bool get isRowFull => (currentGuess.length == 5);

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

  void newGame() {
    answer = wordGenerator.generateWord();
  }

  void resetPressed() {
    print("Reset pressed!");
  }

  void enterPressed() {
    if (isRowFull && isValid(currentGuess)) {
      moveToNextRow();
    }
  }

  bool isValid(String word) {
    return wordGenerator.wordBank.contains(word);
  }

  void moveToNextRow() {
    currentGuess = "";
    currentRowIndex++;
  }

  void deletePressed() {
    currentGuess = currentGuess.substring(0, currentGuess.length - 1);
    gridCellModels[currentLetterIndex].letter = "";
    notifyListeners();
  }

  void letterKeyPressed(String letter) {
    if (!isRowFull) {
      gridCellModels[currentLetterIndex] = LetterGridCellModel(letter: letter);
      currentGuess = currentGuess + letter.toLowerCase();
    }
    notifyListeners();
  }
}
