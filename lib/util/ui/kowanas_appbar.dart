import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KowanasAppBar extends AppBar {
  final MaterialColor color;
  final leadingIcon;
  final leadingOnTap;
  final String subject;
  final double rightgap;
  final double size;
  double height;

  KowanasAppBar({this.leadingIcon, this.leadingOnTap, Key key, @required this.color, @required this.subject,
    @required this.rightgap, @required this.size})
      : assert(color != null),
        assert(subject != null),
        assert(rightgap != null),
        assert(size != null),
        super(key: key,
          backgroundColor: Color(0x00000000),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(icon:Icon(leadingIcon, size:size, color:color),
              onPressed: leadingOnTap),
          title: SizedBox(height: size,
              child: FittedBox(fit: BoxFit.scaleDown,
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