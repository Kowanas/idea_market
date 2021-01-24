import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idea_market/bloc/idea_bloc.dart';
import 'package:idea_market/model/idea.dart';
import 'package:idea_market/util/ui/kowanas_layout.dart';
import 'package:intl/intl.dart';

class IdeaInfo extends StatelessWidget{
  final Idea idea;

  const IdeaInfo({Key key, this.idea}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    KowanasLayoutInfo layoutInfo = KowanasLayout.of(context);
    return Row(
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
    );
  }
}