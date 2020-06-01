import 'package:PetHub/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'IndividualChat.dart';


Firestore firestore = Firestore.instance;

class ChatPage extends StatefulWidget {
  User _user;
  ChatPage(User user){ 
    _user = user;
  }
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  

  @override 
  Widget build(BuildContext contex) {
    return Container(
      color: Colors.black,
      child: StreamBuilder(
        stream: firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
          return CircularProgressIndicator();
          else return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, i) {
              //if (snapshot.data.documents[i]['id'] != widget._user.id)
              return  Column(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.black, Color(0xFF363600)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                              )
                            ),
                          child: ListTile(
                            title: Text(snapshot.data.documents[i]['nickname'], style: TextStyle(color: Colors.yellow)),
                            leading: Icon(Icons.person_outline, color: Colors.yellow),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => IndividualPage(widget._user, User.fromDoc(snapshot.data.documents[i]))));
                            },
                          )
                      )
                  ),
                  Divider(color: Colors.yellow.withOpacity(0.2), thickness: 2,)
                ],
              );
            },
          );
        }
      )
    );
    
  }
}