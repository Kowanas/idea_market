import 'dart:convert';

class Idea{
  static const newId = -1;
  final int uid;
  String title;
  String role;
  String goal;
  String value;
  DateTime created;
  String background;

  Idea(this.uid, this.created,
      {this.title = "", this.role = "", this.goal = "", this.value = "",
        this.background});

  bool verify(){
    if (uid == null) return false;
    if (created == null) return false;
    return true;
  }

  void setBackground(String path){
    background = path;
  }

  static Idea fromJson(String json){
    Map<String, dynamic> data = jsonDecode(json);
    Idea idea;
    try {
      idea = Idea(data['uid'], DateTime.parse(data['created']));
    }catch (e){
      return null;
    }
    idea.title = data['title'];
    idea.role = data['role'];
    idea.goal = data['goal'];
    idea.value = data['value'];
    idea.background = data['background'];
    return idea;
  }

  String toJson(){
    Map<String, dynamic> data = Map<String, dynamic>();
    data['uid'] = uid;
    data['title'] = title;
    data['role'] = role;
    data['goal'] = goal;
    data['value'] = value;
    data['created'] = created.toString();
    data['background'] = background;
    return jsonEncode(data);
  }
}