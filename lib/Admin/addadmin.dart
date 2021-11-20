import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/Admin/HomeAdmin.dart';
import 'package:health_care/Admin/navigation_admin.dart';
import 'package:email_auth/email_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_care/utils/Colors.dart';

class Addadmin extends StatefulWidget {
  @override
  _AddadminState createState() => _AddadminState();
}

class _AddadminState extends State<Addadmin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String _email;
  String _password;
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  void clearText() {
    _emailController.clear();
    _otpController.clear();
    _passController.clear();
  }

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
    var res = await EmailAuth.sendOtp(receiverMail: _emailController.text);
    if (res) {
      print("sent");
    }
  }

  void verifyOTP() {
    var res = EmailAuth.validate(
        receiverMail: _emailController.text, userOTP: _otpController.text);
    if (res) {
      print("verify");
    } else {
      print("invalid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Other Admin"),
        backgroundColor: orangeLightColors,
      ),
      drawer: navigationAdmin(),
      resizeToAvoidBottomInset: false,
      body: Container(
        // padding: EdgeInsets.only(bottom: 30),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        "Add Other Admin",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.only(left: 10),
                        child: TextFormField(
                          controller: _emailController,
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
                          controller: _passController,
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
                          validator: (val) =>
                              val.length != 6 ? 'Enter a 6 char OTP' : null,
                          onChanged: (value) => setState(() {
                            _password = value;
                          }),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: orangeColors, // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: () {
                            sendOTP();
                            Fluttertoast.showToast(
                                msg:
                                    "OTP sent to the Administrator Email Account");
                          },
                          child: Text('Get OTP'),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: orangeColors, // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: () async {
                            var res = EmailAuth.validate(
                                receiverMail: _emailController.text,
                                userOTP: _otpController.text);
                            if (res) {
                              Fluttertoast.showToast(
                                  msg: "successfully verified OTP ");
                              validate();
                            } else {
                              Fluttertoast.showToast(msg: "Incorrect OTP ");
                            }
                            clearText();
                          },
                          child: Text('VERIFY AND REGISTER'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp()); 
// }

// class MyApp extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: "Test App",
//         home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {

//     Future<bool> showExitPopup() async {
//       return await showDialog( //show confirm dialogue 
//         //the return value will be from "Yes" or "No" options
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Exit App'),
//           content: Text('Do you want to exit an App?'),
//           actions:[
//             ElevatedButton(
//               onPressed: () => Navigator.of(context).pop(false),
//                //return false when click on "NO"
//               child:Text('No'),
//             ),

//             ElevatedButton(
//               onPressed: () => Navigator.of(context).pop(true), 
//               //return true when click on "Yes"
//               child:Text('Yes'),
//             ),

//           ],
//         ),
//       )??false; //if showDialouge had returned null, then return false
//     }

//     return WillPopScope( 
//       onWillPop: showExitPopup, //call function on back button press
//       child:Scaffold( 
//         appBar: AppBar( 
//           title: Text("Override Back Button"),
//           backgroundColor: Colors.redAccent,
//         ),
//         body: Center( 
//           child: Text("Override Back Buttton"),
//         )
//       )
//     );
//   }
// }
