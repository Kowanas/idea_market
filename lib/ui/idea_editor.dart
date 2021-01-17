import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idea_market/bloc/idea_bloc.dart';
import 'package:idea_market/model/idea.dart';
import 'package:idea_market/util/ads/ad_banner_container.dart';
import 'package:idea_market/util/ui/kowanas_appbar.dart';
import 'package:idea_market/util/ui/kowanas_cardspage.dart';
import 'package:idea_market/util/ui/kowanas_layout.dart';

class IdeaEditor extends StatelessWidget{
  final Idea idea;

  const IdeaEditor({Key key, this.idea}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    KowanasLayoutInfo layoutInfo = KowanasLayoutInfo(MediaQuery.of(context));
    StringBuffer title = StringBuffer(idea.title);
    StringBuffer role = StringBuffer(idea.role);
    StringBuffer goal = StringBuffer(idea.goal);
    StringBuffer value = StringBuffer(idea.value);

    _back(){
      FocusScope.of(context).unfocus();
      Timer(Duration(milliseconds: 500), (){Navigator.of(context).pop();});
    }

    onSaveIdea(){
      idea.title = title.toString();
      idea.role = role.toString();
      idea.goal = goal.toString();
      idea.value = value.toString();
      if (idea.verify())
        BlocProvider.of<IdeaBloc>(context)..add(IdeaEventSaving(idea));
      _back();
    }

    final appBarTitle = (title.length <= 0)?'Add your idea':title.toString();
    final appBar = KowanasAppBar(leadingIcon: Icons.arrow_back,
        leadingOnTap: (){onSaveIdea();},
        color: Colors.orange, subject: appBarTitle,
        rightgap: layoutInfo.getWidth(5), size: layoutInfo.getWidth(6));
//      ..addActions(Icons.save, (){onSaveIdea();});
    layoutInfo.appBarSize = appBar.preferredSize.height
        + MediaQuery.of(context).padding.top
        + MediaQuery.of(context).padding.bottom;

    return KowanasLayout(data: layoutInfo,
      child: Scaffold(appBar: appBar,
        body: AdBannerContainer(
        height: layoutInfo.fullLayoutHeight,
        adMargin: false,
        child: Builder(
          builder: (context){
            return SingleChildScrollView(
              child: KowanasCardsPage(height: layoutInfo.getHeight(70),
                paddingSize: layoutInfo.getWidth(5),
                child: Container(
                    child: Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IdeaEditCard(title: 'Title', buf:title, flex: 2),
                          IdeaEditCard(title: 'As a', buf:role, flex: 3),
                          IdeaEditCard(title: 'I want', buf:goal, flex: 3),
                          IdeaEditCard(title: 'So that', buf:value, flex: 3),
                        ],
                      ))
              )));}))));
  }
}

class IdeaEditCard extends StatefulWidget {
  final String title;
  final StringBuffer buf;
  final int flex;

  const IdeaEditCard({Key key, this.title, this.buf, this.flex})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => IdeaEditCardState();
}

class IdeaEditCardState extends State<IdeaEditCard>{
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.buf.toString());
    _controller.addListener(() {
      widget.buf.clear();
      widget.buf.write(_controller.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex,
      child: Container(
        padding: EdgeInsets.all(10),
        child: TextField(
          maxLines: 100,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: widget.title,
          ),
          controller: _controller,
        )
      )
    );
  }
}