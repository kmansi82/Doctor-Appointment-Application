import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/Admin/HomeAdmin.dart';
import 'package:health_care/Admin/LoginAdmin.dart';
import 'package:email_auth/email_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_care/utils/Colors.dart';
import 'package:health_care/widgets/ButtonWidget.dart';
import 'package:health_care/widgets/HeaderContainer.dart';

class SignUpadmin extends StatefulWidget {
  @override
  _SignUpadminState createState() => _SignUpadminState();
}

class _SignUpadminState extends State<SignUpadmin> {
  final TextEditingController _otpController = TextEditingController();
  String _email;
  String _password;
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  Future<void> validate() async {
    if (_formKey.currentState.validate()) {
      try {
        final newuser = await _auth
            .createUserWithEmailAndPassword(email: _email, password: _password)
            .then((value) async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString('email', _email);
          print("Mansiiiiiiiiiiiiiiiiiiiiiiiiii");
          print(pref);
        }).then((user) => Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeAdmin())));

        if (newuser != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeAdmin()),
          );
        }
      } catch (e) {
        Fluttertoast.showToast(msg: "Invalid Email or Password");
      }
    } else {
      Fluttertoast.showToast(msg: "Enter all details");
    }
  }

  void sendOTP() async {
    EmailAuth.sessionName = "Test";
    var res = await EmailAuth.sendOtp(receiverMail: "mansikkhatri8@gmail.com");
    if (res) {
      print("sent");
    }
  }

  void verifyOTP() {
    var res = EmailAuth.validate(
        receiverMail: "mansikkhatri8@gmail.com", userOTP: _otpController.text);
    if (res) {
      print("verify");
    } else {
      print("invalid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 30),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Column(
            children: <Widget>[
              HeaderContainer("Admin SignUp"),
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
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.only(left: 10),
                        child: TextFormField(
                          controller: _otpController,
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter OTP",
                            prefixIcon: Icon(Icons.offline_bolt),
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
                            btnText: "Get OTP",
                            onClick: () {
                              sendOTP();
                              Fluttertoast.showToast(
                                  msg:
                                      "OTP sent to the Administrator Email Account");
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: ButtonWidget(
                            btnText: "VERIFY AND REGISTER",
                            onClick: () async {
                              var res = EmailAuth.validate(
                                  receiverMail: "mansikkhatri8@gmail.com",
                                  userOTP: _otpController.text);
                              if (res) {
                                Fluttertoast.showToast(
                                    msg: "successfully verified OTP ");
                                validate();
                              } else {
                                Fluttertoast.showToast(msg: "Incorrect OTP ");
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
                            MaterialPageRoute(
                                builder: (context) => LoginAdmin()),
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
