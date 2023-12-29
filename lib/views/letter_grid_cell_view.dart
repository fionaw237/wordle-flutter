import 'package:flutter/material.dart';
import 'package:wordle_flutter/models/letter_grid_cell_model.dart';

class LetterGridCellView extends StatelessWidget {
  final LetterGridCellModel cellModel;
  const LetterGridCellView({super.key, required this.cellModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: cellModel.borderColour),
        color: cellModel.backgroundColour,
      ),
      child: Center(
        child: Text(
          cellModel.letter,
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}