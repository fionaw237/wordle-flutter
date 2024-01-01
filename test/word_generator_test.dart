import 'package:test/test.dart';
import 'package:wordle_flutter/models/word_generator.dart';

void main() {
  test("generateWord generates answer from word bank", () {
    final sut = WordGenerator();
    final randomWord = sut.generateWord();
    expect(sut.wordBank, contains(randomWord));
  });
}