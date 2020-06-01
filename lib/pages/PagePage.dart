import 'package:PetHub/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Post.dart';

Firestore firestore = Firestore.instance;

class PagePage extends StatefulWidget {
  @override
  _PagePageState createState() => _PagePageState();
}

class _PagePageState extends State<PagePage> {

  @override 
  Widget build(BuildContext contex) {
    
    return Container(
      color: Colors.black,
      child: StreamBuilder(
        stream: firestore.collection('posts').orderBy('time').limit(25).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.hasError)
          return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),));          
          else return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemExtent: MediaQuery.of(context).size.height * .8,
            itemBuilder: (context, i) {
              return PostWidget(Post.fromDoc(snapshot.data.documents[i]));
            },
          );
        },
      )
    );
        
  }
}