// import 'package:flutter/material.dart';
// import 'package:instagram_flutter/authentication/auth_methods.dart';
// import 'package:instagram_flutter/models/user.dart';

// class UserProvider with ChangeNotifier {
//   User? _user;
//   final AuthMethods authMethods = AuthMethods();
//   User get getUser => _user!;

//   Future<void> refreshUser() async {
//     User user = await authMethods.getUserDetails();
//     _user = user;
//     notifyListeners();
//   }
// }
