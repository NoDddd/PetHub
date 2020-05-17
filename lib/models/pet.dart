import 'package:cloud_firestore/cloud_firestore.dart';
class Pet {
  String id;
  String alias;
  String type;
  String subtype;
  String hashtag;
  String bio;

  Pet ({
    this.id,
    this.alias,
    this.type,
    this.subtype,
    this.hashtag,
    this.bio,
  });

  factory Pet.fromDoc(DocumentSnapshot doc) {
    return Pet(
    id: doc['id'],
    alias: doc['alias'],
    type: doc['type'],
    subtype: doc['subtype'],
    hashtag: doc['hashtag'],
    bio: doc['bio']
    );
  }
}