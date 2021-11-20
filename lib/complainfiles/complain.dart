import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_care/utils/Colors.dart';
import 'package:health_care/utils/loading.dart';

class ViewComplainsWater extends StatefulWidget {
  @override
  _ViewComplainsWaterState createState() => _ViewComplainsWaterState();
}

class _ViewComplainsWaterState extends State<ViewComplainsWater> {
  final double _borderRadius = 15;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  CollectionReference ref = FirebaseFirestore.instance.collection('Booked Complain');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orangeLightColors,
        title: Text("Your Appointments"),
      ),
      body: StreamBuilder(
          stream: ref
              .doc(firebaseUser.uid)
            
              .collection('Booked Complain')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 125,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(_borderRadius),
                              gradient: LinearGradient(
                                colors: [myContainer, myContainer],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 3,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                          ),
                          Positioned.fill(
                            child: Row(
                              children: <Widget>[
                                // Expanded(
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(8.0),
                                //     child: Image.network(
                                //       snapshot.data.docs[index]["img"],
                                //       height: 100,
                                //       width: 100,
                                //     ),
                                //   ),
                                //   flex: 6,
                                // ),
                                Expanded(
                                  flex: 11,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "Date : " +
                                            snapshot.data.docs[index]["date"],
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                          fontFamily: 'Avenir',
                                        ),
                                        textScaleFactor: 1.4,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Name : " +
                                            snapshot.data.docs[index]["name"],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Avenir',
                                        ),
                                        textScaleFactor: 1.1,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Text(
                                            "Timeslot : " +
                                                snapshot.data.docs[index]
                                                    ["timeslot"],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Avenir',
                                            ),
                                            textScaleFactor: 1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              Loading();
              return Text("No complains");
            }
          }),
    );
  }
}
