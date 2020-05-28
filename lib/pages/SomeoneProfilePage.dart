import 'package:flutter/material.dart';
import 'package:tvarinki/models/pet.dart';
import 'package:tvarinki/models/user.dart';
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
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Navigator.of(context).pop();},)), 
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(flex: 1,
            child: Text(widget._user.nickname, textAlign: TextAlign.center, style: TextStyle(color: Colors.yellow, fontSize: 20, fontFamily: 'Cinzel'),), 
            ),
            Flexible(flex:  9,
            child: _pets == null ?
            CircularProgressIndicator() :
            ListView.builder(
              itemCount: _pets.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(_pets[i].alias, style: TextStyle(fontFamily: 'Cinzel', fontSize: 17, color: Colors.yellow)),
                  leading: Icon(Icons.pets, color: Colors.yellowAccent[100]),
                  subtitle: Text(_pets[i].type, style: TextStyle(color: Colors.yellow),),
                  trailing: Text(_pets[i].hashtag, style: TextStyle(color: Colors.yellow)),
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