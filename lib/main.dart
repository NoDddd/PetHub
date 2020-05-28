import 'package:flutter/material.dart';
import './pages/MainPage.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'PetHub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.black12,
          bottomAppBarColor:Colors.black,
        primarySwatch: Colors.yellow,
        fontFamily: 'Cinzel'
      ),
      home: MainPage(),
    );
  }
}




