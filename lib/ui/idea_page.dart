import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idea_market/bloc/viewmode_bloc.dart';
import 'package:idea_market/model/idea.dart';
import 'package:idea_market/util/ui/kowanas_command_bar.dart';
import 'package:idea_market/util/ui/kowanas_layout.dart';

import 'idea_card_full.dart';
import 'idea_card_mini.dart';
import 'idea_card_short.dart';

class IdeaPage extends StatefulWidget {
  final Idea idea;
  IdeaPage({Key key, this.idea}) : super(key: key);

  @override
  State<StatefulWidget> createState() => IdeaPageState();
}

class IdeaPageState extends State<IdeaPage>{
  final sizes = [15.0, 45.0, 70.0];
  var currentSize;

  ViewModeEvent _getViewMode(double prev, double current){
    for (int i = 0; i < sizes.length; i++){
      if (sizes[i] > prev && sizes[i] <= current) return ViewModeEventUp();
      if (sizes[i] <= prev && sizes[i] > current) return ViewModeEventDown();
    }
    return null;
  }

  double _getSize(ViewModeState state){
    if (state is ViewModeStateMini) return sizes[0];
    if (state is ViewModeStateShort) return sizes[1];
    if (state is ViewModeStateFull) return sizes[2];
  }

  get _defaultSize => sizes[1];
  get _maxSize => sizes[2];
  get _minSize => sizes[0];

  @override
  void initState() {
    currentSize = _defaultSize;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    KowanasLayoutInfo layoutInfo = KowanasLayout.of(context);
    var viewModeBloc = BlocProvider.of<ViewModeBloc>(context);
    return GestureDetector(
      onVerticalDragUpdate: (detail){
        setState(() {
          final prev = currentSize;
          currentSize += layoutInfo.getGlobalHeight(detail.delta.dy);
          if (currentSize < _minSize) currentSize = _minSize;
          if (currentSize > _maxSize) currentSize = _maxSize;
          final newState = _getViewMode(prev, currentSize);
          if(newState != null) viewModeBloc.add(newState);
        });
      },
      onVerticalDragEnd: (detail){
        setState(() {
          currentSize = _getSize(viewModeBloc.state);
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BlocBuilder<ViewModeBloc, ViewModeState>(
              builder: (context, state){
                if (state is ViewModeStateMini)
                  return IdeaCardMini(idea:widget.idea, size: currentSize);
                else if (state is ViewModeStateShort)
                  return IdeaCardShort(idea:widget.idea, size: currentSize);
                else if (state is ViewModeStateFull)
                  return IdeaCardFull(idea:widget.idea, size: currentSize);
              }),
          KowanasCommandBar()
        ],)
    );
  }
}