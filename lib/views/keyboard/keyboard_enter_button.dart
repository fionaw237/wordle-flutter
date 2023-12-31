import 'package:flutter/material.dart';
import 'package:wordle_flutter/views/keyboard/keyboard_button_container.dart';

class KeyboardEnterButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isDisabled;
  final double keyWidth;

  const KeyboardEnterButton(
      {super.key, required this.onTap, required this.isDisabled, required this.keyWidth});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: KeyboardButtonContainer(
          width: keyWidth,
          backgroundColour: Colors.grey,
          child: Text(
            "ENTER",
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ));
  }
}
