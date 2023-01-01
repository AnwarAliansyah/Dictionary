import 'package:get/get.dart';
import 'package:study_app/controllers/dictionary_controller.dart';
import 'package:study_app/services/api_client.dart';
import 'package:study_app/services/dictionary_repo.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ApiClient(appBaseUrl: "https://api.dictionaryapi.dev"),
    );

    Get.lazyPut(() => DictionaryController(dictionaryRepo: Get.find()),
        fenix: true);
    Get.lazyPut(() => DictionaryRepo(apiClient: Get.find()), fenix: true);
  }
}
