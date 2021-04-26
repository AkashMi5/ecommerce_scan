import 'dart:convert';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_scan/Utils/Constants.dart';
import 'package:ecommerce_scan/Utils/Database_Add_To_Cart.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:rich_alert/rich_alert.dart';
import 'package:toast/toast.dart';
import 'package:ecommerce_scan/ViewModels/cart_functions.dart' ;
import 'package:provider/provider.dart';

class Type_barcode extends StatefulWidget {
  Type_barcode({Key key, this.title}) : super(key: key);
  final String title;


  @override
  Type_barcodestate createState() => new Type_barcodestate();
}

class Type_barcodestate extends State<Type_barcode> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController Textview1 = TextEditingController();
  ProgressDialog pr;
  int _incrementnumber;
  String _incrementnumberset = "";
  final dbHelper = Database_Add_To_Cart.instance;

  @override
  Widget build(BuildContext context) {
    final feedback = new Container(
        child: TextField(
          maxLines: 1,
          controller: Textview1,
          obscureText: false,
          style: style,
          decoration: InputDecoration(
            hintText: "Search Here....",
            focusColor: Colors.black,
          ),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
        ));

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.orange,
      child: MaterialButton(
        minWidth: MediaQuery
            .of(context)
            .size
            .width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Senddataapi();
//          _modalBottomSheetMenu();
        },
        child: Text("Search",
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
      title:  Text("Type in barcode",
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
            /*  Row(
                children: <Widget>[
                  Expanded(
                    child: Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            child: ClipRRect(
                              child: Image.asset("images/back.png"),
                              *//*width: 110.0, height: 110.0*//*
                            ),
                          ),
                        )),
                    flex: 1,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 0.0),
                      child: Text("Type in barcode",
                          textAlign: TextAlign.center,
                          style: style.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    flex: 15,
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),*/
              feedback,
              SizedBox(
                height: 15.0,
              ),
              loginButon,
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> Senddataapi() async {
    var message;
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

    String number = Textview1.text;
    print(Textview1.text);
    if (!Textview1.text.isEmpty) {
      var status;
      var url = Constants.TYPE_IN_BARCODE;
      var response = await post(url, body: {
        'product_code': number,
      });
      var parsedJson = json.decode(response.body);
      print('Response status: ${parsedJson}');
      message = parsedJson['message'];
      status = parsedJson['status'];
      if (status == "true") {
        pr.hide();
        var data = parsedJson["data"];
        String id = data["id"];
        String name = data["name"];
        String price = data["price"];
        String image = data["image"];
        String qty = data["quantity"];

        _modalBottomSheetMenu(id, name, price, image, qty);
        _getnumber();
        print(id + "   " + name + "     " + price);
      } else {
        pr.hide();
        Toast.show(message, context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    } else {
//      showdialog();
      pr.hide();
      Toast.show(message, context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
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

  void _modalBottomSheetMenu(String id, String name, String price, String image, String qty) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
//                leading: Icon(Icons.clear),
                      title: Row(
                        children: <Widget>[
                          Expanded(
                            child: Material(
                                color: Colors.white,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    child: ClipRRect(
                                      child: Icon(Icons.clear),
                                      /*width: 110.0, height: 110.0*/
                                    ),
                                  ),
                                )),
                            flex: 1,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 38.0, 0.0),
                              child: Text(name,
                                  textAlign: TextAlign.center,
                                  style: style.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ),
                            flex: 10,
                          )
                        ],
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              height: 65,
                              child: Material(
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      child: ClipRRect(
                                        child: CachedNetworkImage(
                                          imageUrl: image,
                                          fit: BoxFit.cover,
                                        ),
                                        /*width: 110.0, height: 110.0*/
                                      ),
                                    ),
                                  )),
                            ),
                          )),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Row(
                        children: <Widget>[
                          Expanded(
                            child: Material(
                                color: Colors.white,
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    child: Text('Price INR:' + " " + price,
                                        textAlign: TextAlign.center,
                                        style: style.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    /*width: 110.0, height: 110.0*/
                                  ),
                                )),
                            flex: 1,
                          ),
                          Expanded(
                            child: Text(''),
                            flex: 1,
                          ),
                          Expanded(
                            child: new Container(
                              color: Colors.black,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: GestureDetector(
                                          onTap: () {

                                            setState(() {
                                              pluscount();
                                            });


                                            Toast.show("++1", context,
                                                duration: Toast.LENGTH_LONG,
                                                gravity: Toast.BOTTOM);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10.0, 0.0, 0.0, 0.0),
                                            child: new Text(
                                              "+",
                                              textDirection: TextDirection.ltr,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 30),
                                            ),
                                          ),
                                        ),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                      child: FlatButton(
                                          onPressed: () {},
                                          child: Text(
                                            _incrementnumberset,
                                            textDirection: TextDirection.ltr,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )),
                                      flex: 1,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              minuscount();
                                            });
                                            Toast.show("--1", context,
                                                duration: Toast.LENGTH_LONG,
                                                gravity: Toast.BOTTOM);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                15.0, 0.0, 0.0, 0.0),
                                            child: new Text(
                                              "-",
                                              textDirection: TextDirection.ltr,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 35),
                                            ),
                                          ),
                                        ),
                                      ),
                                      flex: 1,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            flex: 1,
                          )
                        ],
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Container(
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(0.0),
                                topRight: const Radius.circular(0.0))),
                        child: new Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                            child: new Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.orange,
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () {
                                  _save(image, name, price, _incrementnumberset);
                                  Navigator.of(context).pop();
                                },
                                child: Text("Add To Cart",
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
        });
  }


  Future<void> _save(String image, String txt, String price, String qty) async {
    Map<String, dynamic> row = {
      Database_Add_To_Cart.columnName: txt,
      Database_Add_To_Cart.columnprice: price,
      Database_Add_To_Cart.columnqty: qty,
      Database_Add_To_Cart.columnCartQty: 23,
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
    print('inserted row name: $txt');
    print('inserted row price: $price');
    print('inserted row qty: $qty');


  }




  void _getnumber() {
    _incrementnumber = 1;
    _incrementnumberset = _incrementnumber.toString();
    print(_incrementnumberset);
  }

  void pluscount() {
    Provider.of<CartFunctions>(context, listen:false).incrementCounter() ;
    /* _incrementnumber++;
    _incrementnumberset = _incrementnumber.toString();
    print(_incrementnumberset);*/
  }

  void minuscount() {
    if (_incrementnumberset == "1") {
      print(_incrementnumberset);
    } else {
      Provider.of<CartFunctions>(context, listen:false).decrementCounter() ;
      /* _incrementnumber--;
      _incrementnumberset = _incrementnumber.toString();
      print(_incrementnumberset);*/
    }
  }
}
