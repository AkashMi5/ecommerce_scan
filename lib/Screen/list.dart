import 'dart:ui';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_scan/Utils/Database_Helper.dart';
import 'package:ecommerce_scan/models/list_model.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rich_alert/rich_alert.dart';
import 'package:toast/toast.dart';
import 'package:ecommerce_scan/Utils/date_format.dart' ;

import 'Checkout.dart';

class list extends StatefulWidget {
  list({Key key, this.title}) : super(key: key);
  final String title;

  @override
  liststate createState() => new liststate();
}

class liststate extends State<list> {
  final dbHelper = DatabaseHelper.instance;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController textEditingController = TextEditingController();
  ProgressDialog pr;
  bool monVal = false;
  String icon = "images/checkbox1.png";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getalldata();
  }

  @override
  Widget build(BuildContext context) {
    final feedback = new Container(
      height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
      maxLines: 1,
      controller: textEditingController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          hintText: "Enter item name here...",
          focusColor: Colors.black,
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
    ),
        ));

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.orange,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
        onPressed: () {
          String check = textEditingController.text;
          if (check.isEmpty) {
            Toast.show("Empty", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          } else {
            setState(() {
              _save();
            });
          }
        },
        child: Text("Add Item",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text("Shopping List",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding:
                          EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          feedback,
                          SizedBox(
                            height: 10.0,
                          ),
                          loginButon,
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: FutureBuilder(
                    future: _getalldata(),
                    builder: (BuildContext cotext, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return Container(
                          child: Center(
                            child: Image.asset(
                              'images/loading.gif',
                              width: 50.0,
                              height: 50.0,
                            ),
                          ),
                        );
                      } else if(snapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                contentPadding: EdgeInsets.only(left: 16),
                                title: Text(snapshot.data[index].name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18),
                                ),
                                subtitle: Row(
                                  children: <Widget>[
                                    Text(DateFormatShop.changeFormat(snapshot.data[index].dateTime)[0] + " ",
                                       style: TextStyle(
                                       color: Colors.blueGrey,
                                       fontSize: 13),
                              ),
                                    Text( DateFormatShop.changeFormat(snapshot.data[index].dateTime)[5],
                              style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13),
                              )

                                  ],
                                ),
                                 trailing:IconButton(
                                  icon: new Icon(Icons.delete),
                                  highlightColor: Colors.orange,
                                  onPressed: () {
                                    int _id = snapshot.data[index].id;
                                    String name =
                                        snapshot.data[index].name;
                                    setState(() {
                                      delete(_id, name);
                                    });
                                  },
                                ),
                              ) ;
                               /* CheckboxListTile(
                                  title: new Text(snapshot.data[index].name),
                                  value: timeDilation != 1.0,
                                  onChanged: (bool value) {
                                    setState(() {
                                      timeDilation = value ? 2.0 : 1.0;
                                    });
                                  },
                                  secondary:   IconButton(
                                    icon: new Icon(Icons.delete),
                                    highlightColor: Colors.orange,
                                    onPressed: () {
                                      int _id = snapshot.data[index].id;
                                      String name =
                                          snapshot.data[index].name;
                                      setState(() {
                                        delete(_id, name);
                                      });
                                    },
                                  ),
                                 );*/


                              /*ListTile(
                                contentPadding: EdgeInsets.only(
                                    left: 5.0,
                                    right: 5.0,
                                    top: 5.0,
                                    bottom: 5.0),
                                onTap: () {},
                                subtitle: new Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                  ),
                                  elevation: 5.0,
                                  color: Color(0xFFFFFFFF),
                                  child: Container(
                                    padding: new EdgeInsets.fromLTRB(
                                        10.0, 15.0, 10.0, 15.0),
                                    // color: Color(0xFFfff2e6),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(snapshot.data[index].name,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                              textAlign: TextAlign.start),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: Icon(Icons.check_box),
                                          flex: 0,
                                        ),
                                        Expanded(
                                          child: IconButton(
                                            icon: new Icon(Icons.delete),
                                            highlightColor: Colors.orange,
                                            onPressed: () {
                                              int _id = snapshot.data[index].id;
                                              String name =
                                                  snapshot.data[index].name;
                                              setState(() {
                                                delete(_id, name);
                                              });
                                            },
                                          ),
                                          flex: 0,
                                        ),
                                      ],
                                    ),
                                  ),

                                  //  Divider(color: Color(0xFFfff2e6),thickness: 2,),
                                ),
                              );*/

                            });
                      } else if(snapshot.data.length == 0){
                        return Center(
                          child: Text("No Items saved",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18),)
                      );

                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _save() async {
    String name = textEditingController.text;
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnAge: 23,
      DatabaseHelper.columnDateTime : DateTime.now().toString() ,
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
    textEditingController.clear();
  }

  Future<List<list_model>> _getalldata() async {
    final allRows = await dbHelper.queryAllRows();
    List<list_model> users = [];
    allRows.forEach((row) => print(row));
    for (var u in allRows) {
      list_model user = list_model(u["_id"], u["name"], u["date_time"]);
      users.add(user);
      print(user);
    }
    print(users.length);
    print('query all rows:');
    return users;
  }

  Future<void> delete(int id1, String name) async {
    print(name);
    final id = id1;
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}



//  void _onCategorySelected(bool selected, category_id) {
//    if (selected == true) {
//      setState(() {
//        _selecteCategorys.add(category_id);
//      });
//    } else {
//      setState(() {
//        _selecteCategorys.remove(category_id);
//      });
//    }
//  }
