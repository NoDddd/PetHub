import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:PetHub/models/pet.dart';
import './MainPage.dart' show signInGoogle, auth, usersRef;
import 'package:PetHub/models/user.dart';


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
  String path = usersRef.path;
  bool visible = true;
  @override 
  Widget build(BuildContext contex) {
    CollectionReference pets = Firestore.instance.collection('/$path/pets');
    String pet_path = pets.path;
    return Container(
      child: Column(
        children: <Widget>[
          Flexible(flex: 1,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Color(0xFF1c1c01)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                  )
                ),
            child: Text(widget._user.nickname, textAlign: TextAlign.center, style: TextStyle(color: Colors.yellowAccent, fontSize: 22, fontFamily: 'Martel'),)
            ), 
          ),
          Divider(color: Colors.yellow, thickness: 2,),
          Flexible(
          flex:  9,
          child: widget._pets == null ?
          CircularProgressIndicator() :
          ListView.builder(
            itemCount: widget._pets.length,
            itemBuilder: (context, i) {
              return 
              Column(
                children: <Widget>[
                  ListTile(
                    title: Text(widget._pets[i].alias, style: TextStyle(fontFamily: 'Cinzel', fontSize: 17, color: Colors.yellow)),
                    leading: Icon(Icons.pets, color: Colors.yellowAccent[100]),
                    subtitle: Text(widget._pets[i].type, style: TextStyle(color: Colors.yellow)),
                    trailing: Text(widget._pets[i].hashtag, style: TextStyle(color: Colors.yellow)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black, Color(0xFF363600)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter
                        )
                      ),
                  height: 100,
                  child: FutureBuilder(
                    future: Firestore.instance.collection('/users/'+ widget._user.id + '/pets/' + widget._pets[i].hashtag + '/posts').orderBy('time',descending: true).getDocuments(),
                    builder: (context, snapshots) {
                      if (!snapshots.hasData)
                      return Container(child: LinearProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow), backgroundColor: Colors.black,));
                      else
                      return ListView.builder(
                        itemExtent: 100,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshots.data.documents.length,
                        itemBuilder: (context, j) {
                          return Image.network(snapshots.data.documents[j]['url']);
                        }
                      );
                    }
                  )
                  ),
                  Divider(color: Colors.yellow.withOpacity(0.6), height: 10, thickness: 2,)
                ],
              );
            }
            ),
          ),
        ],
      )      
    );
  } 
}