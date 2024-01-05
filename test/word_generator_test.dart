import 'package:flutter_test/flutter_test.dart';
import 'package:wordle_flutter/models/word_generator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test("generateWord generates answer from word bank", () async {
    WordGenerator sut = await WordGenerator.create();
    final randomWord = sut.generateWord();
    expect(sut.wordBank, contains(randomWord));
  });
}
