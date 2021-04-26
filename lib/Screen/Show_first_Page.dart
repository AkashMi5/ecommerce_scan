
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_scan/Screen/Profile.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:toast/toast.dart';

import 'home_screen.dart';

class Show_first extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Show_first1(),
      ),
    );
  }
}

class Show_first1 extends StatelessWidget {
  Show_first1({Key key, this.title}) : super(key: key);
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final String title;
  final String Item_Image = "images/demo_store.png";
  final String Item_Price = "3";
  final String Increment_Number = "1";

  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        Center(
          child: Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
              child: ListTile(
                leading: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                      child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              Route route = MaterialPageRoute(
                                  builder: (context) => Profile());
                              Navigator.pushReplacement(context, route);
                            },
                            child: Container(
                              child: ClipRRect(
                                child: Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 0.0, 75.0, 0.0),
                                  child: Image.asset("images/man.png"),
                                ),
                                /*width: 110.0, height: 110.0*/
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
                onTap: () {
                  Toast.show("big bazar", context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                },
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: ListTile(
                leading: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                      child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              child: ClipRRect(
                                child: Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 0.0, 75.0, 0.0),
                                  child: Text(
                                    "Nearby stores",
                                    textAlign: TextAlign.start,
                                    style: style.copyWith(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30.0),
                                  ),
                                ),
                                /*width: 110.0, height: 110.0*/
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
                onTap: () {
                  Toast.show("big bazar", context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                },
              ),
            ),
          ),
        ),
        Divider(),
        Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Padding(
                  padding: EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
                  child: Text("big bazar"),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.fromLTRB(51.0, 0.0, 0.0, 0.0),
                  child: Text("4.5km"),
                ),
                leading: SizedBox(
                  height: 22,
                  child: Material(
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          child: ClipRRect(
                            child: Image.asset("images/big_bazar.png"),
                            /*width: 110.0, height: 110.0*/
                          ),
                        ),
                      )),
                ),
                onTap: () {
                  Toast.show("big bazar", context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                },
              ),
            ),
          ),
        ),
        Divider(),
        Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: ListTile(
              title: Padding(
                padding: EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
                child: Text("National handloom"),
              ),
              subtitle: Padding(
                padding: EdgeInsets.fromLTRB(51.0, 0.0, 0.0, 0.0),
                child: Text("4.5km"),
              ),
              leading: SizedBox(
                height: 25,
                child: Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        child: ClipRRect(
                          child: Image.asset("images/national.png"),
                          /*width: 110.0, height: 110.0*/
                        ),
                      ),
                    )),
              ),
              onTap: () {
                Toast.show("National handloom", context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              },
            ),
          ),
        ),
        Divider(),
        Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: ListTile(
              title: Padding(
                padding: EdgeInsets.fromLTRB(55.0, 0.0, 0.0, 0.0),
                child: Text("Reliance fresh"),
              ),
              subtitle: Padding(
                padding: EdgeInsets.fromLTRB(56.0, 0.0, 0.0, 0.0),
                child: Text("4.5km"),
              ),
              leading: SizedBox(
                height: 45,
                child: Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        child: ClipRRect(
                          child: Image.asset("images/reli.png"),
                          /*width: 110.0, height: 110.0*/
                        ),
                      ),
                    )),
              ),
              onTap: () {
                Toast.show("Reliance fresh", context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              },
            ),
          ),
        ),
        Divider(),
        Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: ListTile(
              title: Padding(
                padding: EdgeInsets.fromLTRB(75.0, 0.0, 0.0, 0.0),
                child: Text("Metro"),
              ),
              subtitle: Padding(
                padding: EdgeInsets.fromLTRB(76.0, 0.0, 0.0, 0.0),
                child: Text("4.5km"),
              ),
              leading: SizedBox(
                height: 50,
                child: Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        child: ClipRRect(
                          child: Image.asset("images/metro.png"),
                          /*width: 110.0, height: 110.0*/
                        ),
                      ),
                    )),
              ),
              onTap: () {
                Toast.show("Metro", context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              },
            ),
          ),
        ),
        Divider(),
        ListTile(
          title: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
            child: Text(
              "Are not currently in a Store?",
              textAlign: TextAlign.center,
              style: style.copyWith(color: Colors.grey, fontSize: 26.0),
            ),
          ),
          subtitle: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
            child: Text(
              "Try out Demo shopping",
              textAlign: TextAlign.center,
              style: style.copyWith(color: Colors.grey, fontSize: 26.0),
            ),
          ),
          onTap: () {
            Toast.show("Metro", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          },
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(90.0, 10.0, 0.0, 0.0),
            child: ListTile(
              title: Row(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                    child: Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () => showPress(context),
                          child: Container(
                            child: ClipRRect(
                              child: Image.asset("images/demo_store.png"),
                              /*width: 110.0, height: 110.0*/
                            ),
                          ),
                        )),
                  ),
                  FlatButton(
                      onPressed: () => showPress(context),
                      child: Text(
                        "Demo Store",
                        textAlign: TextAlign.center,
                        style:
                            style.copyWith(color: Colors.black, fontSize: 26.0),
                      )),
                ],
              ),
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }

  showPress(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
//                leading: Icon(Icons.clear),
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        child: Material(
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                child: ClipRRect(
                                  child: Image.asset("images/arrow1.png"),
                                  /*width: 110.0, height: 110.0*/
                                ),
                              ),
                            )),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: Material(
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                child: ClipRRect(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0.0, 0.0, 40.0, 0.0),
                                    child: Image.asset("images/demo_store.png"),
                                  ),
                                                         /*width: 110.0, height: 110.0*/
                                ),
                              ),
                            )),
                      ),
                      flex: 10,
                    )
                  ],
                ),
                onTap: () {},
              ),
              ListTile(
                title: Text("Demo Store",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                onTap: () {},
              ),
              ListTile(
                title: Text("India",
                    textAlign: TextAlign.center,
                    style: style.copyWith(color: Colors.grey)),
                onTap: () {},
              ),
              ListTile(
                title: Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(0.0),
                          topRight: const Radius.circular(0.0))),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                    child: new Center(
                      child: new Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.orange,
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () {
                            Route route = MaterialPageRoute(builder: (context) => home_barcode());
                            Navigator.push(context, route);
                          },
                          child: Text("Start Shopping",
                              textAlign: TextAlign.center,
                              style: style.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ],
          );
        });
  }
}


