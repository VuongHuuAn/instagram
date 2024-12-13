import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List<dynamic> followers;
  final List<dynamic> following;

  const User({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'bio': bio,
        'followers': [],
        'following': [],
        'photoUrl': photoUrl,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      username: snapshot['username'] ?? '', // sửa: thêm kiểm tra null
      uid: snapshot['uid'] ?? '', // sửa: thêm kiểm tra null
      email: snapshot['email'] ?? '', // sửa: thêm kiểm tra null
      photoUrl: snapshot['photoUrl'] ?? '', // sửa: thêm kiểm tra null
      bio: snapshot['bio'] ?? '', // sửa: thêm kiểm tra null
      followers: snapshot['followers'] ?? [], // sửa: thêm kiểm tra null
      following: snapshot['following'] ??
          [], // sửa: thêm kiểm tra null và sửa typo followings thành following
    );
  }
}
