import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'Screen/login.dart';
import 'package:ecommerce_scan/Utils/sharedpreferences_helper.dart' ;
import 'package:ecommerce_scan/Screen/Show_first_Page.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_scan/ViewModels/cart_functions.dart' ;


void main() {
  runApp(
     StartApp()
   );
}

class StartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (context) => CartFunctions()),
          ],
          child: MaterialApp(
           debugShowCheckedModeBanner: false,
           home: new SplashScreen(),
           routes: <String, WidgetBuilder>{
          //      '/HomeScreen': (BuildContext context) => new HomeScreen()
          '/login': (BuildContext context) => new login()
           },
       ),
      ) ;
  }
}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool _loggedIn = false ;

  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Route route = _loggedIn ? MaterialPageRoute(builder: (context) => Show_first()) : MaterialPageRoute(builder: (context) => login());
    Navigator.pushReplacement(context, route);
  }

  @override
  void initState() {
    super.initState();
    startTime();
    checkLoggedinOrNot();
  }

  checkLoggedinOrNot() async  {
    bool isKey = await SharedPreferencesHelper.checkKey('useremail') ;

    if(isKey){
      String isLoggedIn = await SharedPreferencesHelper.getUseremail() ;
      if(isLoggedIn != null) {
        _loggedIn = true ;
      }
    }

    else {
      _loggedIn = false ;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    return
      Scaffold(
        body: new Center(
          child: Container(
              width: 500.0,
              height: 500.0,
              child: new Center(
                  widthFactor: 24.0,
                  heightFactor: 24.0,
                  child: new Image.asset('images/splash_logo.png',
                      width: 240.0, height: 240.0))),
        ),
      );
  }
}



/*flutter_icons:
image_path: "images/appicon/ecomm_logo3.png"
android: true
ios: true
adaptive_icon_background: "#ffffff"
adaptive_icon_foreground: "images/appicon/ecomm_logo3.png"*/
