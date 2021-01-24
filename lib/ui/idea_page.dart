import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idea_market/bloc/viewmode_bloc.dart';
import 'package:idea_market/model/idea.dart';
import 'package:idea_market/util/ads/ad_bloc.dart';
import 'package:idea_market/util/platforms/kowanas_permission.dart';
import 'package:idea_market/util/ui/kowanas_animated_switcher.dart';
import 'package:idea_market/util/ui/kowanas_command_bar.dart';
import 'package:idea_market/util/ui/kowanas_layout.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'idea_card_full.dart';
import 'idea_card_mini.dart';
import 'idea_card_short.dart';

class IdeaPage extends StatefulWidget {
  final Idea idea;
  IdeaPage({Key key, this.idea}) : super(key: key);

  @override
  State<StatefulWidget> createState() => IdeaPageState();
}

class IdeaPageState extends State<IdeaPage>{
  @override
  void initState() {
    super.initState();
  }

  Future<String> _capture() async{
    final picker = ImagePicker();
    final PickedFile pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final File image = File(pickedFile.path);
      final dir = await getApplicationDocumentsDirectory();
      final File newImage = await image.copy(
          dir.path + '/' + widget.idea.uid.toString() + '.png');

      return newImage.path;
    }
    throw("not captured");
  }

  _checkPermission() async{
    return await KowanasPermission().requestPermission(KowanasPermission.STORAGE);
  }

  _captureCamera() async {
    if (await _checkPermission() == true) {
      try {
        return await _capture();
      }catch (e){
        return '';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    KowanasLayoutInfo layoutInfo = KowanasLayout.of(context);
    var viewModeBloc = BlocProvider.of<ViewModeBloc>(context);
    return GestureDetector(
      onPanEnd: (detail){
        if (detail.velocity.pixelsPerSecond.dy < -100.0)
          viewModeBloc.add(ViewModeEventDown());
        if (detail.velocity.pixelsPerSecond.dy > 100.0)
          viewModeBloc.add(ViewModeEventUp());
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BlocBuilder<ViewModeBloc, ViewModeState>(
              builder: (context, state){
                if (state is ViewModeStateMini)
                  return IdeaCardMini(idea:widget.idea);
                else if (state is ViewModeStateShort)
                  return IdeaCardShort(idea:widget.idea);
                else if (state is ViewModeStateFull)
                  return IdeaCardFull(idea:widget.idea);
              }),
          KowanasCommandBar(command: {'add task': () => {}},
            actions: [
              BlocBuilder<AdBloc, AdState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: (){ _captureCamera(); },
                    icon: Icon(Icons.camera_alt, color: Colors.redAccent,),);
                }
              ),
            ])
        ],)
    );
  }
}