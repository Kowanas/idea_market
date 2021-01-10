import 'package:flutter/material.dart';

class KowanasCardsPage extends StatelessWidget{
  final child;
  final height;
  final paddingSize;

  const KowanasCardsPage({Key key, @required this.child,
    @required this.height, this.paddingSize = 5.0}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(paddingSize),
        width: MediaQuery.of(context).size.width,
        height: height,
        child: Card(child: child,
          shape: RoundedRectangleBorder(side: BorderSide(width: 1.0),
              borderRadius: BorderRadius.circular(15)),
        ));
  }
}