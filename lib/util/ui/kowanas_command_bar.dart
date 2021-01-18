import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'kowanas_layout.dart';

class KowanasCommandBar extends StatelessWidget{
  final Map<String, dynamic> command;
  final actions;

  const KowanasCommandBar({Key key, this.command, this.actions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    KowanasLayoutInfo layoutInfo = KowanasLayout.of(context);
    return Padding(padding: EdgeInsets.fromLTRB(layoutInfo.getWidth(5), 0,
        layoutInfo.getWidth(5), 0),
      child: Row(children: [
        Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(30),
          child: FlatButton(child: Text(command.keys.first,
            style: TextStyle(color: Colors.redAccent)),
            onPressed: command.values.first, color: Colors.grey.shade200))),
        Row(children: actions,)
      ]));
  }
}