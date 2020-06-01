import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String postId;
  String hashtag;
  String user;
  String userId;
  String title;
  String blog;
  String url;
  String time;

  Post({
    this.postId,
    this.hashtag,
    this.user,
    this.userId,
    this.title,
    this.blog,
    this.url,
    this.time
  });

  factory Post.fromDoc(DocumentSnapshot doc) {
    return Post(
      postId: doc['postId'],
      hashtag: doc['hashtag'],
      user: doc['user'],
      userId: doc['userId'],
      title: doc['title'],
      blog: doc['blog'],
      url: doc['url'],
      time: doc['time']
    );
  }
  
}