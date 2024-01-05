import 'package:flutter/material.dart';
import 'package:wordle_flutter/managers/colour_manager.dart';
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

  late List<LetterGridCellModel> gridCellModels = getInitialGridCells();

  late List<KeyboardLetterKeyModel> keyboardLetterKeyModels =
      "QWERTYUIOPASDFGHJKLZXCVBNM"
          .split("")
          .map((letter) => KeyboardLetterKeyModel(
              onPress: () => letterKeyPressed(letter),
              value: letter,
              isDisabled: false,
              backgroundColour: Colors.grey))
          .toList();

  List<LetterGridCellModel> getInitialGridCells() {
    return List.filled(30, LetterGridCellModel(letter: ""));
  }

  void newGame() {
    answer = wordGenerator.generateWord();
  }

  void resetPressed() {
    currentGuess = "";
    currentRowIndex = 0;
    gridCellModels = getInitialGridCells();
    // initialiseKeyboard();
    newGame();
    notifyListeners();
  }

  void enterPressed() {
    if (isRowFull && isValid(currentGuess)) {
      setCellBackgroundColours();
      setKeyboardKeyBackgroundColours();
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

  void setKeyboardKeyBackgroundColours() {
    for (final (index, letter) in currentGuess.split("").indexed) {
      int letterIndex = keyboardLetterKeyModels.indexWhere((letterModel) => letterModel.value.toLowerCase() == letter);
      if (letterIndex >= 0) {
        keyboardLetterKeyModels[letterIndex].backgroundColour = getLetterKeyBackgroundColour(index, letter, keyboardLetterKeyModels[letterIndex].backgroundColour);
        keyboardLetterKeyModels[letterIndex].isDisabled = keyboardLetterKeyModels[letterIndex].backgroundColour == ColourManager.letterNotInAnswerKeyboard;
      }
    }
    notifyListeners();
  }

  Color getLetterKeyBackgroundColour(int index, String letter, Color currentColour) {
    List<String> answerList = answer.split("");
    bool isCorrectPosition = (answerList[index] == letter) || (currentColour == ColourManager.letterInCorrectPosition);
    if (isCorrectPosition) {
      return ColourManager.letterInCorrectPosition;
    }
    if (answerList.contains(letter)) {
      return ColourManager.letterInWrongPosition;
    }
    return ColourManager.letterNotInAnswerKeyboard;
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
