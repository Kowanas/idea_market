import 'package:shared_preferences/shared_preferences.dart';
import 'idea.dart';

class IdeaRepository{
  static const _datakey = "Idea";
  Map<int, Idea> _ideas = Map<int, Idea>();
  int lastId = Idea.newId;

  List<Idea> getList (){
    return _ideas.values.toList();
  }

  Idea getNew(){
    lastId += 1;
    _ideas[lastId] = Idea(lastId, DateTime.now());
    return _ideas[lastId];
  }

  Idea get(int uid){
    return _ideas[uid];
  }

  void set(Idea idea){
    _ideas[idea.uid] = idea;
  }

  void delete(int uid){
    _ideas.remove(uid);
  }

  Future<void> fetch() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final data = pref.getStringList(_datakey);
    data?.forEach((element) {
      final idea = Idea.fromJson(element);
      if (idea != null && idea.verify()) {
        set(idea);
        lastId = (idea.uid > lastId)?idea.uid:lastId;
      }
    });
  }

  Future<void> save() async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var data = <String>[];
    _ideas.forEach((key, value) {
      if (value.verify()) data.add(value.toJson());
      else _ideas.remove(value.uid);
    });
    await pref.setStringList(_datakey, data);
  }
}
