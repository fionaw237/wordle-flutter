import 'package:flutter/material.dart';

class KeyboardDeleteButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isDisabled;
  final double keyWidth;

  const KeyboardDeleteButton({super.key, required this.onTap, required this.isDisabled, required this.keyWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: Colors.grey,
      ),
      height: 50,
      width: keyWidth,
      child: IconButton(
        onPressed: onTap, 
        icon: Icon(Icons.backspace_outlined, color: Colors.white,),
      ),
    );
  }
}