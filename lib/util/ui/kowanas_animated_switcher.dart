import 'package:flutter/cupertino.dart';

class KowanasAnimatedSwitcher extends AnimatedSwitcher{
  final child;
  KowanasAnimatedSwitcher({this.child}):super(child:child,
    duration: const Duration(milliseconds: 500),
    transitionBuilder: (Widget child, Animation<double> animation) {
      return FadeTransition(child: child, opacity: animation);
    },
  );
}
/*
transitionBuilder: (Widget child, Animation<double> animation) { return FadeTransition(opacity: animation, child: child); }

PositionedTransition(
rect: RelativeRectTween(
begin: RelativeRect.fromSize(
Rect.fromLTWH(0, 0, smallLogo, smallLogo), biggest),
end: RelativeRect.fromSize(
Rect.fromLTWH(biggest.width - bigLogo,
biggest.height - bigLogo, bigLogo, bigLogo),
biggest),
).animate(CurvedAnimation(
parent: _controller,
curve: Curves.elasticInOut,
)),
AnimatedOpacity( opacity: opacityValue, duration: Duration(seconds: 1), child: FlutterLogo( size: 100.0, ), ),
*/