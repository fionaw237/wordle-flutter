import 'package:flutter/material.dart';
import 'package:wordle_flutter/managers/colour_manager.dart';

enum LetterState {
  unrevaled,
  notInWord,
  inWord,
  inWrongPosition
}

class LetterGridCellModel {
  String letter;
  LetterState letterState = LetterState.unrevaled; 
  late Color backgroundColour = backgroundColourForLetterState();
  Color borderColour = Colors.black;

  LetterGridCellModel({required this.letter});

  Color backgroundColourForLetterState() {
    switch (letterState) {
      case LetterState.unrevaled:
        return ColourManager.incompleteCell;
      case LetterState.notInWord:
        return ColourManager.letterNotInAnswerCell;
      case LetterState.inWord:
        return ColourManager.letterInCorrectPosition;
      case LetterState.inWrongPosition:
        return ColourManager.letterInWrongPosition;
    }
  }
}