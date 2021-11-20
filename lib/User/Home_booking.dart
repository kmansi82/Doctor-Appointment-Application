import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_care/User/NavigationDrawer.dart';
import 'package:health_care/utils/Colors.dart';
import 'package:health_care/widgets/ButtonWidget.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care/User/pdf_api.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:url_launcher/url_launcher.dart';

int cnt1 = 5;
int le;
int cnt2 = 5;
double spinner = 0;
double spinner3 = 0;

class trial extends StatefulWidget {
  @override
  _trialState createState() => _trialState();
}

String text;
VoidCallback onClicked;

class _trialState extends State<trial> {
  CollectionReference ref = FirebaseFirestore.instance.collection('Date');
  CollectionReference ref1 = FirebaseFirestore.instance.collection('Booking');
  CollectionReference ref2 = FirebaseFirestore.instance.collection('Message');

  String userleft1;
  String count;
  String myName;
  String myMob;
  String myGender;
  String myAge;
  String myAddress;
  String myMsg;
  String myMsgdate;
  bool reg = false;

  String mySlot;
  bool myReg = false;
  String mySlot1 = "MAnsi";

  DateTime now = new DateTime.now();
  @override
  void initState() {
    super.initState();
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _UserField(
    String time,
    String left,
    String doc,
    String strr,
    String mydata,
  ) {
    return InkWell(
        child: Container(
          padding: EdgeInsets.all(11),
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Container(
                child: Text(time),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                left,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Avenir',
                    fontWeight: FontWeight.w700),
                textScaleFactor: 1.1,
              ),
            ],
          ),
        ),
        onTap: () {
          return showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Are you sure you want to book the appointment?'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Done'),
                      onPressed: () async {
                        myReg = true;
                        print(myReg);
                        le = int.parse(doc);
                        if (le > 0) {
                          le--;
                          var firebaseUser = FirebaseAuth.instance.currentUser;
                          if (firebaseUser != null)
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(firebaseUser.uid)
                                .get()
                                .then((ds) {
                              myName = ds.data()['name'];
                              myMob = ds.data()['mob'];
                              myGender = ds.data()['gender'];
                              myAddress = ds.data()['address'];
                              myAge = ds.data()['age'];
                              ref1
                                  .doc(firebaseUser.uid)
                                  .set({'timeslot': time, 'reg': myReg});
                            });
                          FirebaseFirestore.instance
                              .collection('Booking')
                              .doc(firebaseUser.uid)
                              .get()
                              .then((ds) {
                            mySlot = ds.data()['timeslot'];
                            print(mySlot);
                          });

                          Map<String, dynamic> data = {
                            'name': myName,
                            'mob': myMob,
                            'gender': myGender,
                            'address': myAddress,
                            'date': DateFormat.yMMMd().format(now),
                            'age': myAge,
                            'timeslot': time
                          };
                          FirebaseFirestore.instance
                              .collection("Booked Complain")
                              .add(data);

                          FirebaseFirestore.instance
                              .collection('Date')
                              .doc("GJcwKO67e5219p7jCcxM")
                              .update({strr: le.toString()}).then(
                                  (value) => Navigator.pop(context));
                          Fluttertoast.showToast(
                              timeInSecForIosWeb: 1,
                              msg:
                                  /*le.toString() +
                                  " Slots are Left" +
                                  "\n" +*/
                                  "Your appointment has been registered. Download the receipt.");
                        }

                        if (le == 0) {
                          Navigator.of(context).pop();
                          Fluttertoast.showToast(
                              msg: "No More slot is Avilable");
                        }
                      },
                    ),
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          onOpen: () => print('OPENING DIAL'),
          onClose: () => print('DIAL CLOSED'),
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: orangeColors,
          foregroundColor: Colors.white,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
              child: Icon(Icons.download),
              label: 'Download',
              onTap: () async {
                var firebaseUser = FirebaseAuth.instance.currentUser;

                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(firebaseUser.uid)
                    .get()
                    .then((ds) {
                  myName = ds.data()['name'];
                  myMob = ds.data()['mob'];
                  myGender = ds.data()['gender'];
                  myAddress = ds.data()['address'];
                  myAge = ds.data()['age'];
                });

                final pdfFile = await PdfApi.generateCenteredText("Date: " +
                    DateFormat.yMMMd().format(now) +
                    '\n' +
                    "Name: " +
                    myName +
                    '\n' +
                    "Age: " +
                    myAge +
                    '\n' +
                    "Gender: " +
                    myGender +
                    '\n' +
                    "Your visiting Time-Slot: " +
                    mySlot +
                    '\n' +
                    "Mobile Number: " +
                    myMob +
                    '\n' +
                    "Address: " +
                    myAddress);
                PdfApi.openFile(pdfFile);
              },
            ),
            SpeedDialChild(
                child: Icon(Icons.phone),
                label: 'Call Us',
                onTap: () async {
                  setState(() {
                    _makePhoneCall('tel:5412547896');
                  });
                }),
            SpeedDialChild(
                child: Icon(Icons.location_city_outlined),
                label: 'Location',
                onTap: () async {
                  const url = 'https://flutter.io';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }),
          ]),
      appBar: AppBar(
        title: Text("HealthCare App"),
        actions: <Widget>[
          IconButton(
            icon: Image.asset("assets/images/notification.png"),
            color: Colors.white,
            onPressed: () async {
              var firebaseUser = FirebaseAuth.instance.currentUser;

              await FirebaseFirestore.instance
                  .collection('Message')
                  .doc('haCytfwTRZVZjNXPsKs6')
                  .get()
                  .then((ds) {
                myMsg = ds.data()['Message'];
                myMsgdate = ds.data()['Date'];
              });
              Flushbar(
                duration: Duration(seconds: 3),
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(10),
                borderRadius: 8,
                backgroundGradient: LinearGradient(
                  colors: [Colors.red.shade800, Colors.redAccent.shade700],
                  stops: [0.6, 1],
                ),
                boxShadows: [
                  BoxShadow(
                    color: Colors.black45,
                    offset: Offset(3, 3),
                    blurRadius: 3,
                  ),
                ],
                flushbarPosition: FlushbarPosition.TOP,
                title: 'Note \n$myMsgdate',
                message: myMsg,
                icon: Icon(
                  Icons.warning,
                  size: 28,
                  color: Colors.yellow.shade300,
                ),
                leftBarIndicatorColor: Colors.red[300],
              )..show(context);
            },
          ),
        ],
        backgroundColor: orangeLightColors,
      ),
      drawer: navigationDrawer(),
      body: Center(
        child: StreamBuilder(
            stream: ref.snapshots(),
            builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      var doc = snapshot.data.docs[index];

                      return Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    // border: Border.all(color: Colors.black, width: 2),
                                    borderRadius: BorderRadius.circular(2),
                                    color: Colors.pink[100],
                                  ),
                                  child: Text("Current Date : " +
                                      DateFormat.yMMMd().format(now) +
                                      "\n" +
                                      "Cancel Your Today's Appointment"),
                                ),
                                Transform.scale(
                                  scale: 1.3,
                                  child: IconButton(
                                      icon: Image.asset(
                                          "assets/images/cancellation.png"),
                                      onPressed: () {
                                        print(myReg);
                                        if (myReg == true) {
                                          return showDialog(
                                            //show confirm dialogue
                                            //the return value will be from "Yes" or "No" options
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text('Cancel Appointment'),
                                              content: Text(
                                                  'Do you want to cancel your Appointment? \n\nSlot: ' +
                                                      mySlot),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                  //return false when click on "NO"
                                                  child: Text('No'),
                                                ),
                                                ElevatedButton(
                                                    child: Text('Yes'),
                                                    onPressed: () async {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                      if (mySlot ==
                                                              "10:00 - 11:00 AM" &&
                                                          myReg == true) {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('Date')
                                                            .doc(
                                                                "GJcwKO67e5219p7jCcxM")
                                                            .update({
                                                          "left_0": (int.parse(doc[
                                                                      "left_0"]) +
                                                                  1)
                                                              .toString()
                                                        });
                                                        myReg = false;
                                                        var firebaseUser =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser;

                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Booking')
                                                            .doc(firebaseUser
                                                                .uid)
                                                            .get()
                                                            .then((ds) {
                                                          ref1
                                                              .doc(firebaseUser
                                                                  .uid)
                                                              .update({
                                                            'reg': myReg
                                                          });
                                                        });
                                                      }
                                                      if (mySlot ==
                                                              "11:00 - 12:00 PM" &&
                                                          myReg == true) {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('Date')
                                                            .doc(
                                                                "GJcwKO67e5219p7jCcxM")
                                                            .update({
                                                          "left_1": (int.parse(doc[
                                                                      "left_1"]) +
                                                                  1)
                                                              .toString()
                                                        });
                                                        myReg = false;
                                                        var firebaseUser =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser;

                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Booking')
                                                            .doc(firebaseUser
                                                                .uid)
                                                            .get()
                                                            .then((ds) {
                                                          ref1
                                                              .doc(firebaseUser
                                                                  .uid)
                                                              .update({
                                                            'reg': myReg
                                                          });
                                                        });
                                                      }
                                                      if (mySlot ==
                                                              "01:00 - 02:00 PM" &&
                                                          myReg == true) {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('Date')
                                                            .doc(
                                                                "GJcwKO67e5219p7jCcxM")
                                                            .update({
                                                          "left_2": (int.parse(doc[
                                                                      "left_2"]) +
                                                                  1)
                                                              .toString()
                                                        });
                                                        myReg = false;
                                                        var firebaseUser =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser;

                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Booking')
                                                            .doc(firebaseUser
                                                                .uid)
                                                            .get()
                                                            .then((ds) {
                                                          ref1
                                                              .doc(firebaseUser
                                                                  .uid)
                                                              .update({
                                                            'reg': myReg
                                                          });
                                                        });
                                                      }
                                                      if (mySlot ==
                                                              "02:00 - 03:00 PM" &&
                                                          myReg == true) {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('Date')
                                                            .doc(
                                                                "GJcwKO67e5219p7jCcxM")
                                                            .update({
                                                          "left_3": (int.parse(doc[
                                                                      "left_3"]) +
                                                                  1)
                                                              .toString()
                                                        });
                                                        myReg = false;
                                                        var firebaseUser =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser;

                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Booking')
                                                            .doc(firebaseUser
                                                                .uid)
                                                            .get()
                                                            .then((ds) {
                                                          ref1
                                                              .doc(firebaseUser
                                                                  .uid)
                                                              .update({
                                                            'reg': myReg
                                                          });
                                                        });
                                                      }
                                                      if (mySlot ==
                                                              "03:00 - 04:00 PM" &&
                                                          myReg == true) {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('Date')
                                                            .doc(
                                                                "GJcwKO67e5219p7jCcxM")
                                                            .update({
                                                          "left_4": (int.parse(doc[
                                                                      "left_4"]) +
                                                                  1)
                                                              .toString()
                                                        });
                                                        myReg = false;
                                                        var firebaseUser =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser;

                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Booking')
                                                            .doc(firebaseUser
                                                                .uid)
                                                            .get()
                                                            .then((ds) {
                                                          ref1
                                                              .doc(firebaseUser
                                                                  .uid)
                                                              .update({
                                                            'reg': myReg
                                                          });
                                                        });
                                                      }
                                                      if (mySlot ==
                                                              "04:00 - 05:00 PM" &&
                                                          myReg == true) {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('Date')
                                                            .doc(
                                                                "GJcwKO67e5219p7jCcxM")
                                                            .update({
                                                          "left_5": (int.parse(doc[
                                                                      "left_5"]) +
                                                                  1)
                                                              .toString()
                                                        });
                                                        myReg = false;
                                                        var firebaseUser =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser;

                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Booking')
                                                            .doc(firebaseUser
                                                                .uid)
                                                            .get()
                                                            .then((ds) {
                                                          ref1
                                                              .doc(firebaseUser
                                                                  .uid)
                                                              .update({
                                                            'reg': myReg
                                                          });
                                                        });
                                                      }
                                                      if (mySlot ==
                                                              "05:00 - 06:00 PM" &&
                                                          myReg == true) {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('Date')
                                                            .doc(
                                                                "GJcwKO67e5219p7jCcxM")
                                                            .update({
                                                          "left_6": (int.parse(doc[
                                                                      "left_6"]) +
                                                                  1)
                                                              .toString()
                                                        });
                                                        myReg = false;
                                                        var firebaseUser =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser;

                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Booking')
                                                            .doc(firebaseUser
                                                                .uid)
                                                            .get()
                                                            .then((ds) {
                                                          ref1
                                                              .doc(firebaseUser
                                                                  .uid)
                                                              .update({
                                                            'reg': myReg
                                                          });
                                                        });
                                                      }
                                                      if (mySlot ==
                                                              "06:00 - 07:00 PM" &&
                                                          myReg == true) {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('Date')
                                                            .doc(
                                                                "GJcwKO67e5219p7jCcxM")
                                                            .update({
                                                          "left_7": (int.parse(doc[
                                                                      "left_7"]) +
                                                                  1)
                                                              .toString()
                                                        });
                                                        myReg = false;
                                                        var firebaseUser =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser;

                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Booking')
                                                            .doc(firebaseUser
                                                                .uid)
                                                            .get()
                                                            .then((ds) {
                                                          ref1
                                                              .doc(firebaseUser
                                                                  .uid)
                                                              .update({
                                                            'reg': myReg
                                                          });
                                                        });
                                                      }
                                                      if (mySlot ==
                                                              "07:00 - 08:00 PM" &&
                                                          myReg == true) {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('Date')
                                                            .doc(
                                                                "GJcwKO67e5219p7jCcxM")
                                                            .update({
                                                          "left_8": (int.parse(doc[
                                                                      "left_8"]) +
                                                                  1)
                                                              .toString()
                                                        });
                                                        myReg = false;
                                                        var firebaseUser =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser;

                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Booking')
                                                            .doc(firebaseUser
                                                                .uid)
                                                            .get()
                                                            .then((ds) {
                                                          ref1
                                                              .doc(firebaseUser
                                                                  .uid)
                                                              .update({
                                                            'reg': myReg
                                                          });
                                                        });
                                                      }
                                                      if (mySlot ==
                                                              "08:00 - 09:00 PM" &&
                                                          myReg == true) {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('Date')
                                                            .doc(
                                                                "GJcwKO67e5219p7jCcxM")
                                                            .update({
                                                          "left_9": (int.parse(doc[
                                                                      "left_9"]) +
                                                                  1)
                                                              .toString()
                                                        });
                                                        myReg = false;
                                                        var firebaseUser =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser;

                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Booking')
                                                            .doc(firebaseUser
                                                                .uid)
                                                            .get()
                                                            .then((ds) {
                                                          ref1
                                                              .doc(firebaseUser
                                                                  .uid)
                                                              .update({
                                                            'reg': myReg
                                                          });
                                                        });
                                                      }
                                                    }

                                                    //return true when click on "Yes"
                                                    ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "You don't have any appointment till now. ");
                                        }
                                      }),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                // border: Border.all(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.purple[100],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    icon: Image.asset(
                                        "assets/images/morning.png"),
                                    onPressed: () {},
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Morning slots ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Avenir',
                                        fontWeight: FontWeight.w700),
                                    textScaleFactor: 1.40,
                                  ),
                                ],
                              ),
                            ),
                            Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              direction: Axis.horizontal,
                              children: [
                                _UserField(
                                    "10:00 - 11:00 AM",
                                    "Left " + doc["left_0"],
                                    doc["left_0"],
                                    "left_0",
                                    (int.parse(doc["left_0"]) + 1).toString()),
                                _UserField(
                                    "11:00 - 12:00 PM",
                                    "Left " + doc["left_1"],
                                    doc["left_1"],
                                    "left_1",
                                    (int.parse(doc["left_1"]) + 1).toString()),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                // border: Border.all(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.purple[100],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    icon: Image.asset(
                                        "assets/images/afternoon.png"),
                                    onPressed: () {},
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Afternoon slots ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Avenir',
                                        fontWeight: FontWeight.w700),
                                    textScaleFactor: 1.40,
                                  ),
                                ],
                              ),
                            ),
                            Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                direction: Axis.horizontal,
                                children: [
                                  _UserField(
                                      "01:00 - 02:00 PM",
                                      "Left " + doc["left_2"],
                                      doc["left_2"],
                                      "left_2",
                                      (int.parse(doc["left_2"]) + 1)
                                          .toString()),
                                  _UserField(
                                      "02:00 - 03:00 PM",
                                      "Left " + doc["left_3"],
                                      doc["left_3"],
                                      "left_3",
                                      (int.parse(doc["left_3"]) + 1)
                                          .toString()),
                                  _UserField(
                                      "03:00 - 04:00 PM",
                                      "Left " + doc["left_4"],
                                      doc["left_4"],
                                      "left_4",
                                      (int.parse(doc["left_4"]) + 1)
                                          .toString()),
                                  _UserField(
                                      "04:00 - 05:00 PM",
                                      "Left " + doc["left_5"],
                                      doc["left_5"],
                                      "left_5",
                                      (int.parse(doc["left_5"]) + 1)
                                          .toString()),
                                ]),
                            Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                // border: Border.all(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.purple[100],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    icon: Image.asset(
                                        "assets/images/evening.png"),
                                    onPressed: () {},
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Evening slots ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Avenir',
                                        fontWeight: FontWeight.w700),
                                    textScaleFactor: 1.40,
                                  ),
                                ],
                              ),
                            ),
                            Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                direction: Axis.horizontal,
                                children: [
                                  _UserField(
                                      "05:00 - 06:00 PM",
                                      "Left " + doc["left_6"],
                                      doc["left_6"],
                                      "left_6",
                                      (int.parse(doc["left_6"]) + 1)
                                          .toString()),
                                  _UserField(
                                      "06:00 - 07:00 PM",
                                      "Left " + doc["left_7"],
                                      doc["left_7"],
                                      "left_7",
                                      (int.parse(doc["left_7"]) + 1)
                                          .toString()),
                                  _UserField(
                                      "07:00 - 08:00 PM",
                                      "Left " + doc["left_8"],
                                      doc["left_8"],
                                      "left_8",
                                      (int.parse(doc["left_8"]) + 1)
                                          .toString()),
                                  _UserField(
                                      "08:00 - 09:00 PM",
                                      "Left " + doc["left_9"],
                                      doc["left_9"],
                                      "left_9",
                                      (int.parse(doc["left_9"]) + 1)
                                          .toString()),
                                ]),
                          ],
                        ),
                      );
                    });
              } else {
                return Text("no complain");
              }
            }),
      ),
    );
  }
}
