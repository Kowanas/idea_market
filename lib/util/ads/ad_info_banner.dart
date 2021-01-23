import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'ad_info.dart';

typedef OnLoaded = void Function();
typedef OnFailed = void Function();

class AdBannerInfo{
  final context;
  final bool testAd;
  BannerAd _ad;
  int height = 0;
  bool _isLoaded = false;
  OnLoaded _onLoaded;
  OnFailed _onFailed;

  AdBannerInfo(this.context, {this.testAd = false}){
    _createAd();
  }

  _reset(){
    _isLoaded = false;
    height = 0;
  }

  bool isLoaded(){
    return _isLoaded;
  }

  int _getSmartBannerHeight(){
    if (_isLoaded == false) return 0;
    var screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight <= 400) return 32;
    if (screenHeight <= 720) return 50;
    return 90;
  }

  _createAd(){
    final adUnitId = testAd ? BannerAd.testAdUnitId : AdInfo.unitIdBannerBottom;
    _ad = BannerAd(adUnitId:adUnitId, size: AdSize.smartBanner,
        listener: (event){
          if (event == MobileAdEvent.loaded) {
            _isLoaded = true;
            final newHeight = _getSmartBannerHeight();
            if (height != newHeight) {
              height = newHeight;
            }
            _onLoaded();
          }else if (event == MobileAdEvent.failedToLoad){
            _onFailed();
          }
        });
  }

  void start(onLoaded, onFailed) {
    _onLoaded = onLoaded;
    _onFailed = onFailed;
    _ad.load();
    _ad.show();
  }

  stop() async {
    if (_isLoaded == false) return;
    _reset();
    await _ad?.dispose();
  }
}