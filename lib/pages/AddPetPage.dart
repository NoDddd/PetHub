import 'package:flutter/material.dart';
import 'dart:math' show pi;

import 'package:tvarinki/models/pet.dart';

class AddPetPage extends StatefulWidget {
  @override
  _StateAddPetPage createState() => _StateAddPetPage();
  }
  
  class _StateAddPetPage extends State<AddPetPage> {
    Pet _pet = new Pet();
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();    

    void createpet() {
      if (_pet.alias == null || _pet.alias == '') 
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Error input for alias', style: TextStyle(color: Colors.red[700])), duration: Duration(seconds: 3),));
      else if (_pet.type == null || _pet.type == '')
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Error input for type', style: TextStyle(color: Colors.red[700])), duration: Duration(seconds: 3),));
      else if (_pet.hashtag == null || _pet.hashtag == '')
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Error input for hashtag', style: TextStyle(color: Colors.red[700])), duration: Duration(seconds: 3),));
      else if (!_pet.hashtag.contains('#')) {
        _pet.hashtag = '#' + _pet.hashtag;
        Navigator.of(context).pop(_pet);
      }
      else {
        Navigator.of(context).pop(_pet);
      }
    }

  Widget build (BuildContext context) {
    return SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(leading: FittedBox(child: Icon(Icons.pets, color: Colors.black), fit: BoxFit.fitWidth), title: Text('Account Settings', style: TextStyle(color: Colors.black)), backgroundColor: Colors.yellow,),
            body: Container(
              width: double.infinity,
              color: Colors.black54,
              child: Column(
                children: [
              Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border:  OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow, width: 1),),
                        hintText: 'alias',
                        helperText: "here put pet's alias like Salem",
                        helperMaxLines: 2,
                        hintStyle: TextStyle(color: Colors.yellow[200]),
                        helperStyle: TextStyle(color: Colors.yellow[200])
                      ),
                      onChanged: (str) { setState(() {_pet.alias = str;});},
                    ),
                  )
              ),
              Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow, width: 0.5),),
                        hintText: 'hashtag',
                        helperText: 'put in unique hashtag of pet like #salem_coolest_cat_ever',
                        helperMaxLines: 2,
                        hintStyle: TextStyle(color: Colors.yellow[200]),
                        helperStyle: TextStyle(color: Colors.yellow[200])
                      ),
                      onChanged: (str) { setState(() {_pet.hashtag = str;});},
                    ),
                  )
              ),
              Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 0.5),),
                        hintText: 'type',
                        helperText: 'here put type of pet like cat or dog',
                        helperMaxLines: 2,
                        hintStyle: TextStyle(color: Colors.yellow[200]),
                        helperStyle: TextStyle(color: Colors.yellow[200])
                      ),
                      onChanged: (str) { setState(() {_pet.type = str.toLowerCase();});},
                    ),
                  )
              ),
              Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 0.5),),
                        hintText: 'subtype',
                        helperText: "put in pet's breed or just skip it",
                        helperMaxLines: 2,
                        hintStyle: TextStyle(color: Colors.yellow[200]),
                        helperStyle: TextStyle(color: Colors.yellow[200])
                      ),
                      onChanged: (str) { setState(() {_pet.subtype = str;});},
                    ),
                  )
              ),
              Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 0.5),),
                        hintText: 'bio',
                        helperText: "put in pet's biography or just skip it",
                        helperMaxLines: 2,
                        hintStyle: TextStyle(color: Colors.yellow[200]),
                        helperStyle: TextStyle(color: Colors.yellow[200])
                      ),
                      onChanged: (str) { setState(() {_pet.bio = str;});},
                    ),
                  )
              ) 
              ]),
          ),
          floatingActionButton: IconButton(
            icon: Icon(Icons.done, color: Colors.yellow,), 
            hoverColor: Colors.yellow,
            onPressed: () {createpet();}),
      ),
    );
  }
}