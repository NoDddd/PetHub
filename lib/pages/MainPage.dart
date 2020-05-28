import 'package:flutter/material.dart';
//import 'package:flip_box_bar/flip_box_bar.dart';

import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'package:animated_text_kit/animated_text_kit.dart' show ColorizeAnimatedTextKit;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

import 'package:tvarinki/models/pet.dart';
import 'package:tvarinki/models/user.dart';
import 'package:tvarinki/pages/AddPetPage.dart';
import './PagePage.dart';
import './RandAnimal.dart';
import './ChatPage.dart';
import './ProfilePage.dart';
import './PostPage.dart';
import './CreateAccPage.dart';
import 'SearchPage.dart';

GoogleSignIn signInGoogle = GoogleSignIn();
var firestore = Firestore.instance;
var usersRef = firestore.collection('users');
CollectionReference petsRef;


class MainPage extends StatefulWidget {




  MainPage({Key key, this.title}) : super(key: key);

  final String title;




  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  User _user;
  List<Pet> _pets;
  bool _is_sign_in = false;
  int _selected_index = 0;
  PageController pages_control;
  void initState() {
    super.initState();
    pages_control = new PageController();

    try {
      signInGoogle.onCurrentUserChanged.listen((account) {_check_google_signin(account);setState( (){_selected_index = 0;});});
    }
    catch(e) {}
/*
    try{
      signInGoogle.

      signInSilently(suppressErrors: false).then((account) {_check_google_signin(account);});
    }
    catch(e) {}*/
  }

  void dispose() {
    pages_control.dispose();
    super.dispose();
  }

  void logIn() {
    signInGoogle.signIn();
  }

  void _user_from_firestore() async {

    GoogleSignInAccount user_account = signInGoogle.currentUser;
    DocumentSnapshot doc_snapshot = await usersRef.document(user_account.id).get();

    if (!doc_snapshot.exists) {
      String username = await Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccPage()));
      usersRef.document(user_account.id).setData({
        'id': user_account.id,
        'nickname': username,
        'profile': user_account.displayName,
        'email': user_account.email,
        'creation date': DateTime.now().toString()
      });
      doc_snapshot = await usersRef.document(user_account.id).get();
    }
    _user = User.fromDoc(doc_snapshot);
    petsRef = firestore.collection('/users/' + _user.id + '/pets');
    get_pets();
  }

  void get_pets() async {
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

  void _check_google_signin(GoogleSignInAccount account) {
    if ( account != null) {
      _user_from_firestore();
      setState(() { _is_sign_in = true;});
    }
    else setState(() { _is_sign_in = false;});
  }
  // логін сторінка
  Widget signinpage() {
    Size size = MediaQuery.of(context).size;
    return
    Container (
      height: size.height,
      width: size.width,
      color: Colors.black87,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[  
          Flexible(flex: 1, child: Container()),
          Flexible(
          flex: 3,
          child: ColorizeAnimatedTextKit(
            totalRepeatCount: 1,
            speed: Duration(milliseconds: 1500),
            text: ['PetHub'], 
            textStyle: TextStyle(fontSize: 80, fontFamily: 'Cinzel', fontWeight: FontWeight.w300, fontStyle: FontStyle.normal ),
            colors: [Colors.yellowAccent, Colors.yellow, Colors.yellow[800], Colors.lime[900], Colors.black]
            )
          ),
          
          Flexible(flex: 2, 
          child: FractionallySizedBox(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.yellow[200]),
                borderRadius: BorderRadius.circular(11)
              ),
            ),
            widthFactor: 0.8,
            heightFactor: 0.6,
            )),
            Flexible(flex: 2, 
            child: FractionallySizedBox(
              alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.yellow[200]),
                borderRadius: BorderRadius.circular(11)
              ),
            ),
            widthFactor: 0.8,
            heightFactor: 0.6,
            )),
          Flexible (
          flex: 2,
          child: GestureDetector(
                onTap: () {logIn();},
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    height: 40,
                    width: 180,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/sign-in-with-google.png'), fit:  BoxFit.fill)
                    ),
                  ),
                ),
              )),
            Flexible(flex: 1, child: Container())
            ],)
      );
  }



  // основна частина програми
  @override
  Widget build(BuildContext context) {
    if (!_is_sign_in) return signinpage();
    else return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('PetHub', style: TextStyle(color: Colors.black),), 
          leading: Icon(Icons.pets, color: Colors.black),
          actions: <Widget>[IconButton(icon: Icon(Icons.search, color: Colors.black), onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(usersRef)));},)],
        ),
        body: PageView(
          controller: pages_control,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            PagePage(),
            PostPage(),
            ChatPage(),
            ProfilePage(_user, _pets),
            AnimalPage()
          ],
          onPageChanged: (changed) {setState(() {_selected_index = changed;});},
        ),
        bottomNavigationBar:  BottomNavyBar(
          selectedIndex:  _selected_index,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            _selected_index = index;
            pages_control.jumpToPage(index);
          }),
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              activeColor: Colors.yellow,
            ),
            BottomNavyBarItem(
                icon: Icon(Icons.add_a_photo),
                title: Text('Add Post'),
                activeColor: Colors.yellow
            ),
            BottomNavyBarItem(
                icon: Icon(Icons.message),
                title: Text('Chat'),
                activeColor: Colors.yellow
            ),
            BottomNavyBarItem(
                icon: Icon(Icons.person),
                title: Text('Account'),
                activeColor: Colors.yellow
            ),
            BottomNavyBarItem(
                icon: Icon(Icons.fiber_new),
                title: Text('Rand Pic'),
                activeColor: Colors.yellow
            ),
          ],
        ),

        floatingActionButton: _selected_index != 3 ? null :
        IconButton(
            highlightColor: Colors.green,
            hoverColor: Colors.blue,
            color: Colors.green,
            icon: Icon(Icons.add, color: Colors.green),
            onPressed: () async {
              Pet pet = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddPetPage()));
              petsRef.document(pet.hashtag).setData({
                'hashtag': pet.hashtag,
                'alias': pet.alias,
                'type': pet.type,
                'subtype': pet.subtype,
                'bio': pet.bio
              });
              get_pets();
            }
        ),
      )
    );
    }

}
