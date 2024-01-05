import 'package:flutter/material.dart';

class KeyboardLetterKeyModel {
  VoidCallback onPress;
  String value;
  bool isDisabled;
  Color backgroundColour;
  KeyboardLetterKeyModel({required this.onPress, required this.value, required this.isDisabled, required this.backgroundColour});
}