import 'package:flutter_test/flutter_test.dart';
import 'package:wordle_flutter/managers/colour_manager.dart';
import 'package:wordle_flutter/models/app_model.dart';
import 'package:wordle_flutter/models/letter_grid_cell_model.dart';
import 'mocks/mock_word_generator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppModel sut;

  setUp(() => {sut = AppModel(wordGenerator: MockWordGenerator())});

  makeSUTWithMockAnswer(String answer) {
    sut = AppModel(wordGenerator: MockWordGenerator(mockAnswer: answer));
    sut.newGame();
  }

  makeSUTWithLettersPressed(List<String> lettersPressed) {
    sut.newGame();
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

  makeRepeatedGuess(String guess, int noOfTimes) {
    for (var i=0; i < noOfTimes; i++) {
      makeGuess(guess);
    }
  }

  test("generateAnswer generates answer from word bank", () {
    String answer = sut.wordGenerator.generateWord();
    expect(sut.wordGenerator.wordBank, contains(answer));
  });

  test("newGame calls word generator and sets answer property", () {
    String mockAnswer = "hello";
    makeSUTWithMockAnswer(mockAnswer);
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

  test("Letter from guess not in answer has plain background colour", () {
    makeSUTWithMockAnswer("apple");
    makeGuess("paint");
    expect(sut.gridCellModels[2].letterState, LetterState.notInWord);
    expect(sut.gridCellModels[2].backgroundColour, ColourManager.letterNotInAnswerCell);
  });

  test("Letter from guess in wrong position has yellow background colour", () {
    makeSUTWithMockAnswer("apple");
    makeGuess("paint");
    expect(sut.gridCellModels[0].letterState, LetterState.inWrongPosition);
    expect(sut.gridCellModels[0].backgroundColour, ColourManager.letterInWrongPosition);
  });

  test("Letter from guess in correct position has green colour", () {
    makeSUTWithMockAnswer("thing");
    makeGuess("paint");
    expect(sut.gridCellModels[2].backgroundColour, ColourManager.letterInCorrectPosition);
  });

  test("Second guess with correct letter has green background colour", () {
    makeSUTWithMockAnswer("paint");
    makeGuess("apple");
    makeGuess("fancy");
    expect(sut.gridCellModels[6].letterState, LetterState.inWord);
    expect(sut.gridCellModels[6].backgroundColour, ColourManager.letterInCorrectPosition);
  });

  test("Second guess with correct word has green background colours", () {
    makeSUTWithMockAnswer("paint");
    makeGuess("apple");
    makeGuess("paint");
    for (var i = 5; i < 10; i++) {
      expect(sut.gridCellModels[i].letterState, LetterState.inWord);
      expect(sut.gridCellModels[i].backgroundColour, ColourManager.letterInCorrectPosition);
    }
  });

  test("If answer has one instance of letter and guess has two in wrong position, only one should go yellow", () {
    makeSUTWithMockAnswer("glass");
    makeGuess("foggy");
    expect(sut.gridCellModels[2].letterState, LetterState.inWrongPosition);
    expect(sut.gridCellModels[2].backgroundColour, ColourManager.letterInWrongPosition);
    // expect(sut.gridCellModels[2].letterState, LetterState.notInWord);
    expect(sut.gridCellModels[3].backgroundColour, ColourManager.letterNotInAnswerCell);
  });
    
  test("If answer has two instances of letter with one in correct position, one should go yellow and the other green", () {
    makeSUTWithMockAnswer("pipes");
    makeGuess("apple");
        expect(sut.gridCellModels[1].letterState, LetterState.inWrongPosition);
    expect(sut.gridCellModels[1].backgroundColour, ColourManager.letterInWrongPosition);
    expect(sut.gridCellModels[2].letterState, LetterState.inWord);
    expect(sut.gridCellModels[2].backgroundColour, ColourManager.letterInCorrectPosition);
  });

  test("If answer has one instance of a letter and guess has three with first two in wrong position, only third should go green", () {
    makeSUTWithMockAnswer("rainy");
    makeGuess("nanny");
    expect(sut.gridCellModels[0].backgroundColour, ColourManager.letterNotInAnswerCell);
    expect(sut.gridCellModels[2].backgroundColour, ColourManager.letterNotInAnswerCell);
    expect(sut.gridCellModels[3].backgroundColour, ColourManager.letterInCorrectPosition);
  });

  test("Reset game function resets game", () {
        makeSUTWithMockAnswer("paint");
        makeRepeatedGuess("teeth", 6);
        sut.resetPressed();
        expect(sut.currentGuess, "");
        expect(sut.currentRowIndex, 0);
        expect(sut.gridCellModels.every((model) => model.backgroundColour == ColourManager.incompleteCell), true);
  });

}
