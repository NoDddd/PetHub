import 'package:PetHub/models/pet.dart';
import 'package:PetHub/models/post.dart';
import 'package:PetHub/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'SomeoneProfilePage.dart';

class ShowPostPage extends StatefulWidget {
  Post _post;
  ShowPostPage(Post post) {
    _post = post;
  }
  @override
  _ShowPostPageState createState() => _ShowPostPageState();
}

class _ShowPostPageState extends State<ShowPostPage> {
  DocumentSnapshot petDoc;

  initState() {
    get_pet();
    super.initState();
  }

  void get_pet() async {
  petDoc = await Firestore.instance.collection('users').document(widget._post.userId).collection('pets').document(widget._post.hashtag).get();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
            appBar: AppBar(
            backgroundColor: Colors.yellow[500],
            leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black), onPressed: (){Navigator.of(context).pop();}),
            ),
            body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.yellow[700], Colors.yellow, Colors.yellow[300]],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)
                    ),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: ListTile(
                    leading: Icon(Icons.person_pin, color: Colors.black.withOpacity(0.5)),
                    title: Text(widget._post.user, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600)),
                    subtitle: Text(widget._post.hashtag, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300)),
                  )
                ),
                Expanded(
                    flex: 6,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Hero(child: Image.network(widget._post.url), tag: widget._post.postId)
                      )
                    ) 
                    ),
                Expanded(
                  flex: 2,
                  child: widget._post.blog == null ?
                  Text(widget._post.title, style: TextStyle(color: Colors.black, fontSize: 18), textAlign: TextAlign.center,) :
                  Column(
                    children: <Widget>[
                      Text(widget._post.title, style: TextStyle(color: Colors.black, fontSize: 18), textAlign: TextAlign.center,),
                      Text(widget._post.blog, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w200))
                    ],
                  )
                )
              ],
            )),
          ),
    );
  }
}