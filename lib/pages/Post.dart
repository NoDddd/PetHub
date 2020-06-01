
import 'package:PetHub/models/post.dart';
import 'package:PetHub/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'SomeoneProfilePage.dart';

class PostWidget extends StatefulWidget {
  Post _post;
  PostWidget(Post post) {
    _post = post;
  }
  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.yellow, Colors.yellow[300]],
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
                  onTap: () async {
                    var doc = await Firestore.instance.collection('users').document(widget._post.userId).get();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SomeoneProfilePage(User.fromDoc(doc))));
                  },
                )
              ),
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Image.network(widget._post.url)
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
    );
  }
}
