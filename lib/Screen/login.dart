import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:ecommerce_scan/Screen/Show_first_Page.dart';
import 'package:ecommerce_scan/Utils/Constants.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rich_alert/rich_alert.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Registration.dart';
import 'package:ecommerce_scan/Utils/sharedpreferences_helper.dart' ;
import 'package:ecommerce_scan/models/user_login.dart' ;


class login extends StatefulWidget {
  login({Key key, this.title}) : super(key: key);
  final String title;

  @override
  loginstate createState() => new loginstate();
}



class loginstate extends State<login> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _emialTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  ProgressDialog pr;

//  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      controller: _emialTextController,
      obscureText: false,
//      enabled: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
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
      textInputAction: TextInputAction.done,

//      inputFormatters: <TextInputFormatter>[
//        WhitelistingTextInputFormatter.digitsOnly
//      ],
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.orange,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          loginapi();
        },
        child: Text("Sign In",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "images/splash_logo.png",
                    height: 220,
                    width: 180,
                  ),
                  emailField,
                  SizedBox(height: 15.0),
                  passwordField,
                  SizedBox(
                    height: 2.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                          onPressed: () {
                            Toast.show("Forgot Password?", context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
                            /* Route route = MaterialPageRoute(
                                                                builder: (context) => Permission_check());
                                                            Navigator.push(context, route);*/
                          },
                          child: Text(
                            "Forgot Password?",
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )),
                    ],
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
                        "Don't have account?",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      FlatButton(
                          onPressed: () {
                            Route route = MaterialPageRoute(
                                builder: (context) => Registration());
                            Navigator.pushReplacement(context, route);
                          },
                          child: Text(
                            "Sign Up",
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Divider(
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                      FlatButton(
                          onPressed: () {
                           /* Route route = MaterialPageRoute(
                                builder: (context) => Registration());
                            Navigator.pushReplacement(context, route);*/
                          },
                          child: Text(
                            "OR",
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Divider(
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      color: Colors.indigo,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 30.0,
                            child: Image.asset(
                              "images/fb_logo.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          FlatButton(
                              onPressed: () {},
                              child: Text(
                                "Sign in with Facebook",
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Container(
                      color: Colors.redAccent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                            child: Image.asset(
                              "images/google_logo.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          FlatButton(
                              onPressed: () {
                              /*  Route route = MaterialPageRoute(
                                  //                                  builder: (context) => home_barcode());
                                    builder: (context) => Show_first());
                                Navigator.push(context, route);*/
                              },
                              child: Text(
                                "Sign in with Google",
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginapi() async {
//    prefs = SharedPreferences.getInstance() as SharedPreferences;
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
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    print(_emialTextController.text);
    if (!_emialTextController.text.isEmpty) {
      if (!_passwordTextController.text.isEmpty) {
        var name;
        var status;
        var url = Constants.LOGIN;
        var response = await post(url, body: {
          'email': _emialTextController.text,
          'password': _passwordTextController.text
        });
        var parsedJson = json.decode(response.body);
        print('Response status: ${parsedJson}');
        name = parsedJson['message'];
        status = parsedJson['status'];
        if (status == "true") {
          pr.hide();

          UserLogin _userLogin ;
          _userLogin = UserLogin.fromJson(parsedJson['data']) ;

          SharedPreferencesHelper.setUseremail(_userLogin.email) ;
          Toast.show("Login Successfully", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
          Route route = MaterialPageRoute(builder: (context) => Show_first());
          Navigator.pushReplacement(context, route);
        } else {
          pr.hide();
          Toast.show("Login Failed.", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
        }
      } else {
        showdialog();
        pr.hide();
        Toast.show("Please enter password.", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      }
    } else {
      showdialog();
      pr.hide();
      Toast.show("Please enter email id.", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    }
  }

  void showdialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return RichAlertDialog(
            alertTitle: richTitle("Alert title"),
            alertSubtitle: richSubtitle("Subtitle"),
            alertType: RichAlertType.WARNING,
          );
        });
  }
}
