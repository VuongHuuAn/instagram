import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profImage;
  final likes;

  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        'description': description,
        'uid': uid,
        'username': username,
        'postId': postId,
        'datePublished': datePublished,
        'postUrl': postUrl,
        'profImage': profImage,
        'likes': likes,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      username: snapshot['username'] ?? '', // sửa: thêm kiểm tra null
      uid: snapshot['uid'] ?? '', // sửa: thêm kiểm tra null
      description: snapshot['description'] ?? '', // sửa: thêm kiểm tra null
      postId: snapshot['postId'] ?? '', // sửa: thêm kiểm tra null
      datePublished: snapshot['datePublished'] ?? '', // sửa: thêm kiểm tra null
      profImage: snapshot['profImage'] ?? [], // sửa: thêm kiểm tra null
      postUrl: snapshot['postUrl'],
      likes: snapshot['likes'],
      // sửa: thêm kiểm tra null và sửa typo followings thành following
    );
  }
}
