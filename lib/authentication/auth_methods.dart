import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

import 'package:instagram_flutter/storage/storage_method.dart';
import 'package:instagram_flutter/models/user.dart' as models;

class AuthMethods {
  final FirebaseAuth authentication = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Future<models.User> getUserDetails() async {
  //   User currentUser = authentication.currentUser!;

  //   DocumentSnapshot snap =
  //       await firestore.collection("users").doc(currentUser.uid).get();
  //   return models.User.fromSnap(snap);
  // }

  // sign up a user

  Future<String> signUpUser({
    required String email,
    required String password,
    required String userName,
    required String bio,
    required Uint8List imageFile,
    required List followers,
    required List following,
  }) async {
    String response = "Error Occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          userName.isNotEmpty ||
          bio.isNotEmpty) {
        //register user
        UserCredential credential = await authentication
            .createUserWithEmailAndPassword(email: email, password: password);
        log(credential.toString());

        // add image to firebase storage
        String imageUrl = await StorageMethod()
            .uploadImageToStorage("profileImages", imageFile, false);

        // add user to database

        models.User user = models.User(
            email: email,
            uid: credential.user!.uid,
            password: password,
            userName: userName,
            bio: bio,
            imageFile: imageUrl,
            followers: [],
            following: []);

        await firestore.collection("users").doc(credential.user!.uid).set(
              user.toJson(),
            );
        response = "success";
      }
    } catch (error) {
      response = error.toString();
    }

    return response;
  }

  // log in a user

  Future<String> logInUser(
      {required String email, required String password}) async {
    String response = "Error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await authentication.signInWithEmailAndPassword(
            email: email, password: password);
        response = "success";
      } else {
        response = "Please enter all the field";
      }
    } catch (error) {
      response = error.toString();
    }

    return response;
  }
}
