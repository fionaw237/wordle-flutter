import 'package:flutter/material.dart';

class KeyboardButtonContainer extends StatelessWidget {
  final double width;
  final Color backgroundColour;
  final Widget child;
  const KeyboardButtonContainer({
    super.key,
    required this.width,
    required this.backgroundColour,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.only(left: 10, right: 10, top: 16, bottom: 16),
      decoration: BoxDecoration(
        color: backgroundColour,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: child,
    );
  }
}
