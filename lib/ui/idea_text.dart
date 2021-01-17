import 'package:flutter/material.dart';
import 'package:idea_market/util/ui/kowanas_layout.dart';

class IdeaText extends StatelessWidget{
  final maxlines;
  final text;
  final color;
  final size;

  const IdeaText({Key key, @required this.text, this.maxlines = 1,
    this.size = 0, this.color}): super(key: key);

  @override
  Widget build(BuildContext context) {
    KowanasLayoutInfo layoutInfo = KowanasLayout.of(context);
    final fSize = (size == 0)?layoutInfo.mediumfont:size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child:Text(text,
            maxLines: maxlines,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black87, fontSize: fSize))),
      ],);
  }
}
