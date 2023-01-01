import 'package:get/get.dart';
import 'package:study_app/controllers/dictionary_controller.dart';
import 'package:study_app/screen/home_screen.dart';
import 'package:study_app/screen/main_page.dart';
import 'package:study_app/services/dictionary_repo.dart';

class Routes {
  static List<GetPage> getPages() {
    return [
      GetPage(
        name: "/main",
        page: () {
          return MainPage();
        },
        binding: BindingsBuilder(
          () {
            Get.put(DictionaryController(
                dictionaryRepo:
                    Get.put(DictionaryRepo(apiClient: Get.find()))));
          },
        ),
      ),
    ];
  }
}
