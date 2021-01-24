import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'kowanas_appbar.dart';

class KowanasPage extends StatelessWidget{
  final KowanasAppBar appBar;
  final Color backgroundColor;
  final Image backgroundImage;
  final Widget body;

  const KowanasPage({Key key, this.appBar, this.backgroundColor,
    this.backgroundImage, @required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Expanded(child: Container(color: backgroundColor))
    ],);
  }
}