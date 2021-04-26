import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ecommerce_scan/Screen/Checkout.dart';
import 'package:ecommerce_scan/Screen/Loose_item_barcode.dart';
import 'package:ecommerce_scan/Screen/list.dart';
import 'package:ecommerce_scan/Utils/Constants.dart';
import 'package:ecommerce_scan/Utils/Database_Add_To_Cart.dart';
import 'package:ecommerce_scan/models/Checkout_model.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'Profile.dart';
import 'Type_In_Barcode.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'Previous_Order.dart';
import 'package:ecommerce_scan/ViewModels/cart_functions.dart' ;
import 'package:provider/provider.dart';

class home_barcode extends StatefulWidget {
  home_barcode({Key key, this.title}) : super(key: key);
  final String title;

  @override
  home_barcode_barcodeState createState() => new home_barcode_barcodeState();
}

class home_barcode_barcodeState extends State<home_barcode> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  ProgressDialog pr;
  int _incrementnumber;
  String _incrementnumberset = "";
  String _scanBarcode = 'Unknown';
  final dbHelper = Database_Add_To_Cart.instance;
   int itemcount = 0;
  Checkout_model user;
  String _dialogTitle = 'Alert';
  String _dialogDesc = 'Username already exists, try with other one!';
  String _dialogButtonText = 'Okay';

  @override
  void initState() {
    super.initState();
    setState(() {
      _getalldata(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    double cheight = MediaQuery.of(context).size.height ;
    double cwidth = MediaQuery.of(context).size.width ;

 //   _getalldata(context);
    final StartScaning = Container(
      color: Colors.white,
      child: Center(
        child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 110.0, 0.0, 0.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 220.0,
                  child: Image.asset(
                    "images/barcode.jpg",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 50.0,
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.orange,
                    child: MaterialButton(
//                      minWidth: MediaQuery.of(context).size.height,
                      onPressed: () {
                     scanBarcodeNormal();
                      },
                      child: Text("  Start shopping ",
                          textAlign: TextAlign.center,
                          style: style.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text("Scan barcode",
                    textAlign: TextAlign.center,
                    style: style.copyWith(color: Colors.black, fontSize: 15))
              ],
            ),
          ),
        ),
      ),
    );

    final loginButon = Container(
      color: Colors.white,
      child: Center(
        child: Container(
//          margin: ,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              Route route = MaterialPageRoute(
                                  builder: (context) => Type_barcode());
                              Navigator.push(context, route);
                            },
                            child: Column(
                              children: <Widget>[
                                Container(
                                    height: 80, width: 80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue,
                                    ),
                                    child: Image.asset("images/nobarcode.png", color: Colors.white)
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Type-in barcode",
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                      color: Colors.black),
                                ),
                              ],

                            ),
                          )),
                      flex: 1,
                    ),
                    Expanded(
                      child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              Route route = MaterialPageRoute(
//                                    builder: (context) => Page2());
                                  builder: (context) => Loose_item_barcode());
                              Navigator.push(context, route);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    height: 80, width: 80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.lightGreen,
                                    ),
                                    child: Image.asset("images/no_barcode.png", color: Colors.white, )
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Loose items",
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          )),
                      flex: 1,
                    ),
                    Expanded(
                      child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              Route route = MaterialPageRoute(
                                  builder: (context) => list());
//                              Navigator.pushReplacement(context, route);
                              Navigator.push(context, route);
                            },
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 80, width: 80,
                                  decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.pink,
                                  ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset("images/lists.png", color: Colors.white),
                                    )
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "List",
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                      color: Colors.black),
                                ),
                              ],

                            ),
                          )),
                      flex: 1,
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 80,
                              child: Material(
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: () {
                                      Route route =
                                      MaterialPageRoute(builder: (context) => Previous_order());
                                      Navigator.push(context, route);
                                      /* Toast.show("Coupons is not Working", context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);*/
                                    },
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black87,
                                      ),
                                      child: Image.asset("images/previous_orders.png", color: Colors.green,),
                                    ),
                                  )),
                            ),

                            SizedBox(
                              height: 10.0,
                            ),

                            Text(
                              "Previous Orders",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 80,
                              child: Material(
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: () {
                                      Route route = MaterialPageRoute(
                                          builder: (context) => Profile());
                                      Navigator.push(context, route);
                                    },
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.pinkAccent,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset("images/man.png", color: Colors.white,),
                                      ),
                                    ),
                                  )),
                            ),

                            SizedBox(
                              height: 10.0,
                            ),

                            Text(
                              "Profile",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      body: Container(
        height: cheight,
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        StartScaning,
                        Divider(
                          color: Colors.black,
                        ),

                        SizedBox(height: 25),

                        loginButon,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
//                                int length=sn
                  if ( Provider.of<CartFunctions>(context, listen:false).cartCount  == 0) {
                    Emptyshowdialog();
                  } else {
                    checkoutpage();
                  }
                },
                child: Container(
                  width: cwidth,
                  color: Colors.orange,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding:
                          EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                          child: Icon(Icons.shopping_cart, color: Colors.white, size: 30)
                          /*Text(
                            "Cart",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.black),
                          ),*/
                        ),

                         Consumer<CartFunctions>(
                          builder: (context, cart, child) {
                            return Text('${cart.cartCount}' +  " Item(s)",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.white54));
                          },
                        ),
                        /*new Text( " " +
                          itemcount.toString() + " " + "Item(s)",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.white54),
                        ),*/
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]

        ),
      ),

    );
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
      print(_scanBarcode);

      if (_scanBarcode != null) {
        CallApi(_scanBarcode);
      } else {
        Toast.show("Something Went Wrong", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    });
  }

  Future<void> CallApi(String scanBarcode) async {
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

    print(scanBarcode);
    if (!scanBarcode.isEmpty) {
      var status;
      var url = Constants.TYPE_IN_BARCODE;
      var response = await post(url, body: {
        'product_code': scanBarcode,
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
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    } else {
//      showdialog();
      pr.hide();
      Toast.show(message, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  void _modalBottomSheetMenu(
      String id, String name, String price, String image, String qty) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
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
                                          pluscount(context);
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
                                          minuscount(context);
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
      Database_Add_To_Cart.columnqty: itemcount,
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

  void pluscount(BuildContext context) {
    Provider.of<CartFunctions>(context, listen:false).incrementCounter() ;
    /*_incrementnumber++;
    _incrementnumberset = _incrementnumber.toString();
    print(_incrementnumberset);*/
  }

  void minuscount(BuildContext context) {
    if (_incrementnumberset == "1") {
      print(_incrementnumberset);
    } else {
      Provider.of<CartFunctions>(context, listen:false).decrementCounter() ;
     /* _incrementnumber--;
      _incrementnumberset = _incrementnumber.toString();
      print(_incrementnumberset);*/
    }
  }

  Future<List<Checkout_model>> _getalldata(BuildContext context) async {
    final allRows = await dbHelper.queryAllRows();
    List<Checkout_model> users = [];
    for (var u in allRows) {
      user = Checkout_model(u["id"], u["name"], u["price"], u["qty"]);
      users.add(user);
    }
    setState(() {
      itemcount =  Provider.of<CartFunctions>(context, listen:false).cartCount ;                                    // users.length;
    });

    return users;
  }

  void checkoutpage() {
    Route route = MaterialPageRoute(builder: (context) => Checkout());
    Navigator.push(context, route);
  }

  void showdialog() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text("Are you sure\n do you want to clear cart?",
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            child: Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.orange,
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Cancel",
                                    textAlign: TextAlign.center,
                                    style: style.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Text("    "),
                          flex: 0,
                        ),
                        Expanded(
                          child: SizedBox(
                            child: Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.orange,
                              child: MaterialButton(
                                onPressed: () {
                                  dbHelper.cleanDatabase();
                                  Navigator.of(context).pop();
                                },
                                child: Text("Ok",
                                    textAlign: TextAlign.center,
                                    style: style.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ],
              );
            }),
          );
        });
  }

  void Emptyshowdialog() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text("Cart is empty",
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    onTap: () {},
                  ),
                  ListTile(
                    title: SizedBox(
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.orange,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Ok",
                              textAlign: TextAlign.center,
                              style: style.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              );
            }),
          );
        });
  }
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
            color: Colors.cyan,
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
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.black87,
                      onPressed: () {
                        Navigator.of(context).pop(); // To close the dialog
                      },
                      child: Text("Ok",
                          style: TextStyle(
                              color: Colors.white
                          )
                      ),
                    ),
                  ],
                ),
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

