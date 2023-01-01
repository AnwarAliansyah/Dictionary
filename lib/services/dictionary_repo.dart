import 'package:get/get.dart';

import 'package:study_app/services/api_client.dart';

class DictionaryRepo {
  final ApiClient apiClient;

  DictionaryRepo({
    required this.apiClient,
  });

  Future<Response> getWordMeaning(String word) async {
    print("test");
    return await apiClient.getData("/api/v2/entries/en/$word");
  }
}
