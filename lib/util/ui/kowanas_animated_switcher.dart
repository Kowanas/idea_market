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