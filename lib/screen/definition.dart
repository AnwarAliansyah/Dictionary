import 'package:flutter/material.dart';
import 'package:study_app/configs/themes/custom_text_style.dart';
import 'package:study_app/models/dictionary_model.dart';

class DefinitionScreen extends StatefulWidget {
  List<Definition> definiton;

  DefinitionScreen({
    Key? key,
    required this.definiton,
  }) : super(key: key);

  @override
  State<DefinitionScreen> createState() => _DefinitionScreenState();
}

class _DefinitionScreenState extends State<DefinitionScreen> {
  late bool isExpanded;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isExpanded = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                style: subTitle,
                children: <TextSpan>[
                  TextSpan(
                    text: 'DEFINITION  ',
                  ),
                  TextSpan(
                      text: widget.definiton.length.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                      )),
                ],
              ),
            ),
          ],
        ),
        ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            physics: NeverScrollableScrollPhysics(),
            itemCount: isExpanded ? 1 : widget.definiton.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return widget.definiton.length > 0
                  ? Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: textStyle,
                              children: <TextSpan>[
                                TextSpan(
                                    text: '${index + 1}. ',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                  text: widget.definiton[index].definition,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          widget.definiton[index].example != ""
                              ? RichText(
                                  text: TextSpan(
                                    style: textStyle,
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Example: ',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                        text: widget.definiton[index].example,
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    )
                  : Container();
            }),
        widget.definiton.length > 1
            ? InkWell(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: isExpanded
                    ? Text(
                        "...",
                      )
                    : Icon(
                        Icons.keyboard_arrow_up_rounded,
                        size: 20,
                      ))
            : Container(),
      ],
    );
  }
}


// 