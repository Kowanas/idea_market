import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KowanasAnimatedSwitcher extends AnimatedSwitcher{
  final child;
  KowanasAnimatedSwitcher({this.child}):super(child:child,
    duration: const Duration(milliseconds: 10000));
}
