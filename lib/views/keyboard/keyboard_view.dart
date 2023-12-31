import 'package:flutter/material.dart';
import 'package:wordle_flutter/models/keyboard_letter_key_model.dart';
import 'package:wordle_flutter/views/keyboard/keyboard_delete_button.dart';
import 'package:wordle_flutter/views/keyboard/keyboard_enter_button.dart';
import 'package:wordle_flutter/views/keyboard/keyboard_letter_button.dart';

class KeyboardView extends StatelessWidget {
  final List<KeyboardLetterKeyModel> keyModels;
  final VoidCallback onEnterPress;
  final VoidCallback onDeletePress;
  KeyboardView({super.key, required this.keyModels, required this.onEnterPress, required this.onDeletePress});

  List<Widget> thirdRow = [];
  @override
  Widget build(BuildContext context) {
    var letterKeyWidth = (MediaQuery.of(context).size.width - 77.0) / 10;
    var actionButtonWidth =
        (MediaQuery.of(context).size.width - 9 * letterKeyWidth) / 2;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: keyModels
              .sublist(0, 10)
              .map((model) => KeyboardLetterButton(
                    letterModel: model,
                    keyWidth: letterKeyWidth,
                  ))
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: keyModels
              .sublist(10, 19)
              .map((model) => KeyboardLetterButton(
                    letterModel: model,
                    keyWidth: letterKeyWidth,
                  ))
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: getThirdRow(keyModels, letterKeyWidth, actionButtonWidth),
        )
      ],
    );
  }

  List<Widget> getThirdRow(List<KeyboardLetterKeyModel> keyModels,
    double keyWidth, double actionButtonWidth) {
  List<Widget> result = [
    KeyboardEnterButton(
      onTap: onEnterPress,
      isDisabled: false,
      keyWidth: actionButtonWidth,
    )
  ];
  for (var model in keyModels.sublist(19, 26)) {
    result.add(KeyboardLetterButton(
      letterModel: model,
      keyWidth: keyWidth,
    ));
  }
  result.add(KeyboardDeleteButton(
    onTap: onDeletePress,
    isDisabled: false,
    keyWidth: actionButtonWidth,
  ));
  return result;
}
}


