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

double spinner = 0;
double spinner1 = 0;
double spinner2 = 0;
double spinner3 = 0;
double spinner4 = 0;
double spinner5 = 0;
double spinner6 = 0;
double spinner7 = 0;
double spinner8 = 0;
double spinner9 = 0;

class appointment extends StatefulWidget {
  @override
  _appointmentState createState() => _appointmentState();
}

CollectionReference ref = FirebaseFirestore.instance.collection('Date');

class _appointmentState extends State<appointment> {
  CollectionReference ref = FirebaseFirestore.instance.collection('Date');

  String userleft1;
  String count;
  DatePickerController _controller = DatePickerController();

  @override
  void initState() {
    super.initState();
  }

  _buildTextField(String text, Container c, String db, String docstr,
      String strr, double sp) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.all(12.0),
                padding: EdgeInsets.all(0),
                child: Text(text),
              ),
              SizedBox(
                width: 10,
              ),
              c,
              Container(
                child: Text(
                  db,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Avenir',
                      fontWeight: FontWeight.w700),
                  textScaleFactor: 1.1,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              // Transform.scale(
              //   scale: 0.7,
              //   child: IconButton(
              //       icon: Image.asset("assets/images/done.png"),
              //       color: Colors.white,
              //       onPressed: () {
              //         return showDialog<void>(
              //           context: context,
              //           barrierDismissible: false, // user must tap button!
              //           builder: (BuildContext context) {
              //             return AlertDialog(
              //               title: Text('Are you sure you ?'),
              //               actions: <Widget>[
              //                 TextButton(
              //                   child: Text('Done'),
              //                   onPressed: () {
              //                     ref.doc(docstr).update({
              //                       strr: sp.round().toString(),
              //                     }).then(
              //                         (value) => Navigator.of(context).pop());
              //                   },
              //                 ),
              //                 TextButton(
              //                   child: Text('Cancel'),
              //                   onPressed: () {
              //                     Navigator.of(context).pop();
              //                   },
              //                 ),
              //               ],
              //             );
              //           },
              //         );
              //       }),
              // ),
            ],
          ),
        ),
        Transform.scale(
          scale: 0.8,
          child: IconButton(
              icon: Image.asset("assets/images/done.png"),
              color: Colors.white,
              onPressed: () {
                return showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Are you sure about the number of patient you want to take ?'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Done'),
                          onPressed: () {
                            ref.doc(docstr).update({
                              strr: sp.round().toString(),
                            }).then((value) => Navigator.of(context).pop());
                          },
                        ),
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }),
        )
      ],
    );
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
                        children: [
                          Container(
                            child: DatePicker(
                              DateTime.now(),
                              width: 60,
                              height: 80,
                              controller: _controller,
                              initialSelectedDate: DateTime.now(),
                              selectionColor: Colors.black,
                              selectedTextColor: Colors.white,
                              inactiveDates: [
                                DateTime.now().add(Duration(days: 3)),
                                DateTime.now().add(Duration(days: 2)),
                                DateTime.now().add(Duration(days: 7))
                              ],
                            ),
                          ),
                          // InkWell(
                          //   child: Container(
                          //     padding: EdgeInsets.all(0),
                          //     margin: EdgeInsets.all(12.0),
                          //     decoration: BoxDecoration(
                          //       border:
                          //           Border.all(color: Colors.black, width: 3),
                          //       borderRadius: BorderRadius.circular(8),
                          //     ),
                          //     child: Row(
                          //       children: [
                          //         Container(
                          //           margin: EdgeInsets.all(12.0),
                          //           padding: EdgeInsets.all(0),
                          //           child: Text("10:00 -12:00 AM"),
                          //         ),
                          //         SizedBox(
                          //           width: 10,
                          //         ),
                          //         Container(
                          //           margin: EdgeInsets.all(20),
                          //           child: SpinnerInput(
                          //             spinnerValue: spinner3,
                          //             minValue: 0,
                          //             maxValue: 7,
                          //             onChange: (newValue) {
                          //               setState(() {
                          //                 spinner3 = newValue;
                          //               });
                          //             },
                          //           ),
                          //         ),
                          //         Container(
                          //           // child: Text(
                          //           //     /*count.toString()+ */ spinner3
                          //           //             .round()
                          //           //             .toString() +
                          //           //         " Left"),
                          //           child: Text(
                          //             "Left " + doc["left_1"],
                          //             style: TextStyle(
                          //                 color: Colors.black,
                          //                 fontFamily: 'Avenir',
                          //                 fontWeight: FontWeight.w700),
                          //             textScaleFactor: 1.1,
                          //           ),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          //   onTap: () {
                          //     return showDialog<void>(
                          //       context: context,
                          //       barrierDismissible:
                          //           false, // user must tap button!
                          //       builder: (BuildContext context) {
                          //         return AlertDialog(
                          //           title: Text('Are you sure you ?'),
                          //           actions: <Widget>[
                          //             TextButton(
                          //               child: Text('Done'),
                          //               onPressed: () {
                          //                 ref
                          //                     .doc("GJcwKO67e5219p7jCcxM")
                          //                     .update({
                          //                   'left_1':
                          //                       spinner3.round().toString(),
                          //                 });
                          //                 if (spinner3 > 0) {
                          //                   FirebaseFirestore.instance
                          //                       .collection('Date')
                          //                       .doc("GJcwKO67e5219p7jCcxM")
                          //                       .update({
                          //                     'left_1':
                          //                         spinner3.round().toString(),
                          //                   }).then((value) => Navigator.push(
                          //                           context,
                          //                           MaterialPageRoute(
                          //                               builder: (context) =>
                          //                                   appointment())));
                          //                   Fluttertoast.showToast(
                          //                       msg: spinner3
                          //                               .round()
                          //                               .toString() +
                          //                           " Left");
                          //                 }
                          //                 if (spinner3 == 0) {
                          //                   Navigator.push(
                          //                       context,
                          //                       MaterialPageRoute(
                          //                           builder: (context) =>
                          //                               appointment()));
                          //                   Fluttertoast.showToast(
                          //                       msg:
                          //                           "No More slot is Avilable");
                          //                 }
                          //               },
                          //             ),
                          //             TextButton(
                          //               child: Text('Cancel'),
                          //               onPressed: () {
                          //                 Navigator.of(context).pop();
                          //               },
                          //             ),
                          //           ],
                          //         );
                          //       },
                          //     );
                          //   },
                          // ),
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
                                        "assets/images/morning.png"), onPressed: () {  },),
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
                          _buildTextField(
                              "10:00 - 11:00 AM",
                              Container(
                                margin: EdgeInsets.all(20),
                                child: SpinnerInput(
                                  spinnerValue: spinner,
                                  minValue: 0,
                                  maxValue: 20,
                                  onChange: (newValue) {
                                    setState(() {
                                      spinner = newValue;
                                    });
                                  },
                                ),
                              ),
                              "Left " + doc["left_0"],
                              "GJcwKO67e5219p7jCcxM",
                              'left_0',
                              spinner),

                          _buildTextField(
                              "11:00 - 12:00 PM",
                              Container(
                                margin: EdgeInsets.all(20),
                                child: SpinnerInput(
                                  spinnerValue: spinner1,
                                  minValue: 0,
                                  maxValue: 20,
                                  onChange: (newValue) {
                                    setState(() {
                                      spinner1 = newValue;
                                    });
                                  },
                                ),
                              ),
                              "Left " + doc["left_1"],
                              "GJcwKO67e5219p7jCcxM",
                              'left_1',
                              spinner1),
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
                                        "assets/images/afternoon.png"), onPressed: () {  },),
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
                          _buildTextField(
                              "01:00 - 02:00 PM",
                              Container(
                                margin: EdgeInsets.all(20),
                                child: SpinnerInput(
                                  spinnerValue: spinner2,
                                  minValue: 0,
                                  maxValue: 20,
                                  onChange: (newValue) {
                                    setState(() {
                                      spinner2 = newValue;
                                    });
                                  },
                                ),
                              ),
                              "Left " + doc["left_2"],
                              "GJcwKO67e5219p7jCcxM",
                              'left_2',
                              spinner2),
                          _buildTextField(
                              "02:00 - 03:00 PM",
                              Container(
                                margin: EdgeInsets.all(20),
                                child: SpinnerInput(
                                  spinnerValue: spinner3,
                                  minValue: 0,
                                  maxValue: 20,
                                  onChange: (newValue) {
                                    setState(() {
                                      spinner3 = newValue;
                                    });
                                  },
                                ),
                              ),
                              "Left " + doc["left_3"],
                              "GJcwKO67e5219p7jCcxM",
                              'left_3',
                              spinner3),
                          _buildTextField(
                              "03:00 - 04:00 PM",
                              Container(
                                margin: EdgeInsets.all(20),
                                child: SpinnerInput(
                                  spinnerValue: spinner4,
                                  minValue: 0,
                                  maxValue: 20,
                                  onChange: (newValue) {
                                    setState(() {
                                      spinner4 = newValue;
                                    });
                                  },
                                ),
                              ),
                              "Left " + doc["left_4"],
                              "GJcwKO67e5219p7jCcxM",
                              'left_4',
                              spinner4),
                          _buildTextField(
                              "04:00 - 05:00 PM",
                              Container(
                                margin: EdgeInsets.all(20),
                                child: SpinnerInput(
                                  spinnerValue: spinner5,
                                  minValue: 0,
                                  maxValue: 20,
                                  onChange: (newValue) {
                                    setState(() {
                                      spinner5 = newValue;
                                    });
                                  },
                                ),
                              ),
                              "Left " + doc["left_5"],
                              "GJcwKO67e5219p7jCcxM",
                              'left_5',
                              spinner5),
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
                                        "assets/images/evening.png"), onPressed: () {  },),
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
                          _buildTextField(
                              "05:00 - 06:00 PM",
                              Container(
                                margin: EdgeInsets.all(20),
                                child: SpinnerInput(
                                  spinnerValue: spinner6,
                                  minValue: 0,
                                  maxValue: 20,
                                  onChange: (newValue) {
                                    setState(() {
                                      spinner6 = newValue;
                                    });
                                  },
                                ),
                              ),
                              "Left " + doc["left_6"],
                              "GJcwKO67e5219p7jCcxM",
                              'left_6',
                              spinner6),
                          _buildTextField(
                              "06:00 - 07:00 PM",
                              Container(
                                margin: EdgeInsets.all(20),
                                child: SpinnerInput(
                                  spinnerValue: spinner7,
                                  minValue: 0,
                                  maxValue: 20,
                                  onChange: (newValue) {
                                    setState(() {
                                      spinner7 = newValue;
                                    });
                                  },
                                ),
                              ),
                              "Left " + doc["left_7"],
                              "GJcwKO67e5219p7jCcxM",
                              'left_7',
                              spinner7),
                          _buildTextField(
                              "07:00 - 08:00 PM",
                              Container(
                                margin: EdgeInsets.all(20),
                                child: SpinnerInput(
                                  spinnerValue: spinner8,
                                  minValue: 0,
                                  maxValue: 20,
                                  onChange: (newValue) {
                                    setState(() {
                                      spinner8 = newValue;
                                    });
                                  },
                                ),
                              ),
                              "Left " + doc["left_8"],
                              "GJcwKO67e5219p7jCcxM",
                              'left_8',
                              spinner8),
                          _buildTextField(
                              "08:00 - 09:00 PM",
                              Container(
                                margin: EdgeInsets.all(20),
                                child: SpinnerInput(
                                  spinnerValue: spinner9,
                                  minValue: 0,
                                  maxValue: 20,
                                  onChange: (newValue) {
                                    setState(() {
                                      spinner9 = newValue;
                                    });
                                  },
                                ),
                              ),
                              "Left " + doc["left_9"],
                              "GJcwKO67e5219p7jCcxM",
                              'left_9',
                              spinner9),
                        ],
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
