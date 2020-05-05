import 'package:flutter/material.dart';
import 'package:flip_box_bar/flip_box_bar.dart';


import './PagePage.dart';
import './ChatPage.dart';
import './PostPage.dart';
import './ProfilePage.dart';
import './variable.dart' as v;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selected_index = 0;
  List<String> titles = ['Tvarinki', 'Create new Petpost', 'Petchat', 'My Petfile'];


  @override 
  Widget build(BuildContext contex) {
    return Scaffold(
      appBar: AppBar(title: Text(titles[_selected_index], style: TextStyle(color: Colors.indigo[900]),), leading: Icon(Icons.pets)),
      body: v.pages[_selected_index],
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
      ],
      onIndexChanged: (int new_index) {
        setState(() {
          _selected_index = new_index;
        });
      }, 
      ),
    );
  }
}