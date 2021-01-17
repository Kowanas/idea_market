import 'package:flutter/cupertino.dart';
import 'package:idea_market/util/ui/kowanas_layout.dart';

class IdeaTitle extends StatelessWidget{
  final title;

  const IdeaTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final KowanasLayoutInfo layoutInfo = KowanasLayout.of(context);
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(child:Text(title,
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: layoutInfo.h3font,
                  fontStyle: FontStyle.italic))),
        ]
    );
  }
}