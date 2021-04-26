import 'package:flutter/material.dart';
import 'package:ecommerce_scan/Screen/FAQ.dart';
// import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';
import 'Feedback.dart';
import 'Previous_Order.dart';
import 'login.dart' ;
import 'package:ecommerce_scan/Utils/sharedpreferences_helper.dart' ;

class Profile extends StatefulWidget {
  Profile({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Profilestate createState() => new Profilestate();
}

class Profilestate extends State<Profile> {
  String _myImage = "images/back.png";
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  String _dialogTitle = 'Alert';
  String _dialogDesc = 'Do you want to log out?';
  String _dialogButtonText = 'Okay';

  _showDialog() {
    // return object of type Dialog
    return showDialog(
      context: context,
      builder: (BuildContext context) =>
          CustomDialog(
            title: "$_dialogTitle",
            description:
            "$_dialogDesc",
            buttonText: "$_dialogButtonText",
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Previous = Material(
      elevation: 0.5,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white70,
      child: Row(
        children: <Widget>[
          Expanded(
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: () {
                Route route =
                    MaterialPageRoute(builder: (context) => Previous_order());
                Navigator.push(context, route);
              },
              child: Text(
                  "Previous Orders                                              ",
                  textAlign: TextAlign.start,
                  style: style.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            flex: 100,
          ),
          Expanded(
            child: SizedBox(
              height: 24.0,
              child: Image.asset(
                "images/black_arrow.png",
                fit: BoxFit.contain,
              ),
            ),
            flex: 10,
          ),
        ],
      ),
    );
    final Feedback = Material(
      elevation: 0.5,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white70,
      child: Row(
        children: <Widget>[
          Expanded(
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: () {
                Route route =
                    MaterialPageRoute(builder: (context) => Feedback_page());
                Navigator.push(context, route);
              },
              child: Text(
                  "Feedback                                                       ",
                  textAlign: TextAlign.start,
                  style: style.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            flex: 100,
          ),
          Expanded(
            child: SizedBox(
              height: 24.0,
              child: Image.asset(
                "images/black_arrow.png",
                fit: BoxFit.contain,
              ),
            ),
            flex: 10,
          ),
        ],
      ),
    );
    final FAQ = Material(
      elevation: 0.5,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white70,
      child: Row(
        children: <Widget>[
          Expanded(
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: () {
                Route route = MaterialPageRoute(builder: (context) => FAQClass());
                Navigator.push(context, route);
              },
              child: Text(
                  "FAQ                                                                 ",
                  textAlign: TextAlign.start,
                  style: style.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            flex: 100,
          ),
          Expanded(
            child: SizedBox(
              height: 24.0,
              child: Image.asset(
                "images/black_arrow.png",
                fit: BoxFit.contain,
              ),
            ),
            flex: 10,
          ),
        ],
      ),
    );
    final AccountSetting = Material(
      elevation: 0.5,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white70,
      child: Row(
        children: <Widget>[
          Expanded(
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: () {},
              child: Text(
                  "Account Setting                                                  ",
                  textAlign: TextAlign.start,
                  style: style.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            flex: 100,
          ),
          Expanded(
            child: SizedBox(
              height: 24.0,
              child: Image.asset(
                "images/black_arrow.png",
                fit: BoxFit.contain,
              ),
            ),
            flex: 10,
          ),
        ],
      ),
    );
    final Logout = Material(
      elevation: 0.5,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white70,
      child: Row(
        children: <Widget>[
          Expanded(
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: () {
                _showDialog() ;
//                _onClicked();
          //      dialog();
              },
              child: Text(
                  "Logout                                                         ",
                  textAlign: TextAlign.left,
                  style: style.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            flex: 130,
          ),
          Expanded(
            child: SizedBox(
              height: 24.0,
              child: Image.asset(
                "images/black_arrow.png",
                fit: BoxFit.contain,
              ),
            ),
            flex: 20,
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text("Account",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(        
            color: Colors.white,
            child: Padding(
//            padding: const EdgeInsets.all(36.0),
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  /*   Row(
                    children: <Widget>[
                      Expanded(
                        child:Material(
                           color: Colors.white,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                child: ClipRRect(
//                                borderRadius: BorderRadius.circular(20.0),
                                  child: Image.asset("images/back.png"),
                                  */ /*width: 110.0, height: 110.0*/ /*

                                ),),
                            )
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 30.0, 0.0),
                          child: Text("Account",
                              textAlign: TextAlign.center,
                              style: style.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                        flex: 15,
                      )
                    ],
                  ),*/
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                    child: SizedBox(
                      height: 125.0,
                      child: Image.asset(
                        "images/man.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Akash Mittal",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "akash.mittal@gmail.com",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "+91-8890521079",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Previous,
                  SizedBox(height: 5),
                  Feedback,
                  SizedBox(height: 5),
                  FAQ,
                  SizedBox(height: 5),
               //   AccountSetting,
               //   SizedBox(height: 5),
                  Logout,
                  SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onClicked() {
    setState(() {
      if (_myImage == "images/back.png") {
        _myImage = "images/star.png"; //change myImage to the other one
      } else {
        _myImage = "images/back.png"; //change myImage back to the original one
      }
    });
  }

 /* void dialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Center(
              child: RichAlertDialog(
                alertTitle: richTitle("Alert"),
                alertSubtitle:
                    richSubtitle("Do you want to logout?"),
                alertType: RichAlertType.WARNING,
                actions: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: FlatButton(
                        minWidth: 50,
                        color: Colors.grey,
                        child: Text("Yes"),
                        onPressed: () async {
                          await SharedPreferencesHelper.clearSP();
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => login()), (Route<dynamic> route) => false,);
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: FlatButton(
                        minWidth: 50,
                        color: Colors.grey,
                        child: Text("No"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
    *//*showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return PlatformAlertDialog(
          title: Center(child: Text('Alert')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(child: Text('Are you sure')),
                Center(child: Text('Do you want to logout')),
              ],
            ),
          ),
          actions: <Widget>[
            PlatformDialogAction(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            PlatformDialogAction(
              child: Text('Logout'),
              actionType: ActionType.Preferred,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );*//*
  }*/
}


class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;


  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.image,
  });


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }


  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container (
          padding: EdgeInsets.only(
            top:  Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 20.0,
                offset: const Offset(0.0, 20.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 36.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.black87,
                    onPressed: () async {
                      await SharedPreferencesHelper.clearSP();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => login()), (Route<dynamic> route) => false); // To close the dialog
                    },
                    child: Text("Yes",
                        style: TextStyle(
                            color: Colors.white
                        )
                    ),
                  ),

                  FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.black87,
                    onPressed: () {
                      Navigator.of(context).pop(); // To close the dialog
                    },
                    child: Text("No",
                        style: TextStyle(
                            color: Colors.white
                        )
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),



        /*   Positioned(
          left: 1,
          right:1,
          child: CircleAvatar(
            child: ClipRRect(
              borderRadius:BorderRadius.circular(Consts.avatarRadius) ,                    // BorderRadius.circular(50),
              child: Image.asset("images/quizlogo2.png"),
            ),
            //  backgroundImage: AssetImage('images/quizlogo2.png'),
            // backgroundColor: Colors.blueAccent,
            radius: Consts.avatarRadius,
          ),
        ),*/


      ],
    );
  }



}

class Consts {
  Consts._();

  static const double padding = 20.0;
  static const double avatarRadius = 40.0;
}
