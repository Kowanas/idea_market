import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idea_market/bloc/idea_bloc.dart';
import 'package:idea_market/bloc/viewmode_bloc.dart';
import 'package:idea_market/model/idea_repository.dart';
import 'package:idea_market/util/ads/ad_banner_container.dart';
import 'package:idea_market/util/ui/kowanas_appbar.dart';
import 'package:idea_market/util/ui/kowanas_layout.dart';
import 'idea_page.dart';

class Home extends StatelessWidget {
  var _title = "ideas";

  @override
  Widget build(BuildContext context) {
    KowanasLayoutInfo layoutInfo = KowanasLayoutInfo(MediaQuery.of(context));
    final repository = RepositoryProvider.of<IdeaRepository>(context);
    var ideas = repository.getList();

    routeEditor(idea) async {
      await Navigator.pushNamed(context, '/editor', arguments: idea);
    }

    final appBar = KowanasAppBar(leadingIcon: Icons.menu,
      color: Colors.orange, subject: _title,
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
                        if (ideas.length <= 0)
                          return Container(child:Center(child:FlatButton(
                            child:Text('Add your new idea',
                              style: TextStyle(fontSize: layoutInfo.mediumfont)),
                            onPressed: (){routeEditor(repository.getNew());},)));
                        else {
                          return BlocProvider<ViewModeBloc>(
                              create: (_) => ViewModeBloc(),
                              child: CarouselSlider.builder(
                                options: CarouselOptions(viewportFraction: 1.0,
                                  height: layoutInfo.fullLayoutHeight),
                                  itemCount: ideas.length,
                                  itemBuilder: (context, index) {
                                    BlocProvider.of<ViewModeBloc>(context)
                                      .add(ViewModeEventInit());
                                    return GestureDetector(
                                      onTap: (){routeEditor(ideas[index]);},
                                      child:IdeaPage(idea:ideas[index]));
                                    },));
                        }
                      }});
              })),
      ));
  }
}