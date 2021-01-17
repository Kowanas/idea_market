import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KowanasCommandBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FlatButton(onPressed: (){},
          child: Text('add task', style: TextStyle(color: Colors.redAccent))),
        IconButton(onPressed: (){},
          icon: Icon(Icons.camera_alt, color: Colors.redAccent,),)
    ],);
  }
}