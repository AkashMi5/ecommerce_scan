import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_scan/Utils/Constants.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rich_alert/rich_alert.dart';
import 'package:toast/toast.dart';

class Feedback_page extends StatefulWidget {
  Feedback_page({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Feedbackstate createState() => new Feedbackstate();
}

class Feedbackstate extends State<Feedback_page> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController feedbackTextController = TextEditingController();
  ProgressDialog pr;
  bool feedbackSubmitted = false ;

  @override
  Widget build(BuildContext context) {
    final feedback = new Container(
        child: TextField(
      maxLines: 5,
      controller: feedbackTextController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          hintText: "Write Your Feedback Here....",
          hintMaxLines: 1,
          focusColor: Colors.black,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
    ));

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.orange,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          if (feedbackTextController.text == "" || feedbackTextController.text == null) {
            feedbackSubmitted = false ;
            FocusScope.of(context).unfocus();
            setState(() {
            });
            Toast.show("Write feedback before submitting.", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          } else {
             feedbackSubmitted = false ;
             setState(() {
             });
            Callapi();
          }
        },
        child: Text("Submit",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text("Feedback",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              feedback,
              Expanded(
                child: SizedBox(
                  height: 15.0,
                ),
                flex: 3,
              ),

              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: feedbackTextController.text.isEmpty && feedbackSubmitted ? Text("Feedback submitted successfully!",
                          style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.bold
                      ),
                  ) : Text(""),
                ),
              ),
              loginButon,
              Expanded(
                child: SizedBox(
                  height: 15.0,
                ),
                flex:12,
              ),
            ],
          ),
        ),
      ),
    );
  }

//  onWillPop: () {
//  _onWillPop();
//  },

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

  Future<void> Callapi() async {

    FocusScope.of(context).unfocus();

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

    String feedback = feedbackTextController.text;
    Toast.show(feedback, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    print(feedback);
    if (!feedback.isEmpty) {
      var name;
      var status;
      var url = Constants.FEEDBACK;
      var response = await post(url, body: {
        'feedback': feedbackTextController.text,
        'userid': "3",
      });
      var parsedJson = json.decode(response.body);
      print('Response status: ${parsedJson}');
      name = parsedJson['message'];
      status = parsedJson['status'];
      if (status == "true") {
        pr.hide();
        feedbackTextController.clear() ;
        feedbackSubmitted = true ;
        setState(() {
        });
        Toast.show("Feedback submitted successfully", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      } else {
        pr.hide();
        feedbackTextController.clear() ;
        feedbackSubmitted = true ;
        setState(() {
        });
        Toast.show("Error while submitting, try again!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      }
    } else {
   //   showdialog();
      pr.hide();
      Toast.show("No feedback provided.", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    }
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Confirm Exit?',
                style: new TextStyle(color: Colors.black, fontSize: 20.0)),
            content: new Text(
                'Are you sure you want to exit the app? Tap \'Yes\' to exit \'No\' to cancel.'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  // this line exits the app.
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                child: new Text('Yes', style: new TextStyle(fontSize: 18.0)),
              ),
              new FlatButton(
                onPressed: () => Navigator.pop(context),
                // this line dismisses the dialog
                child: new Text('No', style: new TextStyle(fontSize: 18.0)),
              )
            ],
          ),
        ) ??
        false;
  }
}
