import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idea_market/model/idea_repository.dart';

import 'bloc/idea_bloc.dart';
import 'ui/home.dart';
import 'ui/idea_editor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => IdeaRepository(),
      child: BlocProvider(
        create: (context) => IdeaBloc(RepositoryProvider.of<IdeaRepository>(context))
          ..add(IdeaEventFetching()),
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => Home(),
            '/editor': (context) => IdeaEditor()
      },)));
  }
}
