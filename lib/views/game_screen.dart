import 'package:flutter/material.dart';
import 'package:wordle_flutter/models/letter_grid_cell_model.dart';
import 'package:wordle_flutter/views/letter_grid_view.dart';

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
      appBar: AppBar(
        title: Text("Wordle"),
        actions: [
          IconButton(
            onPressed: () => print("Reset!"),
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 25),
        child: Column(
          children: [
            LetterGridView(cellModels: gridCellModels),
          ],
        ),
      ),
    );
  }
}