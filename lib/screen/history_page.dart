import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:study_app/configs/themes/ui_parameters.dart';
import 'package:study_app/controllers/dictionary_controller.dart';
import 'package:study_app/firebase_ref/references.dart';
import 'package:study_app/models/history_model.dart';
import 'package:study_app/widgets/custom_app_bar.dart';
import 'package:get/get.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({Key? key}) : super(key: key);

  final CollectionReference _words =
      historyRef.doc("history").collection("keyword");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leading: Container(),
        title: "History Search",
      ),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: Get.height * .8 - 50,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 45,
                horizontal: mobileScreenPadding,
              ),
              color: Color(0xff110B19),
            ),
          ),
          Positioned.fill(
              top: Get.height * .2 - 20,
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
                    child: StreamBuilder(
                      stream: _words.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            padding: EdgeInsets.only(top: 0),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot documentSnapshot =
                                  snapshot.data!.docs[index];

                              return Container(
                                margin: EdgeInsets.only(bottom: 20),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    )),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        documentSnapshot["keyword"],
                                      ),
                                    ),
                                    documentSnapshot["is_favorite"]
                                        ? GestureDetector(
                                            onTap: () {
                                              var update = History(
                                                id: historyRef.id,
                                                keyword:
                                                    documentSnapshot["keyword"],
                                                isFavorite: false,
                                              );
                                              Get.find<DictionaryController>()
                                                  .updateData(update.toJson());
                                              Get.find<DictionaryController>()
                                                  .getIsFavorite();
                                            },
                                            child: Icon(
                                              Icons.favorite,
                                              color: Color(0xff110B19),
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              var update = History(
                                                id: historyRef.id,
                                                keyword:
                                                    documentSnapshot["keyword"],
                                                isFavorite: true,
                                              );
                                              Get.find<DictionaryController>()
                                                  .updateData(update.toJson());
                                              Get.find<DictionaryController>()
                                                  .getIsFavorite();
                                            },
                                            child: Icon(
                                              Icons.favorite_border,
                                            ),
                                          )
                                  ],
                                ),
                              );
                            },
                          );
                        }
                        return Center(
                          child: Text(
                            "No History Yet",
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      },
                    )),
              ))
        ],
      ),
    );
  }
}
