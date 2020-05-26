import 'package:cloud_firestore/cloud_firestore.dart';
class Pet {
  String alias;
  String type;
  String subtype;
  String hashtag;
  String bio;

  Pet ({
    this.alias,
    this.type,
    this.subtype,
    this.hashtag,
    this.bio,
  });

  factory Pet.fromDoc(DocumentSnapshot doc) {
    return Pet(
    alias: doc['alias'],
    type: doc['type'],
    subtype: doc['subtype'],
    hashtag: doc['hashtag'],
    bio: doc['bio']
    );
  }
}