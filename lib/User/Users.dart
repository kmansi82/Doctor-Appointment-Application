import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care/Admin/appointment_taking.dart';
import 'package:health_care/Admin/home_msg.dart';
import 'package:health_care/User/HomePage.dart';
import 'package:health_care/User/Profile.dart';

class UserManagement {
  storeNewUser(context, name, age, gender, mob, address) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .set({
          'name': name,
          'age': age,
          'gender': gender,
          'mob': mob,
          'address': address
        })
        .then((value) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false))
        .catchError((e) {
          print(e);
        });
  }
}

class UserManagementUpdate {
  updateNewUser(context, name, age, gender, mob, address) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .update({
          'name': name,
          'age': age,
          'gender': gender,
          'mob': mob,
          'address': address
        })
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Profile())))
        .catchError((e) {
          print(e);
        });
  }
}

class Messagge {
  storeNewUser(context, msg) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('Message')
        .doc('haCytfwTRZVZjNXPsKs6')
        .set({'Message': msg})
        .then((value) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => appointment()),
            (Route<dynamic> route) => false))
        .catchError((e) {
          print(e);
        });
  }
}

// class MessageUpdate {
//   updateNewUser(context, message) {
//     var firebaseUser = FirebaseAuth.instance.currentUser;
//     FirebaseFirestore.instance
//         .collection('Message')
//         .doc('haCytfwTRZVZjNXPsKs6')
//         .update({
//           'Message': message,
//         })
//         .then((value) => Navigator.push(
//             context, MaterialPageRoute(builder: (context) => Home_msg())))
//         .catchError((e) {
//           print(e);
//         });
//   }
// }

class MessageUpdate {
  updateNewUser(context, message) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('Message')
        .doc('haCytfwTRZVZjNXPsKs6')
        .update({
          'Message': message,
        })
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage())))
        .catchError((e) {
          print(e);
        });
  }
  
}

// class dateUpdate {
//   updateNewUser(context, date) {
//     var firebaseUser = FirebaseAuth.instance.currentUser;
//     FirebaseFirestore.instance
//         .collection('Message')
//         .doc('haCytfwTRZVZjNXPsKs6')
//         .update({
//           'Message': message,
//         })
//         .then((value) => Navigator.push(
//             context, MaterialPageRoute(builder: (context) => MyHomePage())))
//         .catchError((e) {
//           print(e);
//         });
//   }
// }