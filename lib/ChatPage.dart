import 'package:flutter/material.dart';
import 'dart:math' show Random;

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Random random = new Random();

  @override 
  Widget build(BuildContext contex) {
    return ListView(
        children: <Widget>[
          for (var i = 0; i < 7; i++) 
          Column(children: [
          ListTile(leading: Icon(Icons.chat_bubble_outline), title: Text('person $i'), trailing: Icon(Icons.pets), subtitle: Text('last messege from person $i', textScaleFactor: .6,),),
          Divider(color: Colors.red, height: 7, thickness: 2,)
          ])
        ],
    );
    
  }
}