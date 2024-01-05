import 'dart:convert';
import 'dart:math';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

abstract class IWordGenerator {
  List<String> wordBank = [];
  String generateWord();
}

class WordGenerator implements IWordGenerator {
  static Future<WordGenerator> create() async {
    WordGenerator wordGenerator = WordGenerator();
    wordGenerator.wordBank = await wordGenerator.readWordsFromFile();
    return wordGenerator;
  }

  @override
  List<String> wordBank = [];

  @override
  String generateWord() {
    return wordBank[Random().nextInt(wordBank.length)];
  }

  Future<List<String>> readWordsFromFile() async {
    try {
      String words = await rootBundle.loadString('lib/data/five-letter-words.txt');
      return words.split("\n");
    } catch (error) {
      print(error);
      return [];
    }
  }
}
