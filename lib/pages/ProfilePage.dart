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
          child: Text(widget._user.nickname, textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Cinzel'),), 
          ),
          Flexible(flex:  9,
          child: widget._pets == null ?
          CircularProgressIndicator() :
          ListView.builder(
            itemCount: widget._pets.length,
            itemBuilder: (context, i) {
              return ListTile(
                title: Text(widget._pets[i].alias, style: TextStyle(fontFamily: 'Cinzel', fontSize: 17)),
                leading: Icon(Icons.pets),
                subtitle: Text(widget._pets[i].type),
                trailing: Text(widget._pets[i].hashtag),
              );
            }
            ),
          ),
          Flexible(flex: 1, 
          child: IconButton(icon: Icon(Icons.cancel), iconSize: 50, onPressed: () {signInGoogle.signOut();},),
          ),
        ],
      )      
    );
  } 
}