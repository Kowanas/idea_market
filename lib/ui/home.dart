import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idea_market/bloc/idea_bloc.dart';
import 'package:idea_market/model/idea.dart';
import 'package:idea_market/model/idea_repository.dart';
import 'package:intl/intl.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ideas')),
      body: BlocBuilder<IdeaBloc, IdeaState>(
        builder: (context, state) {
          if (state is IdeaStateNotInitialized)
            return Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child:CircularProgressIndicator())
              ],);
          else if (state is IdeaStateFetched){
            final repository = RepositoryProvider.of<IdeaRepository>(context);
            final ideas = repository.getList();
            return ListView.builder(
              itemCount: ideas.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: () {Navigator.pushNamed(context, '/editor', arguments: ideas[index]);},
                  child:IdeaCard(idea:ideas[index]));
              },
            );
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        onPressed: () {Navigator.pushNamed(context, '/editor', arguments: RepositoryProvider.of<IdeaRepository>(context).getNew());},
      ),
    );
  }
}

class IdeaCard extends StatelessWidget{
  final Idea idea;

  IdeaCard({Key key, this.idea}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1.0),
        borderRadius: BorderRadius.circular(15)
      ),
      margin: EdgeInsets.fromLTRB(10, 15, 10, 10),
      child: Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(child:Text(idea.uid.toString()+'. '+idea.title,
                    style: TextStyle(fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic))),
                  Text(DateFormat('yyyy-MM-dd').format(idea.created),
                    style: TextStyle(fontStyle: FontStyle.italic)),
                  PopupMenuButton(
                    onSelected: (select){
                      BlocProvider.of<IdeaBloc>(context)..add(IdeaEventDeleting(idea));
                    },
                    itemBuilder: (context) => <PopupMenuEntry>[
                      const PopupMenuItem(value: 0,
                      child: Text('delete'))
                    ]
                  )
              ]),
              IdeaCardShort(title: 'As a ', titleColor: Colors.red, text: idea.role),
              IdeaCardShort(title: 'I want ', titleColor: Colors.green, text: idea.goal),
              IdeaCardShort(title: 'So that ', titleColor: Colors.blue, text: idea.value)
          ],
        )
      )
    );
  }
}

class IdeaCardShort extends StatelessWidget{
  final title;
  final titleColor;
  final text;

  const IdeaCardShort({Key key, this.title, this.titleColor, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: titleColor)),
        Expanded(child:Text(text, style: TextStyle(color: Colors.blueGrey))),
      ],);
  }
}