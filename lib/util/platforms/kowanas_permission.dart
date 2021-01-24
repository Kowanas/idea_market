import 'package:flutter/services.dart';

class KowanasPermission{
  static const STORAGE = "storage";

  static final _instance = KowanasPermission._internal();
  static const platform = const MethodChannel('com.kowanas.idea_market/main');

  factory KowanasPermission(){
    return _instance;
  }

  requestPermission(String permission, {bool popup = true}) async{
    return await platform.invokeMethod('request_permission',
        <String, dynamic>{'permission':permission, 'popup':popup.toString()});
  }

  KowanasPermission._internal();
}