import 'package:flutter/material.dart';
import 'package:instagram_flutter/layout/mobile_screen_layout.dart';
import 'package:instagram_flutter/layout/web_screen_layout.dart';
import 'package:instagram_flutter/responsive/responsive_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout()),
    );
  }
}
