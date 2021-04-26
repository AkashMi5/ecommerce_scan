import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ecommerce_scan/Screen/Order_complete.dart';
import 'package:ecommerce_scan/Screen/Previous_Order.dart';
import 'package:ecommerce_scan/Utils/Constants.dart';
import 'package:ecommerce_scan/Utils/Database_Add_To_Cart.dart';
import 'package:ecommerce_scan/models/Checkout_model.dart';
import 'package:ecommerce_scan/models/Previous_order_details_model.dart';
import 'package:ecommerce_scan/models/Previous_order_model.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class Previous_order_details extends StatefulWidget {
  @override
  Previous_order_detailsstate createState() =>
      new Previous_order_detailsstate();
}

class Previous_order_detailsstate extends State<Previous_order_details> {
  final dbHelper1 = Database_Add_To_Cart.instance;
  int itemcount;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController textEditingController = TextEditingController();
  ProgressDialog pr;
  String firstNum, secondNum;
  String listprice, listqty;
  double listtotal = 0;
  String array = "";
  double totalAmount = 0;
  double TotalAmountCheck = 0;
  double GrandTotal = 0;
  double Vat = 0;
  Checkout_model user;
  List<Checkout_model> users = [];
  String check = "";
  List<Json> _list = [];

//  @override
//  void initState() {
//    super.initState();
//    print(Constants.PREVIOUS_ORDER_DETAILS__ORDER_ID);
//    print(Constants.PREVIOUS_ORDER_DETAILS_DATE);
//  }

  @override
  Widget build(BuildContext context) {
    _getalldata();
    final feedback = Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 15.0),
        child: SizedBox(
          child: Material(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  child: ClipRRect(
                    child: Text("Previous Order",
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
              )),
        ),
      ),
    );

    final feedback1 = Container(
        child: Text("Item Total",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 20)));

    final Amount = Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(25.0, 15.0, 0.0, 0.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 0.0),
                child: Text("Amount",
                    style: style.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ),
              flex: 1,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 0.0),
                child: Text("",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        decoration: TextDecoration.underline,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold)),
              ),
              flex: 1,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 0.0),
                child: Text("INR" + " " + TotalAmountCheck.toString(),
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ),
              flex: 1,
            )
          ],
        ),
      ),
    );
    final Vat1 = Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(25.0, 15.0, 0.0, 0.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 0.0),
                child: Text("Vat",
                    style: style.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ),
              flex: 1,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 0.0),
                child: Text("",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        decoration: TextDecoration.underline,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold)),
              ),
              flex: 1,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 0.0),
                child: Text("INR" + " " + Vat.toString(),
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ),
              flex: 1,
            )
          ],
        ),
      ),
    );
    final Total_Amount = Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(25.0, 15.0, 0.0, 20.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 0.0),
                child: Text("Total Amount",
                    style: style.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ),
              flex: 1,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 0.0),
                child: Text("",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        decoration: TextDecoration.underline,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold)),
              ),
              flex: 1,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 0.0),
                child: Text("INR" + " " + GrandTotal.toString(),
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ),
              flex: 1,
            )
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(Constants.PREVIOUS_ORDER_DETAILS_DATE,
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          color: Colors.black12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  flex: 0,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                feedback,
                                feedback1,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                flex: 1,
                child: Text("hii"),
              ),
              Expanded(
                flex: 0,
                child: Container(color: Colors.white, child: Amount),
              ),
              Expanded(
                flex: 0,
                child: Container(color: Colors.white, child: Vat1),
              ),
              Expanded(
                flex: 0,
                child: Container(color: Colors.white, child: Total_Amount),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map> _getalldata() async {
    var url =
        "http://avenirtechs.com/scootq/app/index.php/api/product/get_user_orders_by_id";
    var response = await post(url, body: {
      'orderid': "66",
    });

//    final data = jsonDecode(response.body);
    final data = json.decode(response.body.toString());
     for (Map i in data) {
      _list.add(Json.fromJson(i));
    }
  }
}

/*   FutureBuilder(
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
                      return Container(
                        color: Colors.white,
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                contentPadding: EdgeInsets.only(
                                    left: 5.0,
                                    right: 5.0,
                                    top: 0.0,
                                    bottom: 5.0),
                                onTap: () {},
                                subtitle: Text(snapshot.data.id),
                              );
                            }),
                      );
                    }
                  },
                ),*/
