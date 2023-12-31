import 'package:flutter/material.dart';

class KeyboardLetterKeyModel {
  final VoidCallback onPress;
  final String value;
  final bool isDisabled;
  final Color backgroundColour;

  KeyboardLetterKeyModel({required this.onPress, required this.value, required this.isDisabled, required this.backgroundColour});
}