// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:health_care/User/Users.dart';
// import 'package:health_care/utils/Colors.dart';
// import 'navigation_admin.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:health_care/utils/loading.dart';
// import 'package:intl/intl.dart';

// class Home_msg extends StatefulWidget {
//   @override
//   _Home_msgState createState() => _Home_msgState();
// }

// class _Home_msgState extends State<Home_msg> {
//   TextEditingController messageController = TextEditingController();
//   TextEditingController chooseDateController = TextEditingController();

//   String myMessage;
//   String myDate;

//   @override
//   Widget build(BuildContext context) {
//     DateTime now = new DateTime.now();
//     DateTime selectedDate = DateTime.now();

//     _selectDate(BuildContext context) async {
//       final DateTime picked = await showDatePicker(
//         context: context,
//         initialDate: selectedDate, // Refer step 1
//         firstDate: DateTime(2000),
//         lastDate: DateTime(2025),
//       );
//       if (picked != null && picked != selectedDate)
//         setState(() {
//           selectedDate = picked;
//         });
//     }

//     return Scaffold(
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           messageController.text = "$myMessage";
//           chooseDateController.text = "$myDate";
//           // ageController.text = "$myAge";
//           // genderController.text = "$myGender";
//           // addressController.text = "$myAddress";
//           showDialog(
//               context: context,
//               builder: (context) => Dialog(
//                     child: Container(
//                       color: myContainer,
//                       child: Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: ListView(
//                           shrinkWrap: true,
//                           children: [
//                             Container(
//                               child: TextField(
//                                 maxLines: null,
//                                 keyboardType: TextInputType.multiline,
//                                 controller: messageController,
//                                 decoration: InputDecoration(
//                                     labelText: "Message",
//                                     labelStyle: TextStyle(color: Colors.red)),
//                               ),
//                             ),
//                             Container(
//                               child: TextField(
//                                 maxLines: null,
//                                 keyboardType: TextInputType.multiline,
//                                 controller: chooseDateController,
//                                 decoration: InputDecoration(
//                                     labelText: "Date",
//                                     labelStyle: TextStyle(color: Colors.red)),
//                               ),
//                             ),
//                             IconButton(
//                               icon: Image.asset("assets/images/calendar.png"),
//                               color: Colors.white,
//                             ),
//                             FlatButton(
//                               color: orangeLightColors,
//                               child: Text("Update",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                   )),
//                               onPressed: () {
//                                 MessageUpdate().updateNewUser(
//                                     context,
//                                     messageController.text,
//                                     chooseDateController.text);
//                               },
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ));
//         },
//         label: const Text('Edit Message'),
//         icon: const Icon(Icons.edit),
//         backgroundColor: orangeLightColors,
//       ),
//       appBar: AppBar(
//         backgroundColor: orangeLightColors,
//         title: Text(" Your Message to patient"),
//       ),
//       drawer: navigationAdmin(),
//       body: Container(
//         child: Column(
//           children: [
//             Center(
//               child: Container(
//                 height: MediaQuery.of(context).size.height * 0.37,
//                 width: MediaQuery.of(context).size.height * 0.37,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/images/messagelogo.jpg'),
//                     fit: BoxFit.fill,
//                   ),
//                   shape: BoxShape.circle,
//                 ),
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.all(10),
//               margin: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.black, width: 2),
//                 borderRadius: BorderRadius.circular(2),
//                 color: Colors.blue[100],
//               ),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: Image.asset("assets/images/calendar.png"),
//                     color: Colors.white,
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text(DateFormat.yMMMd().format(now)),
//                 ],
//               ),
//             ),
//             FutureBuilder(
//               future: _fetch(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState != ConnectionState.done)
//                   return Loading();
//                 //return Text("Loading data...Please wait");
//                 return Material(
//                   // // child: Column(
//                   // //   children: [
//                   // //     SizedBox(
//                   // //       height: 30,
//                   // //     ),
//                   // //     ListTile(
//                   // //       title: Center(
//                   // //         child: Text(
//                   // //           "$myDate \n$myMessage",
//                   // //           style: TextStyle(
//                   // //             fontSize: 25.0,
//                   // //             color: Colors.black,
//                   // //             fontWeight: FontWeight.bold,
//                   // //             fontFamily: "Pacifico",
//                   // //           ),
//                   // //         ),
//                   // //       ),
//                   // //     ),
//                   // //   ],
//                   // // ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       Text(
//                         "${selectedDate.toLocal()}".split(' ')[0],
//                         style: TextStyle(
//                             fontSize: 55, fontWeight: FontWeight.bold),
//                       ),
//                       RaisedButton(
//                         onPressed: () => _selectDate(context),
//                         child: Text('Select date'),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   _fetch() async {
//     final firebaseUser = FirebaseAuth.instance.currentUser;
//     if (firebaseUser != null)
//       await FirebaseFirestore.instance
//           .collection('Message')
//           .doc('haCytfwTRZVZjNXPsKs6')
//           .get()
//           .then((ds) {
//         myMessage = ds.data()['Message'];
//         myDate = ds.data()['Date'];
//       }).catchError((e) {
//         print(e);
//       });
//   }
// }

