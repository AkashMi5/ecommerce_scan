import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ecommerce_scan/Screen/Final_checkout.dart';
import 'package:ecommerce_scan/Utils/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_scan/Utils/Database_Add_To_Cart.dart';
import 'package:ecommerce_scan/models/Checkout_model.dart';
import 'package:ecommerce_scan/models/Previous_order_model.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

import 'Previous_order_details.dart';
import 'package:ecommerce_scan/Utils/date_format.dart' ;

class Previous_order extends StatefulWidget {
  @override
  Previous_orderstate createState() => new Previous_orderstate();
}

class Previous_orderstate extends State<Previous_order> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text("Previous Orders",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
          child: Container(
            color: Colors.black12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: FutureBuilder(
                    future: _getUsers(),
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
                        return ListView.separated(
                            separatorBuilder: (context, index) {
                              if(index > 0){
                                return  DateFormatShop.changeFormat(snapshot.data[index-1].date)[1] != DateFormatShop.changeFormat(snapshot.data[index].date)[1] || index == 0  ?
                                Container(
                                    color: Colors.pink,
                                    child:
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20),
                                    child: Text(DateFormatShop.changeFormat(snapshot.data[index].date)[1],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18
                                    ),
                                    ),
                                  )
                                ) : Container() ;
                              }
                              else {
                                return Container(
                                    color: Colors.pink,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20),
                                      child: Text(DateFormatShop.changeFormat(snapshot.data[index].date)[1],
                                  style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18
                                  ),
                                ),
                                    )
                                ) ;
                               }
                              } ,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              if(index == 0){
                                return Container();
                              } else {
                                return Center(
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child:   ListTile(
                                        contentPadding: EdgeInsets.only(
                                            left: 5.0,
                                            right: 5.0,
                                            top: 0.0,
                                            bottom: 5.0),
                                        onTap: () {},
                                        subtitle: Container(
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                        EdgeInsets.fromLTRB(0.0,
                                                            0.0, 20.0, 0.0),
                                                        child: Text((index).toString(),
                                                            textAlign:
                                                            TextAlign.center,
                                                            style: style.copyWith(
                                                                color: Colors.black26,
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                fontSize: 20)),
                                                      ),
                                                      flex: 1,
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: <Widget>[
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                              Text(
                                                                  DateFormatShop.changeFormat(snapshot.data[index-1].date)[0],
                                                                  textAlign:
                                                                  TextAlign.center,
                                                                  style: style.copyWith(
                                                                      color: Colors.black54,
                                                                      fontWeight:
                                                                      FontWeight.bold,
                                                                      fontSize: 20)),
                                                              SizedBox(height: 5),
                                                              Text(
                                                                  DateFormatShop.changeFormat(snapshot.data[index-1].date)[4],
                                                                  textAlign:
                                                                  TextAlign.center,
                                                                  style: style.copyWith(
                                                                      color: Colors.grey,
                                                                      fontWeight:
                                                                      FontWeight.bold,
                                                                      fontStyle: FontStyle.italic,
                                                                      fontSize: 14)),

                                                                ]
                                                             ),
                                                          ],
                                                        ),
                                                      flex: 4,
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: Text(
                                                                "Rs. " + double.parse(snapshot
                                                                    .data[index-1].total).toStringAsFixed(2) ,
                                                                overflow: TextOverflow.ellipsis,
                                                                textAlign:
                                                                TextAlign.center,
                                                                style: style.copyWith(
                                                                    color: Colors.pinkAccent,
                                                                    fontWeight:
                                                                    FontWeight.bold,
                                                                    fontSize: 20)),
                                                          ),
                                                        ],
                                                      ),
                                                      flex: 2,
                                                    ),
                                                  /*  Expanded(
                                                      child: SizedBox(
                                                        child: Material(
                                                            color: Colors.white,
                                                            child: InkWell(
                                                              onTap: () {
                                                                Constants
                                                                    .PREVIOUS_ORDER_DETAILS__ORDER_ID =
                                                                    snapshot
                                                                        .data[index-1]
                                                                        .id;
                                                                Constants
                                                                    .PREVIOUS_ORDER_DETAILS_DATE =
                                                                    snapshot
                                                                        .data[index-1]
                                                                        .date;
                                                                Toast.show(
                                                                    snapshot
                                                                        .data[index-1]
                                                                        .total,
                                                                    context,
                                                                    duration: Toast
                                                                        .LENGTH_LONG,
                                                                    gravity: Toast
                                                                        .BOTTOM);
                                                                Route route =
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                        Previous_order_details());
                                                                Navigator.push(
                                                                    context, route);
                                                              },
                                                              child: Container(
                                                                child: ClipRRect(
                                                                  child: Icon(Icons
                                                                      .arrow_forward_ios),
                                                                  *//*width: 110.0, height: 110.0*//*
                                                                ),
                                                              ),
                                                            )),
                                                      ),
                                                      flex: 0,
                                                    ),*/
                                                  ],
                                                ),
                                                Divider(),
                                              ],
                                            )),
                                      ),
                                    ),
                                  ),
                                );
                              }

                            });
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

  Future<List<Previous_order_model>> _getUsers() async {
    List<Previous_order_model> previous_order_model = [];
    var url = Constants.PREVIOUS_ORDER;
//    var response1 = await http.post(url);
    var response1 = await post(url, body: {
      'userid': "3",
    });

    var jsonData = json.decode(response1.body);

    var usersData = jsonData["data"];
    print(usersData);
    for (var user in usersData) {
      Previous_order_model newUser = Previous_order_model(
        user["id"],
        user["date"],
        user["total"],
      );
      previous_order_model.add(newUser);
    }
    return previous_order_model;
  }
}
