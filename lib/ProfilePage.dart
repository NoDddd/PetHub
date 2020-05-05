import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';



class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool visible = true;
  @override 
  Widget build(BuildContext contex) {
    return BackdropScaffold(
    iconPosition: BackdropIconPosition.action,
    title: Text('My Petfile'),
    frontLayer: Column(children: <Widget>[
            Container(height: 5,),
            Expanded(child: Card(
              color: Colors.lightGreen[100],
              child: Row(
                children: [
                  Expanded(child: FittedBox(fit: BoxFit.fitWidth, child: Icon(Icons.pets)), flex: 1),
                  Expanded(child: Column(children: [
                    Expanded(child: Text('DOG', textScaleFactor: 1.2,), flex: 1),
                    Expanded(child:Text('*******************************', textScaleFactor: 0.8,), flex: 1),
                  ]), flex: 2)
                  ])), flex: 2),
            Container(height: 7,),
            Expanded(child: Card(
              color: Colors.lightGreen[100],
              child: Row(
                children: [
                  Expanded(child: FittedBox(fit: BoxFit.fitWidth, child: Icon(Icons.pets)), flex: 1),
                  Expanded(child: Column(children: [
                    Expanded(child: Text('CAT', textScaleFactor: 1.2,), flex: 1),
                    Expanded(child:Text('**************************', textScaleFactor: 0.8,), flex: 1),
                  ]), flex: 2)
                  ])), flex: 2),
          ],),
        
    backLayer: Column( children: [
      Flexible(child: Align(child: Icon(Icons.nature_people, size: 85, color: Colors.white), alignment: Alignment.center,),fit: FlexFit.tight, flex: 2),
      Flexible(child: Center(child: Text('**************\n\n**************\n\n***************', style: TextStyle(fontSize: 25, color: Colors.white),)), flex: 3)
    ]),
    
    );
  } 
}