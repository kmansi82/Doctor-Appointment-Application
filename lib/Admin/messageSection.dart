import 'package:flutter/material.dart';
import 'package:health_care/User/Users.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:health_care/utils/Colors.dart';

import 'package:health_care/widgets/ButtonWidget.dart';

import 'navigation_admin.dart';

class messageSection extends StatefulWidget {
  @override
  _messageSectionState createState() => _messageSectionState();
}

class _messageSectionState extends State<messageSection> {
  String _msg;
  final _formKey = GlobalKey<FormState>();

  void validate() {
    if (_formKey.currentState.validate()) {
      Messagge().storeNewUser(context, _msg);
      Fluttertoast.showToast(msg: "successfully submitted");
    } else {
      Fluttertoast.showToast(msg: "Enter Message");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //new line

      appBar: AppBar(
        backgroundColor: orangeLightColors,
        title: Text('Your Message'),
      ),
      drawer: navigationAdmin(),
      body: Container(
        padding: EdgeInsets.only(bottom: 30),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Message",
                              prefixIcon: Icon(Icons.message),
                            ),
                            validator: (val) => val.length < 0
                                ? 'Enter message to show patients'
                                : null,
                            onChanged: (value) => setState(() {
                              _msg = value;
                            }),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: ButtonWidget(
                              btnText: "SUBMIT",
                              onClick: () {
                                validate();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
