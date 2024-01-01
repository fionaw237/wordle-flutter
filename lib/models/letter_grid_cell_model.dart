import 'package:flutter/material.dart';

enum LetterState {
  unrevaled,
  notInWord,
  inWord,
  inWrongPosition
}

class LetterGridCellModel {
  String letter;
  LetterState letterState = LetterState.unrevaled; 
  Color backgroundColour = Colors.white;
  Color borderColour = Colors.black;

  LetterGridCellModel({required this.letter});
}