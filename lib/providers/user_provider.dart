// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:instagram_flutter/authentication/auth_methods.dart';
// import 'package:instagram_flutter/models/user.dart';

// class UserProvider with ChangeNotifier {
//   late User _user;
//   final AuthMethods authMethods = AuthMethods();

//   User get getUser => _user;

//   Future<void> refreshUser() async {
//     User user = await authMethods.getUserDetails();
//     _user = user;
//     notifyListeners();
//   }

//   // Add an initialization method or constructor to ensure _user is initialized.
//   Future<void> initializeUser() async {
//     _user = await authMethods.getUserDetails();
//     notifyListeners();
//   }

//   Future getUser() async {
//     if (FirebaseAuth.instance.currentUser != null) {
//       DocumentSnapshot snap = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .get();

//       String userName = (snap.data() as Map<String, dynamic>)['username'];
//       return userName;
//     }
//   }
// }
