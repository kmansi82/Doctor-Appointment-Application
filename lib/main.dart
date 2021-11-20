import 'dart:async';

import 'package:flutter/material.dart';
import 'package:health_care/Admin/HomeAdmin.dart';
import 'package:health_care/User/SignUpScreen.dart';
import 'package:get/get.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:get_storage/get_storage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:health_care/utils/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ChooseUserAdmin.dart';
import 'User/HomePage.dart';
// import 'User/Splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences pref = await SharedPreferences.getInstance();
  var email = pref.getString('email');
  var adminemail = pref.getString('adminemail');
  runApp(MaterialApp(
      home: adminemail != null
          ? HomeAdmin()
          : email != null
              ? HomePage()
              : SplashPage()));
}

//Adminemail == null ? SplashPage() : HomePage()
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final userdate = GetStorage();
  @override
  void initState() {
    super.initState();
    userdate.writeIfNull('isLogged', false);

    Future.delayed(Duration.zero, () async {
      checkiflogged();
    });
    Timer(const Duration(milliseconds: 6000), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ChooseUserAdmin()),
          (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: orangeLightColors,
      body: Center(
        child: Container(
          color: orangeLightColors,
          child: DefaultTextStyle(
            style: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            child: Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  FadeAnimatedText('Welcome To '),
                  FadeAnimatedText('HealthCare App'),
                ],
                onTap: () {
                  print("Tap Event");
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void checkiflogged() {
    print("called...");

    userdate.read('isLogged') ? Get.offAll(HomePage()) : Get.offAll(SignUp());
  }
}
