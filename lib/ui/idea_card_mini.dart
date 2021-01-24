import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idea_market/model/idea.dart';
import 'package:idea_market/util/ui/kowanas_cardspage.dart';
import 'package:idea_market/util/ui/kowanas_layout.dart';

import 'idea_title.dart';

class IdeaCardMini extends StatelessWidget{
  final Idea idea;
  final size = 15.0;
  IdeaCardMini({Key key, this.idea}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    KowanasLayoutInfo layoutInfo = KowanasLayout.of(context);
    return Column(mainAxisAlignment: MainAxisAlignment.start,
      children: [
        KowanasCardsPage(height: layoutInfo.getHeight(size),
          paddingSize: layoutInfo.getWidth(5),
          child: Container(
              child: Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(children: [
                        IdeaTitle(title:idea.title),
                      ]),
                    ],
                  )
              )))]);
  }
}
