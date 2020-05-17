import 'package:flutter/material.dart';
import 'package:flip_box_bar/flip_box_bar.dart';
import 'package:animated_text_kit/animated_text_kit.dart' show ColorizeAnimatedTextKit;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tvarinki/models/pet.dart';
import 'package:tvarinki/models/user.dart';
import './PagePage.dart';
import './RandAnimal.dart';
import './ChatPage.dart';
import './PagePage.dart';
import './ProfilePage.dart';
import './PostPage.dart';
import './CreateAccPage.dart';

GoogleSignIn signInGoogle = GoogleSignIn();
var firestore = Firestore.instance;
var usersRef = firestore.collection('users');
User _user;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _is_sign_in = false;
  int _selected_index = 0;
  PageController pages_control;
  List<String> titles = ['PetHub', 'Create new Petpost', 'Petchat', 'My Petfile', 'PetHub'];
  void initState() {
    super.initState();
    pages_control = new PageController();

    try {
    signInGoogle.onCurrentUserChanged.listen((account) {_check_google_signin(account);});
    } 
    catch(e) {}

    try{
      signInGoogle.signInSilently(suppressErrors: false).then((account) {_check_google_signin(account);});
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
  }

  void _check_google_signin(GoogleSignInAccount account) {
    if ( account != null) {
      _user_from_firestore();
      setState(() { _is_sign_in = true;});
    }
    else setState(() { _is_sign_in = false;});
  }
 
  Widget signinpage() {
    Size size = MediaQuery.of(context).size;
    return
    Container (
      height: size.height,
      decoration:  BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0x9900cf0f), Color(0xfa00ff11), Color(0xfa47ff54), Color(0xfa00ff11), Color(0x9900cf0f)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          ),
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment:  Alignment(0,-0.75),
            child: Icon(Icons.pets, color: Colors.green[900], size: size.width * 0.07)
          ),
          Align(
            alignment:  Alignment(0.5,-0.55),
            child: Icon(Icons.pets, color: Colors.green[900], size: size.width * 0.07)
          ),
          Align(
            alignment:  Alignment(-0.5,-0.55),
            child: Icon(Icons.pets, color: Colors.green[900], size: size.width * 0.07)
          ),
          Align(
            alignment:  Alignment(0.75,-0.75),
            child: Icon(Icons.pets, color: Colors.green[900], size: size.width * 0.07)
          ),
          Align(
            alignment:  Alignment(-0.75,-0.75),
            child: Icon(Icons.pets, color: Colors.green[900], size: size.width * 0.07)
          ),
          Align(
            alignment:  Alignment(0,0.75),
            child: Icon(Icons.pets, color: Colors.green[900], size: size.width * 0.07)
          ),
          Align(
            alignment:  Alignment(0.5,0.55),
            child: Icon(Icons.pets, color: Colors.green[900], size: size.width * 0.07)
          ),
          Align(
            alignment:  Alignment(-0.5,0.55),
            child: Icon(Icons.pets, color: Colors.green[900], size: size.width * 0.07)
          ),
          Align(
            alignment:  Alignment(0.75,0.75),
            child: Icon(Icons.pets, color: Colors.green[900], size: size.width * 0.07)
          ),
          Align(
            alignment:  Alignment(-0.75,0.75),
            child: Icon(Icons.pets, color: Colors.green[900], size: size.width * 0.07)
          ),
          Align(
          alignment:  Alignment(0,-0.25),
          child: ColorizeAnimatedTextKit(
            totalRepeatCount: 1,
            speed: Duration(milliseconds: 1000),
            text: ['PetHub'], 
            textStyle: TextStyle(fontSize: 80, fontFamily: 'Cinzel', fontWeight: FontWeight.w300),
            colors: [Colors.indigo[900], Colors.blue[700], Colors.cyan, Colors.lightGreenAccent[700], Colors.green, Colors.green[800], Colors.lightGreenAccent[700]]
            )
          ) ,
          Align (
          alignment: Alignment(0,0.25),
          child: GestureDetector(
                onTap: () {logIn();},
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    height: 40,
                    width: 180,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      image: DecorationImage(image: AssetImage('assets/sign-in-with-google.png'), fit:  BoxFit.fill)
                    ),
                  ),
                ),
              ),
         )
      ],)
    );
  }

  @override 
  Widget build(BuildContext contex) {
    if (!_is_sign_in) return signinpage();
    else return Scaffold(
      appBar: AppBar(title: Text(titles[_selected_index], style: TextStyle(color: Colors.indigo[900]),), leading: Icon(Icons.pets)),
      body: PageView(
        controller: pages_control,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          PagePage(),
          PostPage(),
          ChatPage(),
          ProfilePage(),
          AnimalPage()
        ],
        onPageChanged: (changed) {setState(() {_selected_index = changed;});},
      ),

      bottomNavigationBar: FlipBoxBar(
        navBarHeight: MediaQuery.of(context).size.width / 4,
        animationDuration: Duration(milliseconds: 600),
        selectedIndex: _selected_index,
        items: [
        FlipBarItem(
          icon: Icon(Icons.home), 
          text: FittedBox(child: Text('Kennel'), fit: BoxFit.fitWidth),
          backColor: Colors.cyan,
          frontColor: Colors.lightGreenAccent[700],),
        FlipBarItem(
          icon: Icon(Icons.add_box), 
          text: FittedBox(child: Text('Post Pet'), fit: BoxFit.fitWidth),
          backColor: Colors.cyan,
          frontColor: Colors.green[800],),
        FlipBarItem(
          icon: Icon(Icons.message), 
          text: FittedBox(child: Text('Petchat'), fit: BoxFit.fitWidth),
          backColor: Colors.cyan,
          frontColor: Colors.lightGreenAccent[700],),
        FlipBarItem(
          icon: Icon(Icons.person), 
          text: FittedBox(child: Text('Petfile'), fit: BoxFit.fitWidth),
          backColor: Colors.cyan,
          frontColor: Colors.green[800],),
        FlipBarItem(
          icon: Icon(Icons.pets), 
          text: FittedBox(child: Text('RandPet'), fit: BoxFit.fitWidth),
          backColor: Colors.cyan,
          frontColor: Colors.lightGreenAccent[700],),
      ],
      onIndexChanged: (int new_index) {
        pages_control.animateToPage(new_index, duration: Duration(milliseconds: 600), curve: Curves.elasticIn);
      }, 
      ),
    );


  
  }
}


  
