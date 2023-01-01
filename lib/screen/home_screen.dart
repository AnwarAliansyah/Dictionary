import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/configs/themes/custom_text_style.dart';
import 'package:study_app/configs/themes/ui_parameters.dart';
import 'package:study_app/controllers/dictionary_controller.dart';
import 'package:study_app/firebase_ref/references.dart';
import 'package:study_app/models/history_model.dart';
import 'package:study_app/screen/result_screen.dart';
import 'package:study_app/widgets/custom_app_bar.dart';
import 'package:study_app/widgets/text_field.dart';

class HomeScreen extends StatefulWidget {
  String? research;

  HomeScreen({
    Key? key,
    this.research,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.research != null ? controller.text = widget.research! : null;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DictionaryController>(
      builder: (dictionary) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
            leading: Container(),
            title: "Dictionary",
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: Get.height,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        bottom: Get.height * .65,
                        child: StreamBuilder<Object>(
                            stream: null,
                            builder: (context, snapshot) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 45,
                                  horizontal: mobileScreenPadding,
                                ),
                                color: Color(0xff110B19),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: CustomTextField(
                                    controller: controller,
                                    onTap: () {
                                      dictionary.getWordMeaning(
                                          controller.text.toString());
                                      // Get.offAndToNamed("/main");
                                      var data = History(
                                        id: historyRef.id,
                                        keyword: controller.text
                                            .toLowerCase()
                                            .toString(),
                                        isFavorite: false,
                                      );
                                      var contain =
                                          Get.find<DictionaryController>()
                                              .favorite
                                              .where((element) =>
                                                  element.keyword ==
                                                  controller.text
                                                      .toLowerCase()
                                                      .toString());
                                      if (contain.isEmpty) {
                                        dictionary.uploadData(data.toJson());
                                      } else {}
                                    },
                                  ),
                                ),
                              );
                            }),
                      ),
                      Positioned.fill(
                          top: Get.height * .35 - 20,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: mobileScreenPadding,
                                  right: mobileScreenPadding,
                                  left: mobileScreenPadding,
                                  bottom: 10),
                              child: dictionary.wordList.isNotEmpty
                                  ? ResultScreen(
                                      dictionary: dictionary.wordList,
                                    )
                                  : Center(
                                      child: Text(
                                        "No Result",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
}
