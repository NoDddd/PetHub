import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tvarinki/models/pet.dart';
import './MainPage.dart' show signInGoogle;
import 'package:tvarinki/models/user.dart';


class ProfilePage extends StatefulWidget {
  User _user;
  List<Pet> _pets;
  ProfilePage(User user, pets) {
    _user = user;
    _pets = pets;
  }
  @override
  _ProfilePageState createState() => _ProfilePageState();
  
}

class _ProfilePageState extends State<ProfilePage> {
  bool visible = true;
  @override 
  Widget build(BuildContext contex) {
    return Container(
      child: Column(
        children: <Widget>[
          Flexible(flex: 1,
          child: Text(widget._user.nickname, textAlign: TextAlign.center, style: TextStyle(color: Colors.yellowAccent, fontSize: 22, fontFamily: 'Cinzel'),), 
          ),
          Flexible(flex:  9,
          child: widget._pets == null ?
          CircularProgressIndicator() :
          ListView.builder(
            itemCount: widget._pets.length,
            itemBuilder: (context, i) {
              return ListTile(
                title: Text(widget._pets[i].alias, style: TextStyle(fontFamily: 'Cinzel', fontSize: 17, color: Colors.yellow)),
                leading: Icon(Icons.pets, color: Colors.yellowAccent[100]),
                subtitle: Text(widget._pets[i].type, style: TextStyle(color: Colors.yellow)),
                trailing: Text(widget._pets[i].hashtag, style: TextStyle(color: Colors.yellow)),
              );
            }
            ),
          ),
          Flexible(flex: 1, 
          child: IconButton(icon: Icon(Icons.cancel, color: Colors.yellow), iconSize: 50, onPressed: () {signInGoogle.signOut();},),
          ),
        ],
      )      
    );
  } 
}