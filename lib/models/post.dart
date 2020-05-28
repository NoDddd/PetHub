import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String postId;
  String user;
  String userId;
  String title;
  String blog;
  String url;

  Post({
    this.postId,
    this.user,
    this.userId,
    this.title,
    this.blog,
    this.url,
  });

  
}