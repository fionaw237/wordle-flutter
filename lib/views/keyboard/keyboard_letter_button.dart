import 'package:flutter/material.dart';
import 'package:wordle_flutter/models/keyboard_letter_key_model.dart';
import 'package:wordle_flutter/views/keyboard/keyboard_button_container.dart';

class KeyboardLetterButton extends StatelessWidget {
  final KeyboardLetterKeyModel letterModel;
  final double keyWidth;
  const KeyboardLetterButton(
      {super.key, required this.letterModel, required this.keyWidth});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: letterModel.isDisabled ? () {} : letterModel.onPress,
      child: KeyboardButtonContainer(
        width: keyWidth,
        backgroundColour: letterModel.backgroundColour,
        child: Text(
          letterModel.value,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
