import 'package:flutter/material.dart';

import 'kowanas_layout.dart';

class KowanasAppBar extends AppBar {
  final MaterialColor color;
  final String subject;
  final double rightgap;
  final double size;
  double height;

  KowanasAppBar({Key key, @required this.color, @required this.subject,
    @required this.rightgap, @required this.size})
      : assert(color != null),
        assert(subject != null),
        assert(rightgap != null),
        assert(size != null),
        super(key: key,
          backgroundColor: Color(0x00000000),
          elevation: 0,
          centerTitle: true,
          leading: Icon(Icons.menu, color: color, size: size),
          title: SizedBox(height: size,
              child: FittedBox(fit: BoxFit.fitHeight,
                child:Text(subject,
                  style: TextStyle(color: color.shade900, fontSize: size)))),
          actions: []
      );

  addActions(icon, onTap) {
    actions.add(Padding(padding: EdgeInsets.only(right: rightgap),
        child: GestureDetector(
            child: Icon(icon, color: Colors.orange, size: size),
            onTap: onTap)));
  }
}