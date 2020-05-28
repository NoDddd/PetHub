import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './pages/MainPage.dart';
// функція запуску програми
void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);
  runApp(MyApp());
  }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black87,
        appBarTheme: AppBarTheme(
          color: Colors.yellow
        ),
        scaffoldBackgroundColor: _black[70],
        fontFamily: 'Cinzel',
        iconTheme: IconThemeData(color: _black),
      ),
      home: MainPage(),
    );
  }
}
// hello

MaterialColor _black = new MaterialColor(
  0xFF000000,
  {
    70: Color(0xC0000000)
  }
);