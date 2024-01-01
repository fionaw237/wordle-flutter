import 'dart:math';

abstract class IWordGenerator {
  List<String> wordBank = [];
  String generateWord();
}

class WordGenerator implements IWordGenerator {
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
    return wordBank[Random().nextInt(wordBank.length)];
  }
}
