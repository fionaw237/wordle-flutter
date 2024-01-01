import 'package:test/test.dart';
import 'package:wordle_flutter/models/app_model.dart';
import 'package:wordle_flutter/models/word_generator.dart';

import 'mocks/mock_word_generator.dart';

void main() {
  late AppModel sut;

  setUp(() => {sut = AppModel(wordGenerator: WordGenerator())});

  makeSUTWithMockAnswer(String answer) {
    sut = AppModel(wordGenerator: MockWordGenerator(mockAnswer: answer));
  }

  makeSUTWithLettersPressed(List<String> lettersPressed) {
    for (var letter in lettersPressed) {
      sut.letterKeyPressed(letter);
    }
  }

  makeGuess(String guess) {
    for (var i = 0; i < guess.length; i++) {
      sut.letterKeyPressed(guess[i]);
    }
    sut.enterPressed();
  }

  test("generateAnswer generates answer from word bank", () {
    String answer = sut.wordGenerator.generateWord();
    expect(sut.wordGenerator.wordBank, contains(answer));
  });

  test("newGame calls word generator and sets answer property", () {
    String mockAnswer = "hello";
    makeSUTWithMockAnswer(mockAnswer);
    sut.newGame();
    expect(sut.answer, mockAnswer);
  });

  test(
      "Letter key pressed at start of game updates current guess and grid models",
      () {
    sut.letterKeyPressed("A");
    expect(sut.currentGuess, "a");
    expect(sut.gridCellModels[0].letter, "A");
    // TODO: Text border colour here
    // expect(sut.gridCellModels[0].borderColour, Colors.white);
    // expect(sut.gridCellModels[1].borderColor, Colors.black);
  });

  test(
      "Letter key pressed when row is full does not update current guess or row index",
      () {
    makeSUTWithLettersPressed(["A", "P", "P", "L", "E", "S"]);
    expect(sut.currentGuess, "apple");
    expect(sut.currentRowIndex, 0);
  });

  test("Letter key pressed when row is full does not update next row", () {
    makeSUTWithLettersPressed(["A", "P", "P", "L", "E", "S"]);
    expect(sut.gridCellModels[5].letter, "");
  });

  test("Pressing delete key removes last entered letter", () {
    makeSUTWithLettersPressed(["A", "P", "P", "L", "E"]);
    sut.deletePressed();
    expect(sut.gridCellModels[4].letter, "");
    expect(sut.currentGuess, "appl");
  });

  test("Moves to next row and resets current guess when enter key is pressed for a valid word", () {
    makeSUTWithMockAnswer("paint");
    sut.newGame();
    makeGuess("apple");
    expect(sut.currentRowIndex, 1);
    expect(sut.currentGuess, "");
  });

  test("Does nothing when enter key is pressed if row is not full", () {
    makeSUTWithLettersPressed(["A", "P", "P", "L"]);
    sut.enterPressed();
    expect(sut.currentRowIndex, 0);
    expect(sut.currentGuess, "appl");
  });

  test("Grid model is updated when enter key is pressed for valid word, then more letters are typed", () {
    makeSUTWithLettersPressed(["A", "P", "P", "L", "E"]);
    sut.enterPressed();
    sut.letterKeyPressed("Y");
    expect(sut.gridCellModels[5].letter, "Y");
    expect(sut.currentGuess, "y");
  });

  test("Does not proceed to next row when guess is invalid", () {
    makeSUTWithLettersPressed(["A", "P", "P", "L", "X"]);
    sut.enterPressed();
    expect(sut.currentRowIndex, 0);
    expect(sut.currentGuess, "applx");
  });

  

}
