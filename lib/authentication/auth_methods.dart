import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_flutter/storage/storage_method.dart';

class AuthMethods {
  final FirebaseAuth authentication = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // sign up a user

  Future<String> signUpUser({
    required String email,
    required String password,
    required String userName,
    required String bio,
    required Uint8List imageFile,
    
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
        String imageUrl = await  StorageMethod().uploadImageToStorage("profileImages", imageFile, false);


        // add user to database
        Map<String,dynamic> data = {
          "uid":credential.user!.uid,
          "username": userName,
          "email":email,
          "bio":bio,
          "imageUrl":imageUrl,
        };

        await firestore.collection("users").doc(credential.user!.uid).set(data);
        response = "success";
      }
    } 
     catch (error) {
      response = error.toString();
    }

    return response;
  }


  // log in a user

  Future<String> logInUser({
    required String email,
    required String password
  }) async {

    String response = "Error occured";
    try {
      if(email.isNotEmpty || password.isNotEmpty){
        await authentication.signInWithEmailAndPassword(email: email, password: password);
        response = "success";
      }
      else{
        response = "Please enter all the field";
      }
    } catch (error) {
      response = error.toString();
    }

    return response;
  }
}