import 'package:PetHub/models/user.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

Firestore firestore = Firestore.instance;

class IndividualPage extends StatefulWidget {
  User _current;
  User _other;
  IndividualPage(User current, User other) {
    _current = current;
    _other = other;
  }
  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  String chatId;
  TextEditingController message = new TextEditingController();
  FocusNode msg_focus = new FocusNode();
  String send_msg;
  @override
  void initState() {
    get_chat_id();
    super.initState();
  }

  void get_chat_id() {
    String currentId = widget._current.id;
    String otherId = widget._other.id;
    if( currentId.hashCode> otherId.hashCode) 
    setState((){
      chatId = currentId + '-' + otherId;
    });
    else setState((){
      chatId = '$otherId-$currentId';
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:  AppBar(
          backgroundColor: Colors.yellow,
          leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black), onPressed: () {Navigator.of(context).pop();}),
          title: Text(widget._other.nickname, style: TextStyle(color: Colors.black, fontSize: 15))
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 10,
              child: Container(
                child: StreamBuilder(
                  stream: firestore.collection('chats').document(chatId).collection(chatId).orderBy('time', descending: true).limit(15).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),));
                    else {
                      return ListView.builder(
                        reverse: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, i) {
                          if (snapshot.data.documents[i]['fromId'] ==  widget._current.id) {
                            return 
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 3, 10, 3),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                    child: Container(
                                    color: Color(0xFFFFF36D),
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 15),
                                    child: Text(snapshot.data.documents[i]['message'], style: TextStyle(color: Colors.black), textAlign: TextAlign.start)   
                                    ),
                                ),
                              )
                              );
                             }
                            else 
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 3, 0, 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                    child: Container(
                                    color: Colors.grey[800],
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 15),
                                    child: 
                                    Text(snapshot.data.documents[i]['message'], style: TextStyle(color: Colors.white), textAlign: TextAlign.start),                                    
                                  ),
                                ),
                              ),
                            );
                        },
                      );
                    }
                  }
                ),
              ),
            ),
            Expanded(
              flex: 1,
          child: Container(
          //height: 70,
          color: Color(0xff2b2b00),
          child: Row(
              children: <Widget>[
                Expanded(
                  flex: 10,
                   child: Container(
                     child: TextFormField(
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.text,
                      controller: message,
                      style: TextStyle(color: Colors.yellow[300]),
                      focusNode: msg_focus,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow)
                        ),
                        fillColor: Color(0xff2b2b00),
                        filled: true, 
                        labelText: 'message...',
                        labelStyle: TextStyle(color: Colors.yellow[100]),
                      ),
                      onChanged: (value) {
                        setState(() {send_msg = value;});
                      },
                  ),
                   ),
                ),
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                      child: Container(
                        child: IconButton(
                        icon: Icon(Icons.send ,color: Colors.yellow),
                        onPressed: () async {
                          if(message.text != '') {
                          var docRef = firestore.collection('chats')
                          .document(chatId)
                          .collection(chatId)
                          .document(Uuid().v1());
                          firestore.runTransaction((transaction) async {
                            await transaction.set(docRef,
                            {
                            'fromId': widget._current.id,
                            'toId': widget._other.id,
                            'message': send_msg,
                            'time': DateTime.now().toString()
                          });
                          });
                          message.clear();
                          }                            
                          msg_focus.unfocus(); 
                        },
                      ),
                    ),
                  )
                )
              ],
          ),
        ),
            ),
          ],
        ),   
      )
    );
  }
}