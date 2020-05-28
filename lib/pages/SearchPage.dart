import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:tvarinki/models/user.dart';
import 'SomeoneProfilePage.dart';

class SearchPage extends StatefulWidget {
  CollectionReference _userRef;
  SearchPage(CollectionReference userRef) {
    _userRef = userRef;
  }
  _StateSearchPage createState() => _StateSearchPage();
  }
  
  class _StateSearchPage extends State<SearchPage>{
  TextEditingController search_text_contrl = new TextEditingController();
  var results;
  List<User> result_users;

  @override
  void initState() {
    search_text_contrl = new TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    search_text_contrl.dispose();
    super.dispose();
  }

  void show_result(String username) async {
    if (username.length > 0) {
    try{
    var docs_q = await widget._userRef.where('nickname', isGreaterThanOrEqualTo: username.toLowerCase()).getDocuments();
    var users_doc = docs_q.documents;
    if (users_doc.length != 0 || users_doc != null) {
    List<User> users = new List<User>();
    for (var i in users_doc) {
      users.add(User.fromDoc(i));
    }
    setState(() {
      result_users = users;
    });
    }
    }
    catch (e) {
      print(e);
    }
    }
  }

  void clean_search() {
    search_text_contrl.clear();
  }

  @override
  Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.yellow[500],
            leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black), onPressed: (){Navigator.of(context).pop();}),
            title: TextFormField(
              controller: search_text_contrl,
              decoration: InputDecoration(
                hintText: 'search ...',
                hintStyle: TextStyle(color: Colors.black),
              ),
              onChanged: (changed) {
                show_result(changed);
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.highlight_off, color: Colors.black),
                onPressed: () {clean_search();},
              )
            ],
          ),
          body: Container(
            color: Colors.black87,
            child: result_users == null ?
            Center(child: Text('PetHub', style: TextStyle(color: Colors.yellow, fontSize: 80),)) :
            ListView.builder(
              itemCount: result_users.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(1, 5, 5, 5),
                  child: ListTile(
                    leading: Icon(Icons.person_pin),
                    title: Text(result_users[i].nickname, style: TextStyle(color: Colors.yellow[600], fontSize: 17), textAlign: TextAlign.center),
                    onTap: () async {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SomeoneProfilePage(result_users[i])));
                    },
                  )
                );
              }
            )
          ),
        )
      );
  }

}