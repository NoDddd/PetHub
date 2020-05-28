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
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: ListTile(leading: Icon(Icons.chat_bubble_outline), 
            title: Text('person $i', style: TextStyle(color: Colors.yellow)), 
            trailing: Icon(Icons.pets, color: Colors.yellow[300]), 
            ),
          ),
          Divider(color: Colors.yellow, height: 7, thickness: 2,)
          ])
        ],
    );
    
  }
}