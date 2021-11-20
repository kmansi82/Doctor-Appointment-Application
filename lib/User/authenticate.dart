import 'package:flutter/material.dart';
import 'package:health_care/User/Loginscreen.dart';
import 'package:health_care/User/SignUpScreen.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Login();
    } else {
      return SignUp();
    }
  }
}
