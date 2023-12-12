// import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/authentication/auth_methods.dart';
import 'package:instagram_flutter/image_picker/image_picker.dart';
import 'package:instagram_flutter/snackbar/snackbar.dart';
import 'package:instagram_flutter/widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  Uint8List? image;
  bool isLoading = false;

  void addPhoto() async {
    Uint8List photo = await selectImage(ImageSource.gallery);
    setState(() {
      image = photo;
    });
  }

  void signUpUser() async {
    setState(() {
      isLoading = true;
    });

    String response = await AuthMethods().signUpUser(
      email: emailController.text,
      password: passwordController.text,
      userName: userNameController.text,
      bio: bioController.text,
      imageFile: image!,
    );
    setState(() {
      isLoading = false;
    });
    if (!context.mounted) return;
    if (response != "success") {
      showSnackBar(response, context);
    }

    else if( response == "success"){
      emailController.text = "";
      userNameController.text = "";
      passwordController.text = "";
      bioController.text = "";
    }
  }

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SvgPicture.asset(
                    "images/instagram_logo.svg",
                    width: 100,
                    height: 150,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
                Center(
                  child: Stack(
                    children: [
                      image != null
                          ? CircleAvatar(
                              radius: 70,
                              backgroundImage: MemoryImage(
                                image!,
                              ))
                          : const CircleAvatar(
                              radius: 70,
                              backgroundImage: NetworkImage(
                                  "https://i.pinimg.com/736x/43/6d/dd/436ddd658ba9247540a9171feefe1971.jpg"),
                            ),
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: IconButton(
                          onPressed: addPhoto,
                          icon: const Icon(Icons.add_a_photo, size: 30),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "User Name",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFieldInput(
                        controller: userNameController,
                        hintText: "Enter User Name",
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFieldInput(
                        controller: emailController,
                        hintText: "Enter Email Address",
                        textInputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFieldInput(
                        controller: passwordController,
                        hintText: "Enter Password",
                        textInputType: TextInputType.text,
                        obscureText: true,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Bio",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFieldInput(
                        controller: bioController,
                        hintText: "Enter Bio",
                        textInputType: TextInputType.text,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      elevation: 10,
                    ),
                    onPressed: () async {
                      signUpUser();
                    },
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.purple,
                            ),
                          )
                        : const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
