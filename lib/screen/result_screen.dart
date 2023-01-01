import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:study_app/configs/themes/custom_text_style.dart';
import 'package:study_app/controllers/dictionary_controller.dart';
import 'package:study_app/firebase_ref/references.dart';
import 'package:study_app/models/dictionary_model.dart';
import 'package:study_app/models/history_model.dart';
import 'package:study_app/screen/definition.dart';
import 'package:study_app/screen/synonym_antonym.dart';
import 'package:get/get.dart';

class ResultScreen extends StatefulWidget {
  final List<Dictionary> dictionary;

  ResultScreen({
    Key? key,
    required this.dictionary,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int currentResult = 0;
  int partOfSpeech = 0;

  final player = AudioPlayer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentResult = 0;
    partOfSpeech = 0;
  }

  @override
  Widget build(BuildContext context) {
    var contain = Get.find<DictionaryController>().favorite.where((element) =>
        element.keyword ==
        widget.dictionary[currentResult].word!.toLowerCase().toString());

    return Get.find<DictionaryController>().isLoaded
        ? SingleChildScrollView(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Result: ",
                style: phoneticTS,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 30,
                child: ListView.builder(
                    itemCount: widget.dictionary.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            currentResult = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Text(
                            widget.dictionary[index].meanings!.length > 1
                                ? widget.dictionary[index].word!
                                : "${widget.dictionary[index].word!} (${widget.dictionary[index].meanings!.first.partOfSpeech})",
                            style: phoneticTS,
                          ),
                        ),
                      );
                    }),
              ),
              Center(
                child: Container(
                  height: 2,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.dictionary[currentResult].word!,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (contain.isEmpty) {
                          var update = History(
                            id: historyRef.id,
                            keyword: widget.dictionary[currentResult].word!,
                            isFavorite: true,
                          );
                          Get.find<DictionaryController>()
                              .updateData(update.toJson());

                          Get.find<DictionaryController>().getIsFavorite();
                        } else {
                          var update = History(
                            id: historyRef.id,
                            keyword: widget.dictionary[currentResult].word!,
                            isFavorite: false,
                          );
                          Get.find<DictionaryController>()
                              .updateData(update.toJson());

                          Get.find<DictionaryController>().getIsFavorite();
                        }
                      },
                      icon: contain.isEmpty
                          ? Icon(
                              Icons.favorite_border,
                            )
                          : Icon(
                              Icons.favorite,
                              color: Color(0xff110B19),
                            )),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 15,
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.dictionary[currentResult].phonetics![index]
                                .text!,
                            style: phoneticTS,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          widget.dictionary[currentResult].phonetics![index]
                                      .audio !=
                                  ""
                              ? GestureDetector(
                                  onTap: () async {
                                    await player.setSourceUrl(widget
                                        .dictionary[currentResult]
                                        .phonetics![index]
                                        .audio!);
                                  },
                                  child: Icon(
                                    Icons.volume_up,
                                    size: 15,
                                  ),
                                )
                              : Container(),
                        ],
                      );
                    },
                    separatorBuilder: (_, index) {
                      return Text(
                        ", ",
                        style: phoneticTS,
                      );
                    },
                    itemCount:
                        widget.dictionary[currentResult].phonetics!.length),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 30,
                child: ListView.builder(
                    itemCount:
                        widget.dictionary[currentResult].meanings!.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            partOfSpeech = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              )
                              // color: Color(0xff110B19),
                              ),
                          child: Text(
                            widget.dictionary[currentResult].meanings![index]
                                .partOfSpeech!,
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              DefinitionScreen(
                definiton: widget.dictionary[currentResult]
                    .meanings![partOfSpeech].definitions!,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: SynonymAntonym(
                    title: "SYNONYMS",
                    content: widget.dictionary[currentResult]
                        .meanings![partOfSpeech].synonyms!,
                  )),
                  Expanded(
                      child: SynonymAntonym(
                    title: "ANTONYMS",
                    content: widget.dictionary[currentResult]
                        .meanings![partOfSpeech].antonyms!,
                  )),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Source: ${widget.dictionary[currentResult].sourceUrls!.first}",
                style: smallTS,
              ),
              Text(
                "License: ${widget.dictionary[currentResult].license!.name!}",
                style: smallTS,
              ),
              Text(
                "URL: ${widget.dictionary[currentResult].license!.url!}",
                style: smallTS,
              ),
            ],
          ))
        : Center(child: CircularProgressIndicator());
  }
}
