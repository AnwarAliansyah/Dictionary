import 'package:flutter/material.dart';
import 'package:study_app/configs/themes/custom_text_style.dart';

class SynonymAntonym extends StatefulWidget {
  final String title;
  final List<String> content;
  SynonymAntonym({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  State<SynonymAntonym> createState() => _SynonymAntonymState();
}

class _SynonymAntonymState extends State<SynonymAntonym> {
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
                    text: '${widget.title}  ',
                  ),
                  TextSpan(
                      text: widget.content.length.toString(),
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
            itemCount: isExpanded ? 3 : widget.content.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return widget.content.length > 0
                  ? Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        widget.content[index],
                        style: textStyle,
                      ),
                    )
                  : Container();
            }),
        widget.content.length > 3
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