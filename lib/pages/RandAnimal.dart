import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math' show Random;
import 'dart:convert';

Random random = new Random();
class AnimalPage extends StatelessWidget {
  
  Future<Image> getgoat() async {
    return Image.network(goat_url);
  }
  Future<Image> getfox() async {
    return Image.network('http:\/\/randomfox.ca\/images\/$rand.jpg');
  }
  Future<Image> getdog() async {
    var res = await http.get(dog_url);
    return Image.network(json.decode(res.body)["message"]);
  }
  Future<Image> getcat() async {
    var cat = random.nextInt(6);
    return Image.network(cat_url);
  }

  int rand = 1 + random.nextInt(119);
  List<String> catsays = ['PetHub', 'hello', 'SA-12', 'meow', 'Meow', 'MEOW'];
  String goat_url = 'http://placegoat.com/350';
  String dog_url = 'https://dog.ceo/api/breeds/image/random';
  String cat_url = 'https://cataas.com/cat';
  @override
  Widget build(BuildContext context) {
          return Container(
            color: Colors.yellow,
            height: double.infinity,
            child: Column( 
            children: [
              Expanded(flex: 1, child: SizedBox(height: 100, child: Center(child: Text('Some random animals for U', style: TextStyle(letterSpacing: 1.1, fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black)),))),
              Expanded(flex: 10, child: Container(color: Colors.black87,
              child: ListView(children: <Widget>[    
                FutureBuilder(
                  future: getcat(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done)
                      return Padding(padding: EdgeInsets.all(10), child:  ClipRRect(borderRadius: BorderRadius.all(Radius.circular(10)), 
                        child: snapshot.data));
                    else if (snapshot.connectionState == ConnectionState.waiting) return Container(child: CircularProgressIndicator(), alignment: Alignment.center, height: 200,);
                }),
                FutureBuilder(
                  future: getdog(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done)
                      return Padding(padding: EdgeInsets.all(10), child:  ClipRRect(borderRadius: BorderRadius.all(Radius.circular(10)), 
                        child: snapshot.data));
                    else if (snapshot.connectionState == ConnectionState.waiting) return Container(child: CircularProgressIndicator(), alignment: Alignment.center, height: 200,);
                }), 
                FutureBuilder(
                  future: getfox(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done)
                      return Padding(padding: EdgeInsets.all(10), child:  ClipRRect(borderRadius: BorderRadius.all(Radius.circular(10)), 
                        child: snapshot.data));
                    else if (snapshot.connectionState == ConnectionState.waiting) return Container(child: CircularProgressIndicator(), alignment: Alignment.center, height: 200,);
            }),
          ])
        )),
      ]) 
    );
  }
}