import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:study_app/firebase_ref/references.dart';
import 'package:study_app/firebase_ref/references.dart';
import 'package:study_app/models/dictionary_model.dart';
import 'package:study_app/models/history_model.dart';
import 'package:study_app/services/dictionary_repo.dart';

class DictionaryController extends GetxController {
  final DictionaryRepo dictionaryRepo;

  DictionaryController({
    required this.dictionaryRepo,
  });

  List<Dictionary> _wordList = [];
  List<Dictionary> get wordList => _wordList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getWordMeaning(String word) async {
    bool _isLoaded = false;

    Response response = await dictionaryRepo.getWordMeaning(word);
    if (response.statusCode == 200) {
      _isLoaded = true;

      var words = response.body as List;
      _wordList = words.map((e) => Dictionary.fromJson(e)).toList();
      update();
    } else {
      print(response.statusText);
    }
  }

  Future<void> uploadData(Map<String, dynamic> data) async {
    _isLoaded = false;

    try {
      final historyUp = dictionaryRef(data["keyword"]);
      historyUp.set(data);

      _isLoaded = true;
      update();
    } catch (e) {}
  }

  Future<void> updateData(Map<String, dynamic> data) async {
    _isLoaded = false;

    try {
      final isFavorite = dictionaryRef(data["keyword"]);
      isFavorite.update(data);

      _isLoaded = true;
      update();
    } catch (e) {}
  }

  final favorite = <History>[];

  Future<void> getIsFavorite() async {
    _isLoaded = false;

    try {
      final QuerySnapshot<Map<String, dynamic>> dictionaryQuery =
          await historyRef
              .doc("history")
              .collection("keyword")
              .where("is_favorite", isEqualTo: true)
              .get();
      final words = dictionaryQuery.docs
          .map(
            (word) => History.fromSnapshot(word),
          )
          .toList();

      if (words.isNotEmpty) {
        favorite.assignAll(words);
        // print(favorite.length);
        _isLoaded = true;
        update();
      } else {}
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    update();
  }
}
