import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_care/User/Loginscreen.dart';
import 'package:health_care/User/Users.dart';
import 'package:health_care/utils/Colors.dart';
import 'package:health_care/utils/loading.dart';
import 'package:health_care/widgets/HeaderContainer.dart';

import 'NavigationDrawer.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String myName;
  String myMob;
  String myAge;
  String myGender;
  String myAddress;
  bool loading = false;

  _buildTextField(
      keyboardType, TextEditingController controller, String labelText) {
    return Container(
      child: TextField(
        maxLines: null,
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
            labelText: labelText, labelStyle: TextStyle(color: Colors.red)),
      ),
    );
  }

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
          appBar: AppBar(
            backgroundColor: orangeLightColors,
            title: Text("Your Profile"),
            actions: <Widget>[],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: FutureBuilder(
                    future: _fetch(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done)
                        return Loading();
                      //return Text("Loading data...Please wait");
                      return Material(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('assets/images/UserLogo.png'),
                            ),
                            ListTile(
                              title: Center(
                                child: Text(
                                  "Hello.. ! $myName",
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Pacifico",
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 35),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "User Name",
                                style: TextStyle(
                                    color: labletext,
                                    fontSize: 13,
                                    fontFamily: "Source Sans Pro"),
                              ),
                            ),
                            Card(
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 25),
                              child: ListTile(
                                leading: Icon(
                                  Icons.ac_unit,
                                  color: orangeColors,
                                ),
                                title: Text(
                                  "$myName",
                                  style: TextStyle(
                                      color: orangeColors,
                                      fontSize: 20,
                                      fontFamily: "Source Sans Pro"),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 35),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Your Age",
                                style: TextStyle(
                                    color: labletext,
                                    fontSize: 13,
                                    fontFamily: "Source Sans Pro"),
                              ),
                            ),
                            Card(
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 25),
                              child: ListTile(
                                leading: Icon(
                                  Icons.ac_unit,
                                  color: orangeColors,
                                ),
                                title: Text(
                                  "$myAge",
                                  style: TextStyle(
                                      color: orangeColors,
                                      fontSize: 20,
                                      fontFamily: "Source Sans Pro"),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 35),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Your Gender",
                                style: TextStyle(
                                    color: labletext,
                                    fontSize: 13,
                                    fontFamily: "Source Sans Pro"),
                              ),
                            ),
                            Card(
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 25),
                              child: ListTile(
                                leading: Icon(
                                  Icons.ac_unit,
                                  color: orangeColors,
                                ),
                                title: Text(
                                  "$myGender",
                                  style: TextStyle(
                                      color: orangeColors,
                                      fontSize: 20,
                                      fontFamily: "Source Sans Pro"),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 35),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Mobile No.",
                                style: TextStyle(
                                    color: labletext,
                                    fontSize: 13,
                                    fontFamily: "Source Sans Pro"),
                              ),
                            ),
                            Card(
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 25),
                              child: ListTile(
                                leading: Icon(
                                  Icons.ac_unit,
                                  color: orangeColors,
                                ),
                                title: Text(
                                  "$myMob",
                                  style: TextStyle(
                                      color: orangeColors,
                                      fontSize: 20,
                                      fontFamily: "Source Sans Pro"),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 35),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Address",
                                style: TextStyle(
                                    color: labletext,
                                    fontSize: 13,
                                    fontFamily: "Source Sans Pro"),
                              ),
                            ),
                            Card(
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 25),
                              child: ListTile(
                                leading: Icon(
                                  Icons.ac_unit,
                                  color: orangeColors,
                                ),
                                title: Text(
                                  "$myAddress",
                                  style: TextStyle(
                                      color: orangeColors,
                                      fontSize: 20,
                                      fontFamily: "Source Sans Pro"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              nameController.text = "$myName";
              mobController.text = "$myMob";
              ageController.text = "$myAge";
              genderController.text = "$myGender";
              addressController.text = "$myAddress";
              showDialog(
                  context: context,
                  builder: (context) => Dialog(
                        child: Container(
                          color: myContainer,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                _buildTextField(TextInputType.multiline,
                                    nameController, 'name'),
                                SizedBox(height: 20),
                                _buildTextField(
                                    TextInputType.number, ageController, 'age'),
                                SizedBox(height: 20),
                                _buildTextField(TextInputType.multiline,
                                    genderController, 'gender'),
                                SizedBox(height: 20),
                                _buildTextField(
                                    TextInputType.number, mobController, 'mob'),
                                SizedBox(height: 20),
                                _buildTextField(TextInputType.multiline,
                                    addressController, 'address'),
                                FlatButton(
                                  color: orangeLightColors,
                                  child: Text("Update",
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                  onPressed: () {
                                    UserManagementUpdate().updateNewUser(
                                        context,
                                        nameController.text,
                                        ageController.text,
                                        genderController.text,
                                        mobController.text,
                                        addressController.text);
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
            },
            label: const Text('Edit'),
            icon: const Icon(Icons.edit),
            backgroundColor: orangeLightColors,
          ),
          drawer: navigationDrawer(),
        ));
  }

  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        myName = ds.data()['name'];
        myAge = ds.data()['age'];
        myGender = ds.data()['gender'];
        myMob = ds.data()['mob'];
        myAddress = ds.data()['address'];

        print(myName);
      }).catchError((e) {
        print(e);
      });
  }
}
