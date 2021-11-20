import 'package:flutter/material.dart';
import 'package:health_care/ChooseUserAdmin.dart';
import 'package:health_care/User/HomePage.dart';
import 'package:health_care/complainfiles/complain.dart';
import 'package:health_care/utils/Colors.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'Profile.dart';

class navigationDrawer extends StatelessWidget {
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
              child: Text("Welcome ",
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
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              }),
          createDrawerBodyItem(
              icon: Icons.account_circle,
              text: 'Profile',
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                    (Route<dynamic> route) => false);
              }),
          // createDrawerBodyItem(
          //     icon: Icons.view_agenda,
          //     text: 'View Appointment',
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => ViewComplainsWater()),
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
