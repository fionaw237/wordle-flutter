import 'package:wordle_flutter/models/word_generator.dart';

class MockWordGenerator implements IWordGenerator {

  final String mockAnswer;

  MockWordGenerator({this.mockAnswer = ""});

  @override
  List<String> wordBank = [
    "sunny",
    "teeth",
    "plant",
    "handy",
    "fancy",
    "rainy",
    "foggy",
    "worst",
    "glass",
    "paint",
    "thing",
    "dance",
    "apple",
    "nanny", 
    "snags",
    "known",
    "sever",
    "geese",
    "pipes",
    "false",
    "truer",
    "sleep",
    "waist",
    "waste",
    "mouse",
    "proof"
  ];

  @override
  String generateWord() {
   return mockAnswer;
  }

}