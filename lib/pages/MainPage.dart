import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:animated_text_kit/animated_text_kit.dart' show ColorizeAnimatedTextKit;

import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

import 'package:PetHub/models/pet.dart';
import 'package:PetHub/models/user.dart';
import 'package:PetHub/pages/AddPetPage.dart';
import './PagePage.dart';
import './RandAnimal.dart';
import './ChatPage.dart';
import './ProfilePage.dart';
import './NewPostPage.dart';
import './CreateAccPage.dart';
import 'SearchPage.dart';

GoogleSignIn signInGoogle = GoogleSignIn();
Firestore firestore = Firestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
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
    GoogleSignInAuthentication googleAuth = await user_account.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final FirebaseUser fireuser = (await auth.signInWithCredential(credential)).user;
    DocumentSnapshot doc_snapshot = await usersRef.document(fireuser.uid).get();

    if (!doc_snapshot.exists) {
      String username = await Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccPage()));
      usersRef.document(fireuser.uid).setData({
        'id': fireuser.uid,
        'nickname': username,
        'profile': fireuser.displayName,
        'email': fireuser.email,
        'creation date': DateTime.now().toString()
      });
      doc_snapshot = await usersRef.document(fireuser.uid).get();
    }
    _user = User.fromDoc(doc_snapshot);
    petsRef = firestore.collection('/users/' + _user.id + '/pets');
    get_pets();
  }

  void get_pets() async {
    var query_snap_pets = await petsRef.orderBy('type').getDocuments();
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
            textStyle: TextStyle(fontSize: 80, fontFamily: 'Martel', fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, decoration: TextDecoration.none ),
            colors: [Colors.yellowAccent, Colors.yellow, Colors.yellow[800], Colors.lime[900], Colors.black]
            )
          ),
          
          Flexible(flex: 2, 
          child: FractionallySizedBox(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment(-.9,0),
              child: Text('email', style: TextStyle(color: Colors.yellow.withOpacity(0.5), fontSize: 14, decoration: TextDecoration.none)),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.yellow[200]),
                borderRadius: BorderRadius.circular(11),
                gradient: LinearGradient(
                  colors: [Colors.black, Color(0xFF5c5600)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight
                  )
              ),
            ),
            widthFactor: 0.8,
            heightFactor: 0.5,
            )),
            Flexible(flex: 2, 
            child: FractionallySizedBox(
            child: Container(
              alignment: Alignment(-.9,0),
              child: Text('password', 
              style: TextStyle(fontSize: 14, color: Colors.yellow.withOpacity(0.5), decoration: TextDecoration.none)),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.yellow[200]),
                borderRadius: BorderRadius.circular(11),
                gradient: LinearGradient(
                  colors: [Colors.black, Color(0xFF5c5600)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight
                  )
              ),
            ),
            widthFactor: 0.8,
            heightFactor: 0.5,
            )),
          Flexible (
          flex: 2,
          child: FractionallySizedBox(
            widthFactor: 0.8,
            heightFactor: 0.5,
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.yellow[200], width: 0.5),
                  borderRadius: BorderRadius.circular(11),
                  gradient: LinearGradient(
                  colors: [Colors.black, Color(0xFF5c5600)],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft
                  )
                ),
              child: GestureDetector(
                    onTap: () {logIn();},
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage('assets/google-yellow.png'), fit:  BoxFit.fitHeight,alignment: Alignment.centerRight)
                              ),
                            ),
                          ),
                        ),
                        Expanded(flex: 7,
                         child: Container(
                           child: Text('Sign in with Google', style: TextStyle(color: Colors.yellow, fontSize: 15, decoration: TextDecoration.none), textAlign: TextAlign.left),                      
                           ))
                      ],
                    ),
                  ),
            ),
          )),
            Flexible(flex: 1, child: Container())
            ],)
      );
  }

  @override
  Widget build(BuildContext context) {
    if (!_is_sign_in) return signinpage();
    else return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('PetHub', style: TextStyle(color: Colors.black),), 
          leading: Icon(Icons.pets, color: Colors.black),
          actions: _selected_index == 3 ?
          <Widget>[PopupMenuButton<int>(
            icon: Icon(Icons.more_horiz, color: Colors.black),
            color: Colors.black,
            itemBuilder: (context) =>
              [
                PopupMenuItem(
                value: 1,
                child: IconButton(icon: Icon(Icons.exit_to_app, color :Colors.yellow),
                onPressed: () {
                  Navigator.of(context).pop();
                  auth.signOut(); signInGoogle.signOut();
                  },)
              )
              ])]  :
          <Widget>[IconButton(icon: Icon(Icons.search, color: Colors.black), onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(usersRef)));},)]
        ),
        body: PageView(
          controller: pages_control,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            PagePage(),
            NewPostPage(_user, _pets),
            ChatPage(_user),
            ProfilePage(_user, _pets),
            AnimalPage()
          ],
          onPageChanged: (changed) {setState(() {_selected_index = changed;});},
        ),
        bottomNavigationBar:  BottomNavyBar(
          selectedIndex:  _selected_index,
          showElevation: true,
          onItemSelected: (index) => setState(() {
            _selected_index = index;
            pages_control.jumpToPage(index);
          }),
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Kennel'),
              activeColor: Colors.yellow,
            ),
            BottomNavyBarItem(
                icon: Icon(Icons.fiber_new),
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
                title: Text('Profile'),
                activeColor: Colors.yellow
            ),
            BottomNavyBarItem(
                icon: Icon(Icons.pets),
                title: Text('Rand Pic'),
                activeColor: Colors.yellow
            ),
          ],
        ),

        floatingActionButton: _selected_index != 3 ? null :
        FloatingActionButton(
            hoverColor: Colors.blue,
            backgroundColor: Colors.yellow,
            child: Icon(Icons.add, color: Colors.black),
            onPressed: () async {
              Pet pet = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddPetPage()));
              petsRef.document(pet.hashtag).setData({
                'hashtag': pet.hashtag,
                'alias': pet.alias,
                'type': pet.type,
                'subtype': pet.subtype,
                'bio': pet.bio,
                'postItem': 0
              });
              get_pets();
            }
        ),
      )
    );
    }

}
