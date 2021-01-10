import 'package:flutter/widgets.dart';
import 'package:idea_market/util/ads/ad_banner_container.dart';

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