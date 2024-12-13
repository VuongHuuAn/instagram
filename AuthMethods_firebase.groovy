import 'dart:typed_data'; // Import thư viện hỗ trợ làm việc với dữ liệu nhị phân

import 'package:cloud_firestore/cloud_firestore.dart'; // Import thư viện Firebase Firestore
import 'package:firebase_auth/firebase_auth.dart'; // Import thư viện Firebase Authentication
import 'package:flutter/material.dart'; // Import thư viện Flutter

class AuthMethods {
  // Khởi tạo các instance của FirebaseAuth và FirebaseFirestore
  final FirebaseAuth _auth = FirebaseAuth.instance; // Khởi tạo một instance của FirebaseAuth để quản lý xác thực người dùng.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Khởi tạo một instance của FirebaseFirestore để lưu trữ và truy xuất dữ liệu người dùng. 

  // Phương thức đăng ký người dùng mới
  Future<String> signUpUser({
    required String email, // Email của người dùng
    required String password, // Mật khẩu của người dùng
    required String username, // Tên người dùng
    required String bio, // Thông tin tiểu sử của người dùng
    // required Uint8List file, // Dữ liệu hình ảnh của người dùng (bình luận)
  }) async {
    String res = 'Some error occurred'; // Biến lưu kết quả trả về
    try {
      // Kiểm tra nếu các trường không rỗng
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty) {
        // Đăng ký người dùng mới với email và mật khẩu
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        print(cred.user!.uid); // In ra UID của người dùng mới

        // Lưu thông tin người dùng mới vào Firestore
        await _firestore.collection('user').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [], // Danh sách người theo dõi ban đầu
          'following': [], // Danh sách người đang theo dõi ban đầu
        });

        res = "success"; // Cập nhật kết quả trả về thành công
      }
    } catch (err) {
      res = err.toString(); // Cập nhật kết quả trả về nếu có lỗi
    }
    return res; // Trả về kết quả
  }
}
