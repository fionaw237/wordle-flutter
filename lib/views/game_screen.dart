import 'package:flutter/material.dart';
import 'package:wordle_flutter/models/letter_grid_cell_model.dart';
import 'package:wordle_flutter/views/letter_grid_cell_view.dart';

class GameScreen extends StatelessWidget {
  GameScreen({super.key});

  final List<LetterGridCellModel> gridCellModels = [
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "A"),
    LetterGridCellModel(letter: "B"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 50),
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: gridCellModels.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, mainAxisSpacing: 10, crossAxisSpacing: 10),
            itemBuilder: (context, index) {
              return LetterGridCellView(cellModel: gridCellModels[index]);
            }),
      ),
    );
  }
}