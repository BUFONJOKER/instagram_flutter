import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String password;
  final String userName;
  final String bio;
  final String imageFile;
  final List following;
  final List followers;

  User({
    required this.email,
    required this.uid,
    required this.password,
    required this.userName,
    required this.bio,
    required this.imageFile,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": userName,
        "email": email,
        "bio": bio,
        "imageUrl":
            imageFile, // Change property name to match your data structure
        "following": following,
        "followers": followers,
      };

  // static User fromSnap(DocumentSnapshot snap) {
  //   var snapshot = snap.data() as Map<String, dynamic>;
  //   return User(
  //     email: snapshot['email'],
  //     uid: snapshot['uid'],
  //     password: snapshot['password'],
  //     userName: snapshot['username'],
  //     bio: snapshot['bio'],
  //     imageFile: snapshot['imageFile'],
  //     followers: snapshot['followers'],
  //     following: snapshot['following'],
  //   );
  // }
}
