import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idea_market/util/ads/ad_bloc.dart';

class KowanasCamera extends StatefulWidget{
  final List<CameraDescription> cameras;

  const KowanasCamera({Key key, this.cameras}) : super(key: key);

  @override
  State<StatefulWidget> createState() => KowanasCameraState();
}

class KowanasCameraState extends State<KowanasCamera>{
  CameraController controller;
  AdBloc _adBloc;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted){ return; }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _adBloc..add(AdEventResetBannerBottom());
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _adBloc = BlocProvider.of<AdBloc>(context);
    _stopAd(){
      _adBloc?.add(AdEventStopBannerBottom(context));
    }
    if (!controller.value.isInitialized) return Container();
    return BlocListener<AdBloc, AdState>(listener: (context, state){
        if (state is AdStateBannerBottom || state is AdStateBannerBottomLoading)
          _stopAd();
      },
      child: BlocBuilder<AdBloc, AdState>(builder: (context, state){
        if (state is AdStateBannerBottom || state is AdStateBannerBottomLoading)
          _stopAd();
        return AspectRatio(aspectRatio: controller.value.aspectRatio,
          child: CameraPreview(controller));}));
  }
}