import 'package:cloud_firestore/cloud_firestore.dart';
class User {
  String id;
  String nickname;
  String profile;
  String email;

  User({
    this.id,
    this.nickname,
    this.profile,
    this.email,
  });

  factory User.fromDoc(DocumentSnapshot doc) {
    return User(
      id: doc.documentID,
      nickname: doc['nickname'],
      profile: doc['profile'],
      email: doc['email'],
    );
  }
}