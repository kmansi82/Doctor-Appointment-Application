import 'package:flutter/material.dart';
import 'package:health_care/Admin/Solved.dart';
import 'package:health_care/Admin/addadmin.dart';
import 'package:health_care/Admin/appointment_taking.dart';
import 'package:health_care/Admin/Bookedcomplain.dart';
import 'package:health_care/User/HomePage.dart';
import 'package:health_care/utils/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care/ChooseUserAdmin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get_storage/get_storage.dart';

import 'home_msg.dart';
import 'messageSection.dart';

class navigationAdmin extends StatelessWidget {
  final userdata = GetStorage();
  @override
  Widget createDrawerBodyItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  Widget createDrawerHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: orangeLightColors,
        ),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Welcome to HealthCare",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }

  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(),
          createDrawerBodyItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => appointment()),
                );
              }),
          createDrawerBodyItem(
              icon: Icons.add,
              text: 'Add admin',
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Addadmin()),
                    (Route<dynamic> route) => false);
              }),
          createDrawerBodyItem(
              icon: Icons.medical_services,
              text: 'Book appointment',
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => WaterAdmin()),
                    (Route<dynamic> route) => false);
              }),
          createDrawerBodyItem(
              icon: Icons.done_all,
              text: 'Solved appointment',
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Solved()),
                    (Route<dynamic> route) => false);
              }),
          createDrawerBodyItem(
              icon: Icons.message,
              text: 'Send message to patients',
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                    (Route<dynamic> route) => false);
              }),

          // createDrawerBodyItem(
          //     icon: Icons.view_agenda,
          //     text: 'View Complains',
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => Complains()),
          //       );
          //     }),
          createDrawerBodyItem(
              icon: Icons.logout,
              text: 'Logout',
              onTap: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.remove('email');
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => ChooseUserAdmin()),
                    (Route<dynamic> route) => false);
              }),
        ],
      ),
    );
  }
}
