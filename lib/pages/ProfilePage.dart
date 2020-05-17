import 'package:flutter/material.dart';




class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool visible = true;
  @override 
  Widget build(BuildContext contex) {
    return Container(
      child: IconButton(icon: Icon(Icons.cancel), iconSize: 50, onPressed: () {},)
    );
  } 
}