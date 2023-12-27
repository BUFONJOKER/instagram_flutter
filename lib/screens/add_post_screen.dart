import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/image_picker/image_picker.dart';
// import 'package:instagram_flutter/models/user.dart' as modals;
// import 'package:instagram_flutter/providers/user_provider.dart';
// import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? file;

  _selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('cereate a post'),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("take a phot"),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List imageFile = await selectImage(ImageSource.camera);
                setState(() {
                  file = imageFile;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("choose from gallery"),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List imageFile = await selectImage(ImageSource.gallery);
                setState(() {
                  file = imageFile;
                });
              },
            ),

            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("cancel"),
              onPressed: ()  {
                Navigator.of(context).pop();

              },
            ),
          ],
        );
      },
    );
  }

  String userName = "";
  String imageFile = "";
  String emailFile = "";

  getUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      String user = (snap.data() as Map<String, dynamic>)['username'];
      String image = (snap.data() as Map<String, dynamic>)['imageUrl'];
      String email = (snap.data() as Map<String, dynamic>)['email'];

      setState(() {
        userName = user;
        imageFile = image;
        emailFile = email;
      });
      log(userName);
      log(imageFile);
      log(emailFile);
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    // final User user = Provider.of<UserProvider>(context).getUser;

    return file == null
        ? Center(
            child: IconButton(
              onPressed: () => _selectImage(context),
              icon: const Icon(Icons.upload),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {},
              ),
              title: Text(userName),
              actions: [
                TextButton(
                  onPressed: () {
                    getUser();
                  },
                  child: const Text(
                    "Add Post",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          imageFile),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                      child: SizedBox(
                        width:
                            200.0, // Set a width, or use constraints like constraints: BoxConstraints.expand(),
                        child: TextField(
                          controller: TextEditingController(),
                          decoration: const InputDecoration(
                              hintText: 'Write a caption',
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundImage:MemoryImage(file!),
                    ),
                  ],
                )
              ],
            ),
          );
  }
}
