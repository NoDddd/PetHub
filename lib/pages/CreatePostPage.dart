import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:PetHub/models/pet.dart';
import 'package:PetHub/models/post.dart';
import 'package:PetHub/models/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;
import 'package:image/image.dart' as im;
import 'package:uuid/uuid.dart';

FirebaseStorage firebaseStorage = FirebaseStorage.instance;
Firestore firestore = Firestore.instance;
 

class CreatePostPage extends StatefulWidget {
  User _user;
  List<Pet> _pets;
  File _photo;
  CreatePostPage(User user, pets, photo) {
    _user = user;
    _pets = pets;
    _photo = File(photo.path); 
  }
  @override
  _CreatePostPage createState() => _CreatePostPage();
}

class _CreatePostPage extends State<CreatePostPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _postId = Uuid().v4();
  String _title;
  String _url;
  String _hashtag;
  String _blog;
  Post _post;
  bool working = false;
  void creating_post() async {
    if (_title.isEmpty || _title == null)
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('error input for title', style: TextStyle(color: Colors.redAccent[700]))));
    else if (_hashtag.isEmpty || _hashtag == null)
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('error input for hashtag', style: TextStyle(color: Colors.redAccent[700]))));
    else {
      var tmpDirection = await getTemporaryDirectory(); 
      String path = tmpDirection.path;
      im.Image image = im.decodeImage(widget._photo.readAsBytesSync());
      File compressed = await File('$path/img_$_postId.jpg').writeAsBytes(im.encodeJpg(image, quality: 60));
      await get_url(compressed);
      add_post();
    }
  }
  void add_post() async {
    if (_url != null) {
      String id = widget._user.id;
      var petpostRef = firestore.collection('/users/$id/pets/$_hashtag/posts');
      petpostRef.document(_postId).setData({
        'postId': _postId,
        'hashtag': _hashtag,
        'user': widget._user.nickname,
        'userId': id,
        'title': _title,
        'blog': _blog,
        'likes': 0,
        'url': _url,
        'time': DateTime.now().toString()
      });
      var posts = firestore.collection('posts');
      posts.document(_postId).setData({
        'postId': _postId,
        'hashtag': _hashtag,
        'user': widget._user.nickname,
        'userId': id,
        'title': _title,
        'blog': _blog,
        'likes': 0,
        'url': _url,
        'time': DateTime.now().toString()
      });
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Success', style: TextStyle(color: Colors.yellow)),
        duration: Duration(seconds: 2)
        ));
      Navigator.of(context).pop();
    }
    else {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Oops, something went wrong', style: TextStyle(color: Colors.red)),
      duration: Duration(seconds: 2)
      ));
    Navigator.of(context).pop();
    }
  }

  Future<void> get_url(File image) async {
    StorageReference storageRef = firebaseStorage.ref().child('pets pics');
    var task = storageRef.child('post_$_postId.jpg').putFile(image);
    var task_snapshot = await task.onComplete;
    var url = await task_snapshot.ref.getDownloadURL();
    _url = url.toString();
  }

Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text('Create new post', style: TextStyle(color: Colors.black)),
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black), onPressed: () {Navigator.of(context).pop(null);}),
        ),
      body: working == true ?
      Container(color: Colors.black87,
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow)
      )
      ) :
      Container(
      color: Colors.black87,
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(widget._user.nickname, style: TextStyle(color: Colors.yellow, fontSize: 20),),
            ),
            Divider(color: Colors.yellow,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                style: TextStyle(color: Colors.yellow),
                decoration: InputDecoration(
                  fillColor: Colors.yellow.withOpacity(0.1),
                  filled: true,
                  labelText: 'title',
                  labelStyle: TextStyle(color: Colors.yellow.withOpacity(0.5)),
                  hintText: 'title of the post',
                  hintStyle: TextStyle(color: Colors.yellow.withOpacity(0.5)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow, width: 1, style: BorderStyle.solid),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow, width: 1, style: BorderStyle.solid),
                  ),
                ),
                onChanged: (changed) {
                  setState(() {
                    _title = changed;
                  });
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownButton(
              dropdownColor: Colors.black,
              value: _hashtag,
              hint: Text('choose pet by hashtag', style: TextStyle(color: Colors.yellow.withOpacity(0.5))),
              items: [
                for (Pet i in widget._pets)
                DropdownMenuItem(
                  child: Text(i.alias, style: TextStyle(color: Colors.yellow)),
                  value: i.hashtag
                )
              ],
              onChanged: (changed) {
                setState(() {_hashtag = changed.toString();});
              },
              ),
            ),
          Image.file(widget._photo, alignment: Alignment.center, fit: BoxFit.fitWidth),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              style: TextStyle(color: Colors.yellow),
              decoration: InputDecoration(
                fillColor: Colors.yellow.withOpacity(0.1),
                filled: true,
                labelText: 'blog',
                labelStyle: TextStyle(color: Colors.yellow.withOpacity(0.5)),
                hintText: 'add blog or description',
                hintStyle: TextStyle(color: Colors.yellow.withOpacity(0.5)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow, width: 1, style: BorderStyle.solid),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow, width: 1, style: BorderStyle.solid),
                  ),
              ),
              onChanged: (changed) {
                  setState(() {
                    _blog = changed;
                  });
              }
            ),
          ),
          Container(
            height: 100,
            alignment: Alignment.center,
            child: RaisedButton(
              child: Text('Confirm'),
              textColor: Colors.black,
              color: Colors.yellow,
              onPressed: () {
                creating_post();
              }
              )
          )
        ],
      )
    ),
    )
  );
}

}