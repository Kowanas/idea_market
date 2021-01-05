import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idea_market/model/idea_repository.dart';

import 'bloc/idea_bloc.dart';
import 'ui/home.dart';
import 'ui/idea_editor.dart';
import 'util/ads/ad_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
        routes: {
          '/': (_) => Home(),
          '/editor': (_) => IdeaEditor()
        },));
  }
}
