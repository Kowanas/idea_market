import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idea_market/util/ads/ad_info_banner.dart';

class AdBloc extends Bloc<AdEvent, AdState>{
  AdBannerInfo adBannerInfo;

  AdBloc() : super(AdStateNone());

  @override
  Stream<AdState> mapEventToState(event) async* {
    if (event is AdEventStartBannerBottom) {
      yield AdStateBannerBottomLoading();
      // set testAd to false after set your ad id and app id
      // which are contained in AndroidManifest.xml and ad_info.dart
      adBannerInfo = AdBannerInfo(event.context, testAd: true);
      adBannerInfo.start(
        (){add(AdEventStartBannerBottomCompleted(event.context));},
        (){add(AdEventStopBannerBottom(event.context));}
      );
    }else if (event is AdEventStartBannerBottomCompleted){
      yield AdStateBannerBottom(adBannerInfo.height);
    }else if (event is AdEventStopBannerBottom){
      await adBannerInfo.stop();
      yield AdStatePaused();
    }else if (event is AdEventResetBannerBottom){
      yield AdStateNone();
    }
  }
}

abstract class AdState {
  final height;
  AdState({this.height = 0});
}
class AdStateNone extends AdState{}
class AdStatePaused extends AdState{}
class AdStateBannerBottomLoading extends AdState{}
class AdStateBannerBottom extends AdState{
  AdStateBannerBottom(height) : super(height:height);
}

abstract class AdEvent {
  final context;
  AdEvent(this.context);
}
class AdEventStartBannerBottom extends AdEvent{
  AdEventStartBannerBottom(context) : super(context);
}
class AdEventStartBannerBottomCompleted extends AdEvent{
  AdEventStartBannerBottomCompleted(context) : super(context);
}
class AdEventStopBannerBottom extends AdEvent{
  AdEventStopBannerBottom(context) : super(context);
}
class AdEventResetBannerBottom extends AdEvent{
  AdEventResetBannerBottom() : super(null);
}