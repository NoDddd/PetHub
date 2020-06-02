import 'package:flutter/material.dart';
import 'dart:math' show pi;

class CreateAccPage extends StatefulWidget {
  @override
  _StateCreateAccPage createState() => _StateCreateAccPage();
  }
  
  class _StateCreateAccPage extends State<CreateAccPage> {
    GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    String username;
    SnackBar error_bar = SnackBar(content: Text('Error input for username', style: TextStyle(color: Colors.red[700])), duration: Duration(seconds: 3),);
    

    void createacc() {
      if (username.isEmpty || username.length < 6 || username == null) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          duration: Duration(seconds: 3,),
          content: Text('Enter correct username', style: TextStyle(color: Colors.redAccent[700])),
          backgroundColor: Colors.yellow,
          ));
      }
      else Navigator.of(context).pop(username);
    }

  Widget build (BuildContext context) {
    return SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(leading: FittedBox(child: Icon(Icons.pets, color: Colors.black), fit: BoxFit.fitWidth), title: Text('Account Settings', style: TextStyle(color: Colors.black)), backgroundColor: Colors.yellow,),
            body: Container(
              width: double.infinity,
              color: Colors.black87,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment(0.6, 1),
                    child: Transform.rotate(angle: pi/4,
                    child: Icon(Icons.pets, size: 300, color: Color(0xff828200),)
                    )
                  ),
                  Align(
                  alignment: Alignment(0, -.2),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      style: TextStyle(color: Colors.yellow),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow, width: 1, style: BorderStyle.solid),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow, width: 1, style: BorderStyle.solid),
                        ),
                        hintText: 'username',
                        helperText: 'must contain at least 6 symbols',
                        helperMaxLines: 2,
                        hintStyle: TextStyle(color: Colors.yellow[200]),
                        helperStyle: TextStyle(color: Colors.yellow[200])
                      ),
                      maxLength: 20,
                      onChanged: (str) { setState(() {username = str;});},
                    ),
                  )
              ) 
              ]),
          ),
          floatingActionButton: IconButton(
            icon: Icon(Icons.done, color: Colors.yellowAccent), 
            splashColor: Colors.yellow,
            onPressed: () {createacc();}),
      ),
    );
  }
}