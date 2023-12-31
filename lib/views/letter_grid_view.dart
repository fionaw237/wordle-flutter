import 'package:flutter/material.dart';
import 'package:wordle_flutter/models/letter_grid_cell_model.dart';
import 'package:wordle_flutter/views/letter_grid_cell_view.dart';

class LetterGridView extends StatelessWidget {
  final List<LetterGridCellModel> cellModels;
  const LetterGridView({super.key, required this.cellModels});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cellModels.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5, mainAxisSpacing: 10, crossAxisSpacing: 10),
        itemBuilder: (context, index) {
          return LetterGridCellView(cellModel: cellModels[index]);
        });
  }
}
