import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ecommerce_scan/Screen/Final_checkout.dart';
import 'package:ecommerce_scan/Utils/Database_Add_To_Cart.dart';
import 'package:ecommerce_scan/models/Checkout_model.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:ecommerce_scan/ViewModels/cart_functions.dart' ;
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
//  Checkout({Key key, this.title}) : super(key: key);
//  final String title;
  @override
  Checkoutstate createState() => new Checkoutstate();
}

class Checkoutstate extends State<Checkout> {
  final dbHelper1 = Database_Add_To_Cart.instance;
  int itemcount;
  Checkout_model user;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController textEditingController = TextEditingController();
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {

    double cheight = MediaQuery.of(context).size.height ;
    double cwidth = MediaQuery.of(context).size.width ;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));

    final feedback = Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      height: 25.0,
                      child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: ClipRRect(
                                child: Image.asset("images/back.png"),
                              ),
                            ),
                          )),
                    ),

                  ],
                ),
                flex: 2,
              ),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Cart",
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ],
                ),
                flex: 2,
              ),

              Expanded(
                child: Row(
                  children: <Widget>[
                    Text("",
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ],
                ),
                flex: 2,
              ),

            ],
          ),
        ),

        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          width: cwidth,
          color: Colors.orange,
          child: Consumer<CartFunctions>(
           builder: (context, cart, child){
             return Center(
               child: Text('${cart.cartCount}' + " " + "Item(s)",
                   style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 20.0,
                       color: Colors.white)),
             );
           }
          ),
        ),

      ],

    );
    final Checkout = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.orange,
          child: MaterialButton(
            minWidth: cwidth*0.6,
            padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
            onPressed: () {
              Route route =
                  MaterialPageRoute(builder: (context) => Final_Checkout());
              Navigator.pushReplacement(context, route);
            },
            child: Text("Checkout",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.black12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      feedback,
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 15,
                child:
                FutureBuilder(
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
                    } else {
                      return MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                contentPadding: EdgeInsets.only(
                                    left: 5.0, right: 5.0, top: 0.0, bottom: 5.0),
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
                                  child: new Container(
                                    padding: new EdgeInsets.fromLTRB(
                                        10.0, 15.0, 10.0, 15.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 5.0,
                                              ),
                                              new Icon(
                                                Icons
                                                    .brightness_1,
                                                size: 10,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(
                                                width: 5.0,
                                              ),
                                              Text(snapshot.data[index].name,
                                                  textAlign: TextAlign.center,
                                                  style: style.copyWith(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                          flex: 3,
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                      "INR" +
                                                          " " +
                                                          snapshot.data[index]
                                                              .price,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: style.copyWith(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15)),

                                                  new Icon(
                                                    Icons.clear,
                                                    size: 10,
                                                  ),

                                                  Text(
                                                      snapshot
                                                          .data[index].qty,
                                                      /*snapshot.data[index].name*/
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: style.copyWith(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15)),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                      "INR" +
                                                          (" " +
                                                  ( double.parse(snapshot
                                                                  .data[index]
                                                                  .price) *
                                                      double.parse(snapshot
                                                          .data[index]
                                                          .qty)).toStringAsFixed(2) ),
                                                      overflow: TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: style.copyWith(
                                                          color:
                                                              Colors.orange,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20)),
                                                ],
                                              ),
                                            ],
                                          ),
                                          flex: 2,
                                        ),
                                        Expanded(
                                          child: Text("  "),
                                          flex: 0,
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                child: Material(
                                                    color: Colors.white,
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          int id = snapshot
                                                              .data[index].id;
                                                          _delete(id);
                                                        });
                                                      },
                                                      child: Container(
                                                        child: ClipRRect(
                                                          child: IconTheme(
                                                            data: new IconThemeData(
                                                                color: Colors
                                                                    .orange),
                                                            child: new Icon(
                                                              Icons.delete,
                                                              size: 20,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                          flex: 0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  //  Divider(color: Color(0xFFfff2e6),thickness: 2,),
                                ),
                              );
                            }),
                      );
                    }
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(child: Checkout),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  Future<List<Checkout_model>> _getalldata() async {
    final allRows = await dbHelper1.queryAllRows();
    List<Checkout_model> users = [];
    for (var u in allRows) {
      user = Checkout_model(u["id"], u["name"], u["price"], u["qty"]);
      users.add(user);
    }
    setState(() {
      itemcount = users.length;
    });

    return users;
  }

  Future<void> _delete(int id1) async {
    final id = id1;

    var rowData = await dbHelper1.getRow(id);
    var qtyVar = rowData[0] ;
    QuantityObject qtyObject  = QuantityObject.fromJson(qtyVar) ;
    String qtyStr = qtyObject.quty ;
    print("Quantity " + qtyStr ) ;
    int presentCount = Provider.of<CartFunctions>(context, listen:false).cartCount ;
    int newCount = presentCount - int.parse(qtyStr) ;
    Provider.of<CartFunctions>(context, listen: false).setCartCount(newCount);
    final rowsDeleted = await dbHelper1.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
}


class QuantityObject {
  String quty ;

  QuantityObject({this.quty}) ;

   factory QuantityObject.fromJson(Map<String, dynamic> jsn) {
      return QuantityObject(
        quty: jsn['qty'],
      );
  }
}
