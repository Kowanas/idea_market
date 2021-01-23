import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ad_bloc.dart';

class AdBannerContainer extends StatefulWidget {
  final child;
  final height;
  final adMargin;
  final adFree;

  const AdBannerContainer({Key key, this.height, this.adMargin,
    this.adFree = false, this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdBannerContainerState();
}

class AdBannerContainerState extends State<AdBannerContainer>{
  AdBloc _adBloc;
  @override
  void dispose() {
    _adBloc?.add(AdEventResetBannerBottom());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _adBloc = BlocProvider.of<AdBloc>(context);
    _startAd(){
      _adBloc?.add(AdEventStartBannerBottom(context));
    }
    _stopAd(){
      _adBloc?.add(AdEventStopBannerBottom(context));
    }
    return BlocListener<AdBloc, AdState>(listener: (context, state){
        if (state is AdStateBannerBottom || state is AdStateBannerBottomLoading)
          if (widget.adFree == true) _stopAd();},
      child: BlocBuilder<AdBloc, AdState>(
        builder: (context, state){
          if (state is AdStateNone) _startAd();
          if (state is AdStateBannerBottomLoading) _stopAd();
          if (state is AdStateBannerBottom) {
            if (widget.adFree == true){
              _stopAd();
              return Container(height: widget.height, child: widget.child);
            }else return Container(
                height: widget.height,
                margin: EdgeInsets.only(
                    bottom: (widget.adMargin == true) ? state.height.toDouble() : 0),
                child: widget.child);
          }
          else return Container(height: widget.height, child: widget.child);
        }
      ));
  }
}