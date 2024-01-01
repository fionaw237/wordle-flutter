import 'package:test/test.dart';
import 'package:wordle_flutter/models/app_model.dart';
import 'package:wordle_flutter/models/word_generator.dart';

import 'mocks/mock_word_generator.dart';

void main() {

  late AppModel sut;

  setUp(() => {
    sut = AppModel(wordGenerator: WordGenerator())
  });

  makeSUTWithMockAnswer(String answer) {
    sut = AppModel(wordGenerator: MockWordGenerator(mockAnswer: answer));
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
}