import 'package:flutter/material.dart';
import 'package:health_care/Admin/appointment_taking.dart';
import 'package:health_care/utils/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'LoginAdmin.dart';

class Unsolved extends StatefulWidget {
  @override
  _UnsolvedState createState() => _UnsolvedState();
}

class _UnsolvedState extends State<Unsolved> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: orangeLightColors,
        title: Text("Booked Appointment"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.remove('email');
              FirebaseAuth.instance.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginAdmin()));
            },
          ),
        ],
      ),
      body: Column(
          // children: [SizedBox(height: 30), appointment()],
          ),
    );
  }
}
