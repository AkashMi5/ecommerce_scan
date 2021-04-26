import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ecommerce_scan/Screen/Order_complete.dart';
import 'package:ecommerce_scan/Screen/home_screen.dart';
import 'package:ecommerce_scan/Utils/Constants.dart';
import 'package:ecommerce_scan/Utils/Database_Add_To_Cart.dart';
import 'package:ecommerce_scan/models/Checkout_model.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:ecommerce_scan/ViewModels/cart_functions.dart' ;
import 'package:provider/provider.dart';

class Final_Checkout extends StatefulWidget {
  @override
  Final_Checkoutstate createState() => new Final_Checkoutstate();
}

class Final_Checkoutstate extends State<Final_Checkout> {
  final dbHelper1 = Database_Add_To_Cart.instance;
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
    setState(() {
      Constants.itemcount = users.length;
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
        Constants.GrandTotal = GrandTotal.toStringAsFixed(2);
      });
    }

    return users;
  }

  Future<void> _delete(int id1) async {
    final id = id1;
    final rowsDeleted = await dbHelper1.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }

  @override
  Widget build(BuildContext context) {
//    listtotal = double.parse(listprice) * double.parse(listqty);

    final feedback = Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                ],
              ),
              flex: 1,
            ),
            Expanded(
              child: Text(
                "Checkout",
                  textAlign: TextAlign.center,
                style: TextStyle( color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 20)
              ),
              flex: 1,
            ),

            Expanded(
              child: Text(
                  " ",
              ),
              flex: 1,
            ),
          ],
        ),
      ),
    );
    final feedback1 = Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
          ],
        ),
      ),
    );
    final feedback2 = Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
        child: Row(
          children: <Widget>[
           /* Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 10.0),
                child: Text("Cart",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        decoration: TextDecoration.underline,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ),
              flex: 1,
            ),*/
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 0.0),
                child: Text(Constants.itemcount.toString() + " " + "Item(s)",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        decoration: TextDecoration.underline,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold)),
              ),
              flex: 1,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 0.0),
                child: Text("Clear Cart",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        decoration: TextDecoration.underline,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ),
              flex: 1,
            )
          ],
        ),
      ),
    );
    final Checkout = Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.orange,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            onPressed: () {
              String Amount = TotalAmountCheck.toString();
              String Vatsend = Vat.toString();
              String finalTotal = GrandTotal.toString();

              CallApi(check, Amount, Vatsend, finalTotal);
             /* Route route =
                  MaterialPageRoute(builder: (context) => Order_Complete());
              Navigator.pushReplacement(context, route);*/
            },
            child: Text("Pay Via app",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
    final Checkout1 = SizedBox(
        width: double.infinity,
        height: 65.0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: OutlineButton(
            child: new Text("Pay Via Cash",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            onPressed: () {
              String Amount = TotalAmountCheck.toString();
              String Vatsend = Vat.toString();
              String finalTotal = GrandTotal.toString();

              CallApi(check, Amount, Vatsend, finalTotal);
            },
            highlightColor: Colors.orange,
            highlightedBorderColor: Colors.orange,
//        minWidth: MediaQuery.of(context).size.width,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
        ));
    final Checkout2 = SizedBox(
        width: double.infinity,
        height: 65.0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: OutlineButton(
              child: new Text("Apply Promotion",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              onPressed: () {},
              highlightColor: Colors.orange,
              highlightedBorderColor: Colors.orange,
//        minWidth: MediaQuery.of(context).size.width,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              borderSide: BorderSide(color: Colors.black, width: 2.0)),
        ));
    final Payment = Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 5.0),
                  child: Text("Payment",
                      textAlign: TextAlign.start,
                      style: style.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                ),
                Expanded(
                  child: Text(""),
                  flex: 1,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Icon(Icons.adjust),
                  flex: 1,
                ),
                Expanded(
                  child: Text("Credit/Debit Cart",
                      style: style.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  flex: 6,
                ),
                Expanded(
                  child: IconTheme(
                    data: new IconThemeData(color: Colors.grey),
                    child: new Icon(Icons.arrow_forward_ios),
                  ),
                  flex: 1,
                )
              ],
            ),
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
                      Container(
                        color: Colors.white,
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
                    ],
                  )),
              Expanded(
                flex: 1,
                child: CustomScrollView(
                  slivers: <Widget>[
                  FutureBuilder(
                    future: _getalldata(),
                    builder: (BuildContext cotext, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                     return  SliverToBoxAdapter(
                          child: Container(
                            child: Center(
                              child: Image.asset(
                                'images/loading.gif',
                                width: 50.0,
                                height: 50.0,
                              ),
                            ),
                          ),
                        );
                      } else {
                       return SliverList(
                         delegate: SliverChildBuilderDelegate((context, index) {
                            return Container(
                               child : new Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)
                                              ),
                                         ),
                                   elevation: 5.0,
                                      color: Color(0xFFFFFFFF),
                                  child: Column(
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
                                                      Text(
                                                      snapshot.data[index].name,
                                                      textAlign:
                                                      TextAlign.center,
                                                      style: style.copyWith(
                                                      color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                                      ],
                                                      ),
                                                      flex: 4,
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                         children: <Widget>[
                                                          Column(
                                                            children: <Widget>[
                                                              Row(
                                                                children: <Widget>[
                                                                  Text(
                                                                          snapshot
                                                                              .data[index]
                                                                              .price,
                                                                      textAlign:
                                                                      TextAlign.center,
                                                                      style: style.copyWith(
                                                                          color:
                                                                          Colors.grey,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                          fontSize: 15)),
                                                                  SizedBox(
                                                                    child: Container(
                                                                      child: ClipRRect(
                                                                        child: IconTheme(
                                                                          data: new IconThemeData(
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
                                                                          color:
                                                                          Colors.grey,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold,
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
                                                                          FontWeight
                                                                              .bold,
                                                                          fontSize: 20)),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],

                                                      ),
                                                      flex: 3
                                                      ),
                   /* Expanded(
                    child: Text("  "),
                    flex: 0,
                    ),*/
                                  Expanded(
                                  child: Column(
                                  children: <Widget>[
                                  SizedBox(
                                  child: Material(
                                  color: Colors.white,
                                  child: InkWell(
                                  onTap: () {
                                  int id = snapshot
                                      .data[index].id;

                                  setState(() {
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
                    ],
                    ),
                    //  Divider(color: Color(0xFFfff2e6),thickness: 2,),
                    ),
                    );
                    },
                           childCount: snapshot.data.length,
                         )

                    );
                  }
                },
              ) ,
                    SliverToBoxAdapter(child: Container(color: Colors.white, child: Amount)),
                    SliverToBoxAdapter(child: Container(color: Colors.white, child: Vat1)),
                    SliverToBoxAdapter(child: Container(color: Colors.white, child: Total_Amount)),
                  ]

                ),
              ),
             /* Expanded(
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
              ),*/
              /*Expanded(
                flex: 0,
                child: Container(color: Colors.white, child: Checkout2),
              ),*/
              /*Expanded(
                flex: 0,
                child: Container(color: Colors.white, child: Payment),
              ),*/
              Expanded(
                flex: 0,
                child: Container(child: Checkout),
              ),
              Expanded(
                flex: 0,
                child: Container(color: Colors.white, child: Checkout1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> CallApi(
      String check, String amount, String vatsend, String finalTotal) async {
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

    var message;
    var status;
    var url = Constants.PLACE_ORDER;
    var response = await post(url, body: {
      'userid': "3",
      'array': check,
      'amount': amount,
      'vat': vatsend,
      'total': finalTotal,
    });
    var parsedJson = json.decode(response.body);
    print('Response status: ${parsedJson}');
    message = parsedJson['message'];
    status = parsedJson['status'];
    if (status == "true") {
      pr.hide();
    //  dbHelper1.cleanDatabase();
      Toast.show("Purchasing Successfully...", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      Route route = MaterialPageRoute(builder: (context) => Order_Complete());
      Navigator.push(context, route);
    } else {
      pr.hide();
      Toast.show("Purchasing Failed...", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    }
  }
}
