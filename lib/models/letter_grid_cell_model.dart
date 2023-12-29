import 'package:flutter/material.dart';

enum LetterState {
  unrevaled,
  notInWord,
  inWord,
  inWrongPosition
}

class LetterGridCellModel {
  final String letter;
  final LetterState letterState = LetterState.unrevaled; 
  final Color backgroundColour = Colors.white;
  final Color borderColour = Colors.black;

  LetterGridCellModel({required this.letter});
}