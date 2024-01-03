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

  int gridIndexFromCurrentGuessLetterIndex(int letterIndex) {
    return (currentRowIndex * numberOfColumns) + letterIndex;
  }

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
      setCellBackgroundColours();
      moveToNextRow();
    }
  }

  void setCellBackgroundColours() {
    Map<String, int> answerLetterCounts = {};
    Map<String, int> greenOrYellowLetterCounts = {};

    for (var letter in answer.split("")) {
      answerLetterCounts[letter] = (answerLetterCounts[letter] ?? 0) + 1;
    }

    for (final (index, letter) in currentGuess.split("").indexed) {
      List<String> answerList = answer.split("");
      if (answerList[index] == letter) {
        greenOrYellowLetterCounts[letter] = (greenOrYellowLetterCounts[letter] ?? 0) + 1;
      }
    }

    for (final (index, letter) in currentGuess.split("").indexed) {
      gridCellModels[gridIndexFromCurrentGuessLetterIndex(index)].borderColour = Colors.transparent;
            
      int colouredLetterCount = greenOrYellowLetterCounts[letter] ?? 0;
      int answerLetterCount = answerLetterCounts[letter] ?? 0;

      LetterState newLetterState = getLetterState(index, letter, answerLetterCount, colouredLetterCount);
      gridCellModels[gridIndexFromCurrentGuessLetterIndex(index)].letterState = newLetterState;
      // TODO: Look at better way to do this!
      gridCellModels[gridIndexFromCurrentGuessLetterIndex(index)].backgroundColour =
          gridCellModels[gridIndexFromCurrentGuessLetterIndex(index)].backgroundColourForLetterState();

      if (newLetterState == LetterState.inWrongPosition) {
        greenOrYellowLetterCounts[letter] = (greenOrYellowLetterCounts[letter] ?? 0) + 1;
      }
    }
    notifyListeners();
  }

  LetterState getLetterState(int index, String letter, int answerLetterCount,
      int colouredLetterCount) {
    if (answer.split("")[index] == letter) {
      return LetterState.inWord;
    }
    if (answerLetterCount > colouredLetterCount) {
      return LetterState.inWrongPosition;
    } else {
      return LetterState.notInWord;
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
    if (currentGuess.isNotEmpty) {
      currentGuess = currentGuess.substring(0, currentGuess.length - 1);
      gridCellModels[currentLetterIndex].letter = "";
      notifyListeners();
    }
  }

  void letterKeyPressed(String letter) {
    if (!isRowFull) {
      gridCellModels[currentLetterIndex] = LetterGridCellModel(letter: letter);
      currentGuess = currentGuess + letter.toLowerCase();
    }
    notifyListeners();
  }
}
