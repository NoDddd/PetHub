import 'package:flutter/material.dart';
import 'dart:math' show pi;

class CreateAccPage extends StatefulWidget {
  @override
  _StateCreateAccPage createState() => _StateCreateAccPage();
  }
  
  class _StateCreateAccPage extends State<CreateAccPage> {
    String username;
    SnackBar error_bar = SnackBar(content: Text('Error input for username', style: TextStyle(color: Colors.red[700])), duration: Duration(seconds: 3),);
    

    void createacc() {
      if (username == '' || username.length < 6 || username.length > 13 || username == null) {
        
      }
      else Navigator.of(context).pop(username);
    }

  Widget build (BuildContext context) {
    return SafeArea(
          child: Scaffold(
            appBar: AppBar(leading: FittedBox(child: Icon(Icons.pets), fit: BoxFit.fitWidth), title: Text('Account Settings', style: TextStyle(color: Colors.indigo[900])), backgroundColor: Colors.green[400],),
            body: Container(
              width: double.infinity,
              color: Colors.green[50],
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment(0.6, 1),
                    child: Transform.rotate(angle: pi/4,
                    child: Icon(Icons.pets, size: 300, color: Color(0x790a7d00),)
                    )
                  ),
                  Align(
                    alignment: Alignment(-0.5, -1),
                    child: Transform.rotate(angle: -pi/3,
                    child: Icon(Icons.pets, size: 300, color: Color(0x790a9d10),)
                    )
                  ),
                  Align(
                  alignment: Alignment(0, -.2),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 0.5),),
                        hintText: 'username',
                        helperText: 'must contain at least 6 symbols, but not more that 13',
                        helperMaxLines: 2,
                      ),
                      onFieldSubmitted: (str) { setState(() {username = str;});},
                    ),
                  )
              ) 
              ]),
          ),
          floatingActionButton: IconButton(
            icon: Icon(Icons.done, color: Colors.brown[600],), 
            splashColor: Colors.white,
            onPressed: () {createacc();}),
      ),
    );
  }
}