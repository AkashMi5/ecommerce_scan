import 'dart:async';
import 'dart:convert';
import 'dart:convert' show json;
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_scan/Utils/Constants.dart';
import 'package:ecommerce_scan/Utils/Database_Add_To_Cart.dart';
import 'package:ecommerce_scan/models/Loose_item_model.dart';
import 'package:http/http.dart' as http;
import 'package:rich_alert/rich_alert.dart';
import 'package:toast/toast.dart';
import 'package:ecommerce_scan/ViewModels/cart_functions.dart' ;
import 'package:provider/provider.dart';

class Loose_item_barcode extends StatefulWidget {
  @override
  Loose_item_barcodestate createState() => new Loose_item_barcodestate();
}

class Loose_item_barcodestate extends State<Loose_item_barcode>
    with AutomaticKeepAliveClientMixin<Loose_item_barcode> {

  final dbHelper = Database_Add_To_Cart.instance;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  int _incrementnumber;
  String _incrementnumberset = "";
  int itemcount  ;

  @override
  void initState() {
    super.initState();

    _getUsers();
  }

  Future<List<loose_item_model>> _getUsers() async {
    List<loose_item_model> loose_item = [];
    var url = Constants.LOOSE_ITEM_BARCODE;
    var response1 = await http.post(url);
    var jsonData = json.decode(response1.body);
    var usersData = jsonData["data"];
    print(usersData);
    print('Data Old: ' + usersData.toString());
    for (var user in usersData) {
      loose_item_model newUser = loose_item_model(
        user["name"],
        user["image"],
        user["price"],
        user["product_code"],
        user["quantity"],
      );
      loose_item.add(newUser);
    }
    return loose_item;
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text("Loose Item Barcode",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding:
                  EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  child: Icon(Icons.shopping_cart, color: Colors.black, size: 30)
                /*Text(
                            "Cart",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.black),
                          ),*/
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Consumer<CartFunctions>(
                  builder: (context, cart, child) {
                    return Text('${cart.cartCount}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.black));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: new Container(
        child: FutureBuilder(
            future: _getUsers(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    // child: Text("Loading..."),
                    child: Image.asset(
                      'images/loading.gif',
                      width: 50.0,
                      height: 50.0,
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              (orientation == Orientation.portrait) ? 3 : 4),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          ),
                          elevation: 5.0,
                          color: Color(0xFFFFFFFF),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 6,
                                  ),
                                  SizedBox(
                                    height: 65,
                                    child: Material(
                                        color: Colors.white,
                                        child: InkWell(
                                          onTap: () {
                                            Toast.show(
                                                snapshot.data[index].name,
                                                context,
                                                duration: Toast.LENGTH_SHORT,
                                                gravity: Toast.CENTER);

                                            String image =
                                                snapshot.data[index].image;
                                            String Price =
                                                snapshot.data[index].price;
                                            String txt =
                                                snapshot.data[index].name;
                                            String qty =
                                                snapshot.data[index].quantity;

                                            showBottomSheel(
                                                image, txt, Price, qty);
                                            _getnumber();
                                          },
                                          child: Container(
                                            child: ClipRRect(
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    snapshot.data[index].image,
//                                          width: 70.0,
//                                          height: 70.0,
                                                fit: BoxFit.cover,
                                              ),
                                              /*width: 110.0, height: 110.0*/
                                            ),
                                          ),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    snapshot.data[index].name,
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }
            }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

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

  void showBottomSheel(String image, String txt, String price, String qty) {
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
                          child: Text(txt,
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
                              _save(image, txt, price, itemcount.toString());
//                              Navigator.of(context).pop();
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

  void _getnumber() {
    _incrementnumber = 1;
    itemcount = _incrementnumber ;
    _incrementnumberset = _incrementnumber.toString();
    print("xx "+ itemcount.toString());
  }

  void pluscount() {
  //  Provider.of<CartFunctions>(context, listen:false).incrementCounter() ;
    _incrementnumber++ ;
    _incrementnumberset = _incrementnumber.toString();
    itemcount = _incrementnumber ;
   /* _incrementnumber++;
    _incrementnumberset = _incrementnumber.toString();
    print(_incrementnumberset);*/

  }

  void minuscount() {
    if (_incrementnumberset == "1") {
      print(_incrementnumberset);
    } else {
  //    Provider.of<CartFunctions>(context, listen:false).decrementCounter() ;
      _incrementnumber--;
      _incrementnumberset = _incrementnumber.toString();
      itemcount = _incrementnumber ;
     /* _incrementnumber--;
      _incrementnumberset = _incrementnumber.toString();
      print(_incrementnumberset);*/
    }
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

    int latestCount = Provider.of<CartFunctions>(context, listen:false).cartCount ;
    int newCount = latestCount + itemcount ;
    print("New count" + newCount.toString());
    Provider.of<CartFunctions>(context, listen:false).setCartCount(newCount) ;

    itemcount = 0 ;

    Navigator.of(context).pop();
  }
}

/*showModalBottomSheet(
  context: context,
  builder: (BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (BuildContext context) {
        bool b = false;
        return StatefulBuilder(
          builder: (BuildContext context, setState) => Switch(
            onChanged: (bool v) {
              setState(() => b = v);
            },
            value: b,
          ),
        );
      },
    );
  },
);*/
