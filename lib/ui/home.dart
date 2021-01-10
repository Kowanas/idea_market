import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idea_market/bloc/idea_bloc.dart';
import 'package:idea_market/model/idea.dart';
import 'package:idea_market/model/idea_repository.dart';
import 'package:idea_market/util/ads/ad_banner_container.dart';
import 'package:idea_market/util/ui/kowanas_appbar.dart';
import 'package:idea_market/util/ui/kowanas_cardspage.dart';
import 'package:idea_market/util/ui/kowanas_layout.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home>{
  var _title = "ideas";

  @override
  Widget build(BuildContext context) {
    KowanasLayoutInfo layoutInfo = KowanasLayoutInfo(MediaQuery.of(context));
    final repository = RepositoryProvider.of<IdeaRepository>(context);
    var ideas = repository.getList();

    routeEditor(idea) async {
      await Navigator.pushNamed(context, '/editor', arguments: idea);
    }

    final appBar = KowanasAppBar(color: Colors.orange, subject: _title,
      rightgap: layoutInfo.getWidth(5), size: layoutInfo.getWidth(6))
      ..addActions(Icons.add, (){routeEditor(repository.getNew());});
    layoutInfo.appBarSize = appBar.preferredSize.height
        + MediaQuery.of(context).padding.top
        + MediaQuery.of(context).padding.bottom;

    return KowanasLayout(data: layoutInfo,
      child: Scaffold(appBar: appBar,
          body: AdBannerContainer(
            height: layoutInfo.fullLayoutHeight,
            child: Builder(
              builder: (context){
                return BlocBuilder<IdeaBloc, IdeaState>(
                    builder: (context, state) {
                      if (state is IdeaStateNotInitialized)
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child:CircularProgressIndicator())],);
                      else if (state is IdeaStateFetched){
                        ideas = repository.getList();
                        if (ideas.length <= 0) return Container();
                        else {
                          return CarouselSlider.builder(
                            options: CarouselOptions(viewportFraction: 1.0,
                                height: layoutInfo.fullLayoutHeight),
                            itemCount: ideas.length,
                            itemBuilder: (context, index) {
                              return Column(children: [
                                KowanasCardsPage(
                                    child: IdeaCard(idea:ideas[index]),
                                    height: layoutInfo.getHeight(40),
                                    paddingSize: layoutInfo.getWidth(5)),
                              ]
                              );
                            },
                          );
                        }
/*
                        return ListView.builder(itemCount: ideas.length,
                            itemBuilder: (context, index){
                          return GestureDetector(
                              onTap: () { routeEditor(ideas[index]);},
                              child:IdeaCard(idea:ideas[index]));
                        });
 */
                      }});
              })),
        ));
  }
}

class IdeaCard extends StatelessWidget{
  final Idea idea;

  IdeaCard({Key key, this.idea}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    KowanasLayoutInfo layoutInfo = KowanasLayoutInfo(MediaQuery.of(context));
    return Container(
      child: Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(child:Text(idea.title,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: layoutInfo.h3font,
                        fontStyle: FontStyle.italic))),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(DateFormat('yyyy-MM-dd').format(idea.created),
                      style: TextStyle(fontStyle: FontStyle.italic,
                        fontSize: layoutInfo.smallfont)),
                    PopupMenuButton(
                      onSelected: (select){
                        BlocProvider.of<IdeaBloc>(context)
                          ..add(IdeaEventDeleting(idea));
                      },
                      itemBuilder: (context) => <PopupMenuEntry>[
                        const PopupMenuItem(value: 0,
                            child: Text('delete'))
                      ]
                    )
                  ]
                )
              ]),
              IdeaCardShort(title: 'As a ', maxlines: 1,
                  titleColor: Colors.red, text: idea.role),
              IdeaCardShort(title: 'I want ', maxlines: 3,
                  titleColor: Colors.green, text: idea.goal),
              IdeaCardShort(title: 'So that ', maxlines: 5,
                  titleColor: Colors.blue, text: idea.value)
          ],
        )
      )
    );
  }
}

class IdeaCardShort extends StatelessWidget{
  final maxlines;
  final title;
  final titleColor;
  final text;

  const IdeaCardShort({Key key, this.title, this.titleColor,
    @required this.text, this.maxlines = 1}): super(key: key);

  @override
  Widget build(BuildContext context) {
    KowanasLayoutInfo layoutInfo = KowanasLayoutInfo(MediaQuery.of(context));
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex:1,
          child:Padding(
            padding: EdgeInsets.only(top: layoutInfo.getHeight(0.3)),
            child: Text(title,
              textAlign: TextAlign.start,
              style: TextStyle(fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: layoutInfo.smallfont,
                color: titleColor)))),
        Expanded(
          flex:5,
          child:Text(text,
            maxLines: maxlines,
            overflow: TextOverflow.clip,
            style: TextStyle(color: titleColor.shade600,
              fontSize: layoutInfo.mediumfont,))),
      ],);
  }
}