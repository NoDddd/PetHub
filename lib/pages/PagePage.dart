import 'package:flutter/material.dart';
import 'dart:math' show Random;
import 'package:flip_box_bar/flip_box_bar.dart';

class PagePage extends StatefulWidget {
  @override
  _PagePageState createState() => _PagePageState();
}

class _PagePageState extends State<PagePage> {
Random random = new Random();
String _text = 'content of post';
List<Widget> icon = [Icon(Icons.favorite_border), Icon(Icons.favorite, color: Colors.redAccent[700])];
int iconindex = 0;
  @override 
  Widget build(BuildContext contex) {
    return Container(
      child: ListWheelScrollView(
        //padding: EdgeInsets.only(bottom: 10),
        itemExtent: 0.67 * MediaQuery.of(context).size.height,
        diameterRatio: 9,
        renderChildrenOutsideViewport: false,
        offAxisFraction: -0.5,
        children: [
          for( var i = 0; i < 13; i++)
          Container(
            decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.greenAccent[700], Colors.green[50], Colors.white],
            begin: Alignment.topCenter, end: Alignment.bottomCenter)          ),
            width: MediaQuery.of(context).size.width - 20,
            child: Column(children: <Widget>[
              Expanded(child: Row(children: [
                Expanded(child: Align(child: Icon(Icons.person_outline, color: Colors.white, size: 60), alignment: Alignment.centerLeft,widthFactor: 0.8,), flex: 1),
                Expanded(child: Align(child: Icon(Icons.pets, color: Colors.white, size: 30), alignment: Alignment.centerRight,widthFactor: 0.8,), flex: 1)
                ]), flex: 1),
              Expanded(child: Align(child: Text('TITLE', textScaleFactor: 2,), alignment: Alignment.centerLeft, ), flex: 1),
              Expanded(child: Align(child: Text('Subtitle and description\n and some text', textScaleFactor: 1,), alignment: Alignment.centerLeft),flex: 1),
              Expanded(child: FractionallySizedBox(child:
                Container(color: Color.fromARGB(255, random.nextInt(255), random.nextInt(255), random.nextInt(255)),
                  child: FittedBox(child: Icon(Icons.pets), fit: BoxFit.contain)), widthFactor: 0.9, heightFactor: 0.97,), flex: 4),
              Expanded(child: Align(child: Icon(Icons.favorite, color: Colors.redAccent[700], size: 30,),
              alignment: Alignment.centerRight,), flex: 1)
            ],)
            ),
          Expanded(child: Column(children: <Widget>[
            Expanded(child: Align(
              child: IconButton(
                highlightColor: Colors.green,
                hoverColor: Colors.blue,
                color: Colors.green,
                icon: Icon(Icons.add, color: Colors.green),
              ),
                alignment: Alignment.center,widthFactor: 0.8,), flex: 1),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                "View More Posts",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],)
          )
        ])
        );
  }
}