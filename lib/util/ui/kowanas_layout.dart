import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KowanasFont{
  static final defaultSize = 16.0;
  static final h1 = 2.0;
  static final h2 = 1.6;
  static final h3 = 1.4;
  static final huge = 2.6;
  static final large = 1.2;
  static final medium = 1.0;
  static final small = 0.8;
  static final tiny = 0.6;
}

class KowanasLayoutInfo{
  final MediaQueryData mediaQueryData;
  var scaledWidth;
  var scaledHeight;
  var scaleFontSize;
  final _defaultDPR = 3.5; // Nexus 6 default DPR
  var appBarSize = 0.0;

  KowanasLayoutInfo(this.mediaQueryData){
    scaledWidth = mediaQueryData.size.width/100.0;
    scaledHeight = mediaQueryData.size.height/100.0;
    scaleFontSize = KowanasFont.defaultSize/mediaQueryData.textScaleFactor
        * scaledWidth/_defaultDPR;
  }

  get h1font => scaleFontSize*KowanasFont.h1;
  get h2font => scaleFontSize*KowanasFont.h2;
  get h3font => scaleFontSize*KowanasFont.h3;
  get hugefont => scaleFontSize*KowanasFont.huge;
  get largefont => scaleFontSize*KowanasFont.large;
  get mediumfont => scaleFontSize*KowanasFont.medium;
  get smallfont => scaleFontSize*KowanasFont.small;
  get tinyfont => scaleFontSize*KowanasFont.tiny;

  get fullWidth => mediaQueryData.size.width;
  get fullHeight => mediaQueryData.size.height;
  get fullLayoutHeight => mediaQueryData.size.height-appBarSize;

  getWidth(percent) => scaledWidth*percent;
  getHeight(percent) => scaledHeight*percent;
  getGlobalHeight(x) => x/scaledHeight;
}

class KowanasLayout extends InheritedWidget{
  final KowanasLayoutInfo data;

  KowanasLayout({Key key, @required this.data, @required Widget child}):
      assert(data != null),
      assert(child != null),
      super(key: key, child: child);

  @override
  bool updateShouldNotify(KowanasLayout old) => data != old.data;

  static KowanasLayoutInfo of(context){
    return context.dependOnInheritedWidgetOfExactType<KowanasLayout>().data;
  }
}