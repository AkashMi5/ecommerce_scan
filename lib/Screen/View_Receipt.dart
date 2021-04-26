import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ecommerce_scan/Screen/Order_complete.dart';
import 'package:ecommerce_scan/Utils/Constants.dart';
import 'package:ecommerce_scan/Utils/Database_Add_To_Cart.dart';
import 'package:ecommerce_scan/models/Checkout_model.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

class View_Receipt extends StatefulWidget {
  @override
  View_Receiptstate createState() => new View_Receiptstate();
}

class View_Receiptstate extends State<View_Receipt> {
  final dbHelper1 = Database_Add_To_Cart.instance;
  int itemcount = 0;
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

  @override
  void initState() {
    super.initState();
    setState(() {
      _getalldata1();
    });
  }

  Future<List<Checkout_model>> _getalldata() async {
    String finalarray;
    List<String> finalarrayadd = [];
    final allRows = await dbHelper1.queryAllRows();
    List<Checkout_model> users = [];
    for (var u in allRows) {
      user = Checkout_model(u["id"], u["name"], u["price"], u["qty"]);
      users.add(user);
      String name = user.name;
      String price = user.price;
      String qty = user.qty;
      String array2 = "\"" + name + "\"";
      String array3 = "\"" + price + "\"";
      String array4 = "\"" + qty + "\"";
      String arrayy1 = "\"" + "name" + "\"" + "\:" + array2 + "\,";
      String arrayy2 = "\"" + "price" + "\"" + "\:" + array3 + "\,";
      String arrayy3 = "\"" + "quantity" + "\"" + "\:" + array4;
      finalarray = "\{" + arrayy1 + " " + arrayy2 + " " + arrayy3 + "\}";
      finalarrayadd.add(finalarray);
    }
    check = finalarrayadd.toString();
    print(check);
    setState(() {itemcount = users.length;

    });
    return users;
  }

  Future<List<Checkout_model>> _getalldata1() async {
    final allRows = await dbHelper1.queryAllRows();
    for (var u in allRows) {
      firstNum = u["price"];
      secondNum = u["qty"];
      totalAmount = double.parse(secondNum) * double.parse(firstNum);
      setState(() {
        TotalAmountCheck = TotalAmountCheck + totalAmount;
      });
      double e = TotalAmountCheck * 5;
      setState(() {
        Vat = e / 100;
      });
      setState(() {
        GrandTotal = Vat + TotalAmountCheck;
      });
    }


    return users;
  }

  Future<void> _delete() async {
    final id = await dbHelper1.queryRowCount();
    final rowsDeleted = await dbHelper1.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }

  @override
  Widget build(BuildContext context) {
//    listtotal = double.parse(listprice) * double.parse(listqty);

    final feedback = Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
        child: SizedBox(
          height: 50.0,
          child: Material(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
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
    final feedback1 = Container(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 10.0,
          ),
          SizedBox(
            height: 50.0,
            child: Material(
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    child: ClipRRect(
                      child: Image.asset("images/demo_store.png"),
                    ),
                  ),
                )),
          ),
          SizedBox(
            width: 20.0,
          ),
          Text("Demo Store",
              textAlign: TextAlign.center,
              style: style.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
        ],
      ),
    );
    final feedback2 = Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 10.0),
                child: Text("Name",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        decoration: TextDecoration.underline,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ),
              flex: 1,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 0.0),
                child: Text(itemcount.toString() + " " + "Item(s)",
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
                child: Text("Price/Qty",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        decoration: TextDecoration.underline,
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

    final Amount = Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(25.0, 15.0, 0.0, 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 0.0),
                child: Text("Sub-total",
                    style: style.copyWith(
                        color: Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ),
              flex: 1,
            ),

            SizedBox(width: 45),

            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text("INR" + " " + TotalAmountCheck.toStringAsFixed(2),
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                            color: Colors.orange.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ]
              ),
              flex: 1,
            ),
            SizedBox(width: 20)
          ],
        ),
      ),
    );
    final Vat1 = Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(25.0, 15.0, 0.0, 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 0.0),
                child: Text("GST @5%",
                    style: style.copyWith(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ),
              flex: 1,
            ),
            SizedBox(width: 45),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text( Vat.toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: style.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ],
              ),
              flex: 1,
            ),
            SizedBox(width: 20)
          ],
        ),
      ),
    );
    final Total_Amount = Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(25.0, 15.0, 0.0, 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            SizedBox(width: 45),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text("INR" + " " + GrandTotal.toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: style.copyWith(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                ],
              ),
              flex: 1,
            ),
            SizedBox(width: 20)
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
        title: Text("View Receipt",
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
                                feedback2,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                flex: 1,
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
                                subtitle: Column(
                                  children: <Widget>[
                                    new Container(
                                      padding: new EdgeInsets.fromLTRB(
                                          10.0, 15.0, 10.0, 15.0),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Row(
                                              children: <Widget>[
                                                SizedBox(
                                                  child: Material(
                                                      color: Colors.white,
                                                      child: InkWell(
                                                        onTap: () {
//                                                        Navigator.of(context).pop();
                                                        },
                                                        child: Container(
                                                          child: ClipRRect(
                                                            child: IconTheme(
                                                              data: new IconThemeData(
                                                                  color: Colors
                                                                      .grey),
                                                              child: new Icon(
                                                                Icons
                                                                    .brightness_1,
                                                                size: 10,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )),
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
                                                    SizedBox(
                                                      child: Container(
                                                        child: ClipRRect(
                                                          child: IconTheme(
                                                            data:
                                                                new IconThemeData(
                                                                    color: Colors
                                                                        .grey),
                                                            child: new Icon(
                                                              Icons.clear,
                                                              size: 10,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
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
//                                                      listprice = snapshot
//                                                          .data[index].price,
//                                                      listqty = snapshot
//                                                          .data[index].qty,

                                                    Text(
                                                        "INR" +
                                                            " " +
                                                            (double.parse(snapshot
                                                                        .data[
                                                                            index]
                                                                        .price) *
                                                                    double.parse(snapshot
                                                                        .data[
                                                                            index]
                                                                        .qty))
                                                                .toString(),

//                                                          "INR" +
//                                                              snapshot
//                                                                  .data[index]
//                                                                  .price
//                                                                  .toString(),
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
                                            flex: 1,
                                          ),
                                          Expanded(
                                            child: Text("  "),
                                            flex: 0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      );
                    }
                  },
                ),
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
}
