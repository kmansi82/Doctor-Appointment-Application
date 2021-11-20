import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:health_care/User/HomePage.dart';
import 'package:health_care/utils/Colors.dart';
import 'package:health_care/widgets/ButtonWidget.dart';
import 'package:health_care/widgets/HeaderContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ForgetPassScreen.dart';
import 'SignUpScreen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email;
  String _password;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(bottom: 30),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Column(
            children: <Widget>[
              HeaderContainer("Login"),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.only(left: 10),
                        child: TextFormField(
                          validator: (val) =>
                              val.isEmpty ? 'Enter an E-mail' : null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email),
                          ),
                          onChanged: (value) => setState(() {
                            _email = value;
                          }),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.only(left: 10),
                        child: TextFormField(
                          obscureText: true,
                          validator: (val) => val.length < 6
                              ? 'Enter a password 6+ chars long'
                              : null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            prefixIcon: Icon(Icons.vpn_key),
                          ),
                          onChanged: (value) => setState(() {
                            _password = value;
                          }),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          child: Text(
                            "Forgot Password?",
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResetPass()),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: ButtonWidget(
                            onClick: () {
                              // logindata.setBool('login', false);
                              FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: _email, password: _password)
                                  .then((value) async {
                                    SharedPreferences pref =
                                        await SharedPreferences.getInstance();
                                    pref.setString('email', _email);
                                    print("Mansiiiiiiiiiiiiiiiiiiiiiiiiii");
                                    print(pref);
                                  })
                                  .then((user) => Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()),
                                      (Route<dynamic> route) => false))
                                  .catchError((e) {
                                    Fluttertoast.showToast(
                                        msg: "Invalid Credential");
                                  });
                            },
                            btnText: "LOGIN",
                          ),
                        ),
                      ),
                      InkWell(
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Don't have an account ? ",
                                style: TextStyle(color: Colors.black)),
                            TextSpan(
                                text: "Register",
                                style: TextStyle(color: orangeColors)),
                          ]),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                          );
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
