import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/layout/mobile_screen_layout.dart';
import 'package:instagram_flutter/layout/web_screen_layout.dart';
import 'package:instagram_flutter/responsive/responsive_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:core';

// import 'package:instagram_flutter/screens/signup_screen.dart';

import 'package:instagram_flutter/screens/login_screen.dart';
// import 'package:instagram_flutter/screens/signup_screen.dart';
// import 'package:instagram_flutter/screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const apiKey = "AIzaSyAedA5jL2LeBGQoIP5cw1cbcmq8uN6iwv4";
  const appId = "1:830172369399:web:f37fd147055ac1189c5ef2";
  const messagingSenderId = "830172369399";
  const projectId = "instagram-clone-6fe53";
  const storageBucket = "instagram-clone-6fe53.appspot.com";

  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: apiKey,
    appId: appId,
    messagingSenderId: messagingSenderId,
    projectId: projectId,
    storageBucket: storageBucket,
  ));
  // check if firebase connected

  if (Firebase.apps.isNotEmpty) {
    log(" firebase connected successfully");
  } else {
    log(" firebase connected successfully");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),

      // home: const SignUpScreen(),

      // home: const LogInScreen(),

      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout());
            }
            else if(snapshot.hasError){
              return Center(
                child: Text("${snapshot.error}"),
              );
            }
          }

          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(backgroundColor: Colors.white),
            );
          }
          return const LogInScreen();
        },
      ),
      // home: const ResponsiveLayout(
      //     mobileScreenLayout: MobileScreenLayout(),
      //     webScreenLayout: WebScreenLayout()),
    );
  }
}
