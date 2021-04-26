import 'dart:math';
import 'dart:ui';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_scan/Screen/View_Receipt.dart';
import 'package:ecommerce_scan/Screen/home_screen.dart';
import 'package:ecommerce_scan/Utils/Constants.dart';
import 'package:ecommerce_scan/Utils/Database_Add_To_Cart.dart';
import 'package:ecommerce_scan/Utils/Database_Helper.dart';
import 'package:ecommerce_scan/models/Checkout_model.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rich_alert/rich_alert.dart';
import 'package:toast/toast.dart';
import 'package:ecommerce_scan/ViewModels/cart_functions.dart' ;
import 'package:provider/provider.dart';

class Order_Complete extends StatefulWidget {
  @override
  Order_Completeoutstate createState() => new Order_Completeoutstate();
}

class Order_Completeoutstate extends State<Order_Complete> {

  updateCart() {
   Provider.of<CartFunctions>(context, listen:false).setCartCount(0) ;
}

  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) =>  updateCart());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dbHelper1 = Database_Add_To_Cart.instance;
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    TimeOfDay timeOfDay = TimeOfDay.fromDateTime(DateTime.now());
    String res = timeOfDay.format(context);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);

    final Textview1 = Container(
        child: Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(15.0, 50.0, 0.0, 0.0),
            child: SizedBox(
              height: 40.0,
              child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      dbHelper1.cleanDatabase();
                      Route route = MaterialPageRoute(
                          builder: (context) => home_barcode());
                      Navigator.push(context, route);
                    },
                    child: Container(
                      child: ClipRRect(
                        child: Image.asset("images/close_black.png"),
                      ),
                    ),
                  )),
            ),
          ),
          flex: 1,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 50.0, 30.0, 0.0),
            child: SizedBox(
              child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      child: ClipRRect(
                        child: Text("Order Complete",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30)),
                      ),
                    ),
                  )),
            ),
          ),
          flex: 10,
        ),
      ],
    ));
    final Textview2 = Container(
        child: Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
            child: SizedBox(
              child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      child: ClipRRect(
                        child: Text("Demo Store " + formattedDate + " " + res,
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ),
                    ),
                  )),
            ),
          ),
          flex: 10,
        ),
      ],
    ));
    final Textview3 = Container(
        child: Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
            child: SizedBox(
              child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      Route route = MaterialPageRoute(
                          builder: (context) => View_Receipt());
                      Navigator.push(context, route);
                    },
                    child: Container(
                      child: ClipRRect(
                        child: Text("View Receipt",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                decoration: TextDecoration.underline,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 25)),
                      ),
                    ),
                  )),
            ),
          ),
          flex: 10,
        ),
      ],
    ));
    final Textview4 = Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
        child: SizedBox(
          height: 60.0,
          child: Material(
              color: Colors.white,
              child: InkWell(
                onTap: () {
               //   Navigator.of(context).pop();
                },
                child: Container(
                  child: ClipRRect(
                    child: Image.asset("images/kinderjoy_barcode.png"),
                  ),
                ),
              )),
        ),
      ),
    );
    final Textview5 = Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
        child: SizedBox(
          height: 150.0,
          child: Material(
              color: Colors.white,
              child: InkWell(
                onTap: () {
               //   Navigator.of(context).pop();
                },
                child: Container(
                  child: ClipRRect(
                    child: Image.asset("images/winner.png"),
                  ),
                ),
              )),
        ),
      ),
    );
    final Textview6 = Container(
        child: Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
            child: SizedBox(
              child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      child: ClipRRect(
                        child: Text("Just Flash The Phone",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25)),
                      ),
                    ),
                  )),
            ),
          ),
          flex: 10,
        ),
      ],
    ));

    final Textview7 = Container(
        child: Center(
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(100.0, 30.0, 0.0, 0.0),
            child: SizedBox(
              height: 25.0,
              child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                 //     Navigator.of(context).pop();
                    },
                    child: Container(
                      child: ClipRRect(
                        child: Image.asset("images/clerk.png"),
                      ),
                    ),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
            child: SizedBox(
              child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      child: ClipRRect(
                        /*clerk.png*/
                        child: Text("Show the clerk this screen",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.grey, fontSize: 16)),
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    ));

    final Textview8 = Container(
        child: Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
            child: SizedBox(
              child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      child: ClipRRect(
                        child: Text(
                            "Total Items -" +" "+ Constants.itemcount.toString(),
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.black, fontSize: 20)),
                      ),
                    ),
                  )),
            ),
          ),
          flex: 10,
        ),
      ],
    ));
    final Textview9 = Container(
        child: Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
            child: SizedBox(
              child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      child: ClipRRect(
                        child: Text("Total Amount - INR" +" "+ Constants.GrandTotal,
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.black, fontSize: 20)),
                      ),
                    ),
                  )),
            ),
          ),
          flex: 10,
        ),
      ],
    ));
    final Textview10 = Container(
        child: Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
            child: SizedBox(
              child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      child: ClipRRect(
                        child: Text("Rate your experience?",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 26)),
                      ),
                    ),
                  )),
            ),
          ),
          flex: 10,
        ),
      ],
    ));

    final Textview11 = Container(
        child: Center(
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(140.0, 30.0, 0.0, 0.0),
            child: SizedBox(
              height: 30.0,
              child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                  //    Navigator.of(context).pop();
                    },
                    child: Container(
                      child: ClipRRect(
                        child: Image.asset("images/confused.png"),
                      ),
                    ),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 30.0, 0.0, 0.0),
            child: SizedBox(
              height: 30.0,
              child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                  //    Navigator.of(context).pop();
                    },
                    child: Container(
                      child: ClipRRect(
                        child: Image.asset("images/happy.png"),
                      ),
                    ),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 30.0, 0.0, 0.0),
            child: SizedBox(
              height: 30.0,
              child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                 //     Navigator.of(context).pop();
                    },
                    child: Container(
                      child: ClipRRect(
                        child: Image.asset("images/sad.png"),
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    ));

    return Scaffold(
        body: SingleChildScrollView(
      child: ListTile(
        subtitle: Container(
//          height: double.infinity,
          width: double.infinity,

          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/a1.gif'),
              fit: BoxFit.fill,
            ),
          ),
//            color: Colors.white,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Textview1,
                Textview2,
                Textview3,
                Textview4,
                Textview5,
                Textview6,
                Textview7,
                Textview8,
                Textview9,
                Textview10,
                Textview11
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
