import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_care/utils/Colors.dart';

import 'navigation_admin.dart';

class Solved extends StatefulWidget {
  @override
  _SolvedState createState() => _SolvedState();
}

class _SolvedState extends State<Solved> {
  CollectionReference ref =
      FirebaseFirestore.instance.collection('Solved appointments');
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orangeLightColors,
        title: Text(" All Solved Appointments"),
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
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          gradient: LinearGradient(
                            colors: [myContainer, myContainer],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 7,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Name: " + doc["name"],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Avenir',
                                  fontWeight: FontWeight.w700),
                              textScaleFactor: 1.1,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Address: " + doc["address"],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Avenir',
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Date: " + doc["date"],
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontFamily: 'Avenir',
                                        fontWeight: FontWeight.w700)),
                              ],
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) {
                                return Theme(
                                    data: Theme.of(context).copyWith(
                                        dialogBackgroundColor: Colors.white),
                                    child: Dialog(
                                      backgroundColor: dialougeColor,
                                      insetPadding: EdgeInsets.all(15),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          child: ListView(
                                            shrinkWrap: true,
                                            children: <Widget>[
                                              InkWell(
                                                child: Container(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Icon(
                                                      Icons.cancel,
                                                      size: 30,
                                                    )),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                      child: Text("Name: ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  Text(
                                                    snapshot.data.docs[index]
                                                        ["name"],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Avenir',
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                child: Divider(
                                                  color: Colors.black,
                                                  height: 10,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                      child: Text("Date: ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  Text(
                                                    snapshot.data.docs[index]
                                                        ["date"],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Avenir',
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                child: Divider(
                                                  color: Colors.black,
                                                  height: 10,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                      child: Text("Time Slot: ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  Text(
                                                    snapshot.data.docs[index]
                                                        ["timeslot"],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Avenir',
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                child: Divider(
                                                  color: Colors.black,
                                                  height: 10,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                      child: Text("Mobile No: ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  Text(
                                                    snapshot.data.docs[index]
                                                        ["mob"],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Avenir',
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                child: Divider(
                                                  color: Colors.black,
                                                  height: 10,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                      child: Text("Age: ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  Text(
                                                    snapshot.data.docs[index]
                                                        ["age"],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Avenir',
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                child: Divider(
                                                  color: Colors.black,
                                                  height: 10,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                      child: Text("Gender: ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  Text(
                                                    snapshot.data.docs[index]
                                                        ["gender"],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                child: Divider(
                                                  color: Colors.black,
                                                  height: 10,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                  child: Text("Address: ",
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontWeight: FontWeight
                                                              .bold))),
                                              Text(
                                                snapshot.data.docs[index]
                                                    ["address"],
                                                maxLines: 5,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Avenir',
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                              },
                            );
                          },
                        ),
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
