import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_care/Admin/navigation_admin.dart';
import 'package:health_care/utils/Colors.dart';
import 'package:spinner_input/spinner_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care/ChooseUserAdmin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

int cnt1 = 5;
int cnt2 = 5;
double spinner = 0;
double spinner1 = 0;
double spinner3 = 0;

class temp extends StatefulWidget {
  @override
  _tempState createState() => _tempState();
}

CollectionReference ref = FirebaseFirestore.instance.collection('Date');

class _tempState extends State<temp> {
  CollectionReference ref = FirebaseFirestore.instance.collection('Date');

  String userleft1;
  String count;
  DatePickerController _controller = DatePickerController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HealthCareAdmin App"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.remove('adminemail');
              FirebaseAuth.instance.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChooseUserAdmin()));
            },
          ),
        ],
        backgroundColor: orangeLightColors,
      ),
      drawer: navigationAdmin(),
      body: StreamBuilder(
          stream: ref.snapshots(),
          builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    var doc = snapshot.data.docs[index];

                    return InkWell(
                      child: Column(
                        children: [Text("bye")],
                      ),
                    );
                  });
            } else {
              return Text("no complain");
            }
          }),
    );
  }
}
