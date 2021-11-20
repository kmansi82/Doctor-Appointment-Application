import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/User/Loginscreen.dart';
import 'package:health_care/User/userdetails.dart';
import 'package:health_care/utils/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:health_care/widgets/ButtonWidget.dart';
import 'package:health_care/widgets/HeaderContainer.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email;
  String _password;
  bool loading = false;
  final _auth = FirebaseAuth.instance;
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
              HeaderContainer("Register"),
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
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (val) =>
                              val.isEmpty ? 'Can not be empty' : null,
                          onChanged: (val) {
                            setState(() => _email = val);
                          },
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
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            prefixIcon: Icon(Icons.vpn_key),
                          ),
                          validator: (val) => val.length < 6
                              ? 'Enter a password 6+ chars long'
                              : null,
                          onChanged: (value) => setState(() {
                            _password = value;
                          }),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: ButtonWidget(
                            btnText: "REGISTER",
                            onClick: () async {
                              try {
                                final newuser = await _auth
                                    .createUserWithEmailAndPassword(
                                        email: _email, password: _password)
                                    .then((value) async {
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  pref.setString('email', _email);
                                  print("Mansiiiiiiiiiiiiiiiiiiiiiiiiii");
                                  print(pref);
                                }).then((user) => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Userdetails())));

                                if (newuser != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Userdetails()),
                                  );
                                }
                              } catch (e) {
                                Fluttertoast.showToast(msg: "Invalid");
                              }
                            },
                          ),
                        ),
                      ),
                      InkWell(
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Already a member ? ",
                                style: TextStyle(color: Colors.black)),
                            TextSpan(
                                text: "Login",
                                style: TextStyle(color: orangeColors)),
                          ]),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
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
