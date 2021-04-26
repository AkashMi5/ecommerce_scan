import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ecommerce_scan/Utils/Constants.dart';
import 'package:http/http.dart';
import 'package:toast/toast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:ecommerce_scan/Utils/sharedpreferences_helper.dart' ;
import 'package:ecommerce_scan/Screen/Show_first_Page.dart';

import 'login.dart';

class Registration extends StatefulWidget {
  Registration({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Registrationstate createState() => new Registrationstate();
}

class Registrationstate extends State<Registration> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _emialTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _name = TextEditingController();
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    final namefield = TextField(
      controller: _name,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Name",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      keyboardType: TextInputType.text,
    );

    final emailField = TextField(
      controller: _emialTextController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      keyboardType: TextInputType.emailAddress,
    );
    final passwordField = TextField(
      controller: _passwordTextController,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      keyboardType: TextInputType.visiblePassword,
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
//      color: Color(0xff01A0C7),
      color: Colors.orange,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Regis_api();
        },
        child: Text("Sign Up",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 140.0,
                    child: Image.asset(
                      "images/splash_logo.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 45.0,
                  ),
                  namefield,
                  SizedBox(height: 20.0),
                  emailField,
                  SizedBox(height: 20.0),
                  passwordField,
                  SizedBox(
                    height: 30.0,
                  ),
                  loginButon,
                  SizedBox(
                    width: 10.0,
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Already have an account?",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Sign In",
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange),
                          )),
                    ],
                  ),

                  /*  BackButtonIcon,
                  SizedBox(
                    width: 10.0,
                    height: 15.0,
                  )*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> Regis_api() async {
    pr = new ProgressDialog(context);
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    pr.style(
        message: 'Please Wait...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    pr.show();

    String name = _emialTextController.text;
    Toast.show(name, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

    print(_emialTextController.text);
    if (!_name.text.isEmpty) {
      if (!_emialTextController.text.isEmpty) {
        if (!_passwordTextController.text.isEmpty) {
          var name;
          var status;
          var url = Constants.REGISTRATION;
          var response = await post(url, body: {
            'name': _name.text,
            'email': _emialTextController.text,
            'password': _passwordTextController.text
          });
          var parsedJson = json.decode(response.body);
          print('Response status: ${parsedJson}');
          name = parsedJson['message'];
          status = parsedJson['status'];
          if (status == "true") {
            pr.hide();
            Toast.show("Registration Sucessfully", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
            SharedPreferencesHelper.setUseremail(_emialTextController.text) ;
            Route route = MaterialPageRoute(builder: (context) => Show_first());
            Navigator.pushReplacement(context, route);
          } else {
            pr.hide();
            Toast.show("Login Failed.", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
          }
        } else {
          pr.hide();
          Toast.show("Please enter password.", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
        }
      } else {
        pr.hide();
        Toast.show("Please enter email id.", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
      }
    } else {
      pr.hide();
      Toast.show("Please enter Name.", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    }
  }
}
