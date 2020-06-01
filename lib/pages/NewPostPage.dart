import 'dart:io';
import 'package:PetHub/models/pet.dart';
import 'package:PetHub/models/post.dart';
import 'package:PetHub/models/user.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import 'CreatePostPage.dart';

class NewPostPage extends StatefulWidget {
  User _user;
  List<Pet> _pets;

  NewPostPage(User user, pets) {
    _user = user;
    _pets = pets;
  }
  @override
  _NewPostPageState createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  Post _post;
  var picker = new ImagePicker();

  void camera_pic() async {
    PickedFile image_file = await picker.getImage(source: ImageSource.camera, imageQuality: 60);
    Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePostPage(widget._user, widget._pets, image_file)));
  }

  void gallery_pic() async {
    PickedFile image_file = await picker.getImage(source: ImageSource.gallery, imageQuality: 60);
    Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePostPage(widget._user, widget._pets, image_file)));
  }

  @override 
  Widget build(BuildContext contex) {
    return Column(
        children: [
        Flexible(
          flex: 5,
          child: Row(
            children: [
              Flexible(
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.add_photo_alternate, color: Colors.yellow),
                    iconSize: MediaQuery.of(context).size.width * 0.37,
                    onPressed: () {gallery_pic();},
                  )
                ),
                flex: 1,
              ),
              Flexible(
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.add_a_photo, color: Colors.yellow),
                    iconSize: MediaQuery.of(context).size.width * 0.35,
                    onPressed: () {camera_pic();},
                  )
                ),
                flex: 1,
              ),
            ]
          )
        ),
        Flexible(
          flex: 2, 
          child: Container(
            padding: EdgeInsets.all(6),
            child: Text('Choose image from gallery or take picture now', style: TextStyle(color: Colors.yellow, fontSize: 10)),
            color: Colors.black
          )
        ),
      ]);
  }
}