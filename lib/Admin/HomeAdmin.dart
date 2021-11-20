import 'package:flutter/material.dart';
import 'package:health_care/Admin/appointment_taking.dart';
import 'package:health_care/Admin/Solved.dart';
import 'package:health_care/Admin/Unsolved.dart';
import 'package:health_care/Admin/addadmin.dart';

class HomeAdmin extends StatefulWidget {
  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  int currentindex = 0;
  List pages = [Unsolved(), Addadmin(), Solved()];
  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Exit App'),
              content: Text('Do you want to exit an App?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  //return true when click on "Yes"
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return WillPopScope(
        onWillPop: showExitPopup, //call function on back button press
        child: Scaffold(
          // appBar: AppBar(
          //   title: Text("HealthCareAdmin App"),
          //   actions: <Widget>[
          //     IconButton(
          //       icon: Icon(
          //         Icons.logout,
          //         color: Colors.white,
          //       ),
          //       onPressed: () async {
          //         SharedPreferences pref =
          //             await SharedPreferences.getInstance();
          //         pref.remove('adminemail');
          //         FirebaseAuth.instance.signOut();
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => ChooseUserAdmin()));
          //       },
          //     ),
          //   ],
          //   backgroundColor: orangeLightColors,
          // ),
          // drawer: navigationAdmin(),
          body: appointment(),
        ));
  }
}
