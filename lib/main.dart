import 'package:camera/camera.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idea_market/model/idea_repository.dart';
import 'package:page_transition/page_transition.dart';

import 'bloc/idea_bloc.dart';
import 'model/idea.dart';
import 'ui/home.dart';
import 'ui/idea_editor.dart';
import 'util/ads/ad_bloc.dart';
import 'util/ui/kowanas_camera.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  cameras = await availableCameras();
  runApp(RepositoryProvider(create: (context) => IdeaRepository(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider<IdeaBloc>(
          create: (_) => IdeaBloc(RepositoryProvider.of<IdeaRepository>(context))
            ..add(IdeaEventFetching())),
        BlocProvider<AdBloc>(
          create: (_) => AdBloc())
      ],
      child: MaterialApp(initialRoute: '/',
        onGenerateRoute: (settings){
          switch(settings.name) {
            case '/editor':
              return PageTransition(
                child: IdeaEditor(idea: settings.arguments as Idea),
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 500));
          }
        },
        routes: {
          '/': (_) => Home(),
          '/camera': (_) => KowanasCamera(cameras: cameras)
      }));
  }
}
