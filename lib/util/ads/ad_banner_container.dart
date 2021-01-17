import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ad_bloc.dart';

class AdBannerContainer extends StatelessWidget{
  final child;
  final height;
  final adMargin;
  AdBannerContainer({Key key, @required this.child, this.height,
    this.adMargin = true});

  @override
  Widget build(BuildContext context) {
    final adBloc = BlocProvider.of<AdBloc>(context);
    return BlocBuilder<AdBloc, AdState>(
        builder: (context, state){
          if (state is AdStateNone)
            adBloc.add(AdEventStartBannerBottom(context));
          if (state is AdStateBannerBottom)
            return Container(
              height: height,
              margin: EdgeInsets.only(
                  bottom:(adMargin==true)?state.height.toDouble():0),
              child: child);
          else return Container(height: height, child: child);
        }
      );
  }
}