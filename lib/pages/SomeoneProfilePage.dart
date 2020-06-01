import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:PetHub/models/pet.dart';
import 'package:PetHub/models/user.dart';
import './MainPage.dart' show firestore;


class SomeoneProfilePage extends StatefulWidget {
  User _user;
  SomeoneProfilePage(User user) {
    _user = user;
  }
  @override
  _SomeoneProfilePageState createState() => _SomeoneProfilePageState();
  
}

class _SomeoneProfilePageState extends State<SomeoneProfilePage> {
  List<Pet> _pets;
  @override
  void initState() {
    get_pets();
    super.initState();
  }

  void get_pets() async {
    var petsRef = firestore.collection('/users/' + widget._user.id + '/pets');
    var query_snap_pets = await petsRef.getDocuments();
    var docs_pets = query_snap_pets.documents;
    var pets = new List<Pet>();
    for (var i in docs_pets) {
      pets.add(Pet.fromDoc(i));
    }
    setState(() {
      _pets = pets;
    });
  }

  @override 
  Widget build(BuildContext contex) {
    return Scaffold(
      appBar: AppBar(title: Text('PetHub', style: TextStyle(color: Colors.indigo[900]),), 
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black), onPressed: () {Navigator.of(context).pop();},)), 
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(flex: 1,
            child: Text(widget._user.nickname, textAlign: TextAlign.center, style: TextStyle(color: Colors.yellow, fontSize: 20, fontFamily: 'Cinzel'),), 
            ),
            Flexible(
            flex: 1,
            child: Container(
                child: Text(widget._user.profile, textAlign: TextAlign.center, style: TextStyle(color: Colors.yellowAccent, fontSize: 10, fontFamily: 'Martel'),), 
              ),
            ),
          Divider(color: Colors.yellow, thickness: 2,),
          Flexible(
          flex:  9,
          child: _pets == null ?
          CircularProgressIndicator() :
          ListView.builder(
            itemCount: _pets.length,
            itemBuilder: (context, i) {
              return 
              Column(
                children: <Widget>[
                  ListTile(
                    title: Text(_pets[i].alias, style: TextStyle(fontFamily: 'Cinzel', fontSize: 17, color: Colors.yellow)),
                    leading: Icon(Icons.pets, color: Colors.yellowAccent[100]),
                    subtitle: Text(_pets[i].type, style: TextStyle(color: Colors.yellow)),
                    trailing: Text(_pets[i].hashtag, style: TextStyle(color: Colors.yellow)),
                  ),
                  Container(
                  height: 100,
                  child: FutureBuilder(
                    future: Firestore.instance.collection('/users/'+ widget._user.id + '/pets/' + _pets[i].hashtag + '/posts').orderBy('time').getDocuments(),
                    builder: (context, snapshots) {
                      if (!snapshots.hasData)
                      return Container(child: LinearProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow)));
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
                  Divider(color: Colors.yellow.withOpacity(0.6), height: 10, thickness: 2),
                ],
              );
            }
            ),
          ),
          ],
        )      
      ),
    );
  } 
}