import 'package:flutter/material.dart';
// import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:instagram_flutter/responsive/global_variables.dart';
// import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;
  const ResponsiveLayout(
      {required this.mobileScreenLayout,
      required this.webScreenLayout,
      super.key});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

  @override
  void initState() {
    super.initState();
    // addData();
    
  }

  // Future<void> addData() async{
  //     UserProvider userProvider = Provider.of(context, listen: false);
  //     await userProvider.refreshUser();
  //   }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        return widget.webScreenLayout;
      }
      return widget.mobileScreenLayout;
    });
  }
}
