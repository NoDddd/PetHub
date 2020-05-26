import 'package:flutter/material.dart';
import 'dart:math' show Random;

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
Random random = new Random();

  @override 
  Widget build(BuildContext contex) {
    return Column(
        children: [
        Expanded(child: Center(child: Icon(Icons.add_box, size: 110.0)), flex: 1),
        Expanded(child: Wrap(
          spacing: 5.0,
          children: [
            for(var i = 0; i < 7; i++)
            Icon(Icons.image, color: Colors.brown, size: 100,)
          ]
        ), flex: 2)
      ]);
  }
}
// mama