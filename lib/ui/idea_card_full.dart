import 'package:flutter/material.dart';
import 'package:idea_market/model/idea.dart';
import 'package:idea_market/util/ui/kowanas_cardspage.dart';
import 'package:idea_market/util/ui/kowanas_layout.dart';

import 'idea_info.dart';
import 'idea_text.dart';
import 'idea_title.dart';

class IdeaCardFull extends StatelessWidget{
  final Idea idea;
  final size;
  IdeaCardFull({Key key, this.idea, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    KowanasLayoutInfo layoutInfo = KowanasLayout.of(context);
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          KowanasCardsPage(height: layoutInfo.getHeight(size),
            paddingSize: layoutInfo.getWidth(5),
            child: Container(
              child: Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(children: [
                          IdeaTitle(title:idea.title),
                          IdeaInfo(idea:idea),
                        ]),
                        IdeaText(maxlines: 100, size: layoutInfo.largefont,
                          color: Colors.redAccent,
                          text: ' As a '+idea.role),
                        IdeaText(maxlines: 100, size: layoutInfo.largefont,
                          color: Colors.blueGrey,
                          text: ' I want '+idea.goal),
                        IdeaText(maxlines: 100, size: layoutInfo.largefont,
                          color: Colors.blueAccent,
                          text: ' So that '+idea.value)
                    ],
                  ))
              )))]);
  }
}