import 'package:flutter/material.dart';
import 'package:health_care/User/Users.dart';
import 'package:health_care/utils/Colors.dart';
import 'navigation_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_care/utils/loading.dart';
import 'package:intl/intl.dart';

import 'dart:async';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime selectedDate = DateTime.now();
  TextEditingController messageController = TextEditingController();
  TextEditingController chooseDateController = TextEditingController();

  String myMessage;

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    var firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('Message')
          .doc('haCytfwTRZVZjNXPsKs6')
          .update({
        'Date': "${selectedDate.toLocal()}".split(' ')[0],
      });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();

    return Scaffold(
        resizeToAvoidBottomInset: false, //new line

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            messageController.text = "$myMessage";
            // ageController.text = "$myAge";
            // genderController.text = "$myGender";
            // addressController.text = "$myAddress";
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
                              Container(
                                child: TextField(
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  controller: messageController,
                                  decoration: InputDecoration(
                                      labelText: "Message",
                                      labelStyle: TextStyle(color: Colors.red)),
                                ),
                              ),
                              FlatButton(
                                color: orangeLightColors,
                                child: Text("Update",
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                                onPressed: () {
                                  MessageUpdate().updateNewUser(
                                    context,
                                    messageController.text,
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ));
          },
          label: const Text('Edit Message'),
          icon: const Icon(Icons.edit),
          backgroundColor: orangeLightColors,
        ),
        appBar: AppBar(
          backgroundColor: orangeLightColors,
          title: Text(" Your Message to patient"),
        ),
        drawer: navigationAdmin(),
        body: Container(
          child: Column(
            children: [
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.37,
                  width: MediaQuery.of(context).size.height * 0.37,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/messagelogo.jpg'),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.blue[100],
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today_rounded, color: Colors.blue),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Today's Date: "),
                    Text(DateFormat.yMMMd().format(now)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.pink[100],
                ),
                child: Row(
                  children: <Widget>[
                    Text("Choose date for message: "),
                    Text(
                      "${selectedDate.toLocal()}".split(' ')[0],
                    ),
                    IconButton(
                      icon: Image.asset("assets/images/calendar.png"),
                      color: Colors.white,
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                  future: _fetch(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done)
                      return Loading();
                    return Material(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          // border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.blue[100],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Message",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 20.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Pacifico",
                              ),
                            ),
                            ListTile(
                              title: Center(
                                child: Text(
                                  "$myMessage",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Pacifico",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ));
  }

  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('Message')
          .doc('haCytfwTRZVZjNXPsKs6')
          .get()
          .then((ds) {
        myMessage = ds.data()['Message'];
      }).catchError((e) {
        print(e);
      });
  }
}
