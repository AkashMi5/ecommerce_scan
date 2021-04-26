//import 'package:cached_network_image/cached_network_image.dart';
//import 'package:flutter/material.dart';
//
//class ModalBottomSheet extends StatefulWidget {
//  ModalBottomSheet({Key key, this.title}) : super(key: key);
//  final String title;
//
//  @override
//  ModalBottomSheetstate createState() => new ModalBottomSheetstate();
//
//}
//class ModalBottomSheetstate extends State<ModalBottomSheet> {
//  @override
////  void initState() {
////    // TODO: implement initState
////    super.initState();
////    _modalBottomSheetMenu(id, name, price, image, qty)
////  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Container(
//        color: Colors.white,
//        child: Padding(
////          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
//          padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            mainAxisAlignment: MainAxisAlignment.start,
//            children: <Widget>[
//              Expanded(
//                child: ,
//                flex: 2,
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//
//
//
//}
//
//
//
//void _modalBottomSheetMenu(String id, String name, String price, String image, String qty) {
//  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
//  var context;
//  showModalBottomSheet(
//      context: context,
//      backgroundColor: Colors.white,
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.only(
//            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
//      ),
//      builder: (context) {
//        return Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          mainAxisSize: MainAxisSize.min,
//          children: <Widget>[
//            ListTile(
////                leading: Icon(Icons.clear),
//              title: Row(
//                children: <Widget>[
//                  Expanded(
//                    child: Material(
//                        color: Colors.white,
//                        child: InkWell(
//                          onTap: () {
//                            Navigator.of(context).pop();
//                          },
//                          child: Container(
//                            child: ClipRRect(
//                              child: Icon(Icons.clear),
//                              /*width: 110.0, height: 110.0*/
//                            ),
//                          ),
//                        )),
//                    flex: 1,
//                  ),
//                  Expanded(
//                    child: Text(name,
//                        textAlign: TextAlign.center,
//                        style: style.copyWith(
//                            color: Colors.black,
//                            fontWeight: FontWeight.bold)),
//                    flex: 10,
//                  )
//                ],
//              ),
//              onTap: () {},
//            ),
//            ListTile(
//              title: Center(
//                  child: Padding(
//                    padding: const EdgeInsets.all(10.0),
//                    child: SizedBox(
//                      height: 80,
//                      child: Material(
//                          color: Colors.white,
//                          child: InkWell(
//                            onTap: () {},
//                            child: Container(
//                              child: ClipRRect(
//                                child: CachedNetworkImage(
//                                  imageUrl: image,
//                                  fit: BoxFit.cover,
//                                ),
//                                /*width: 110.0, height: 110.0*/
//                              ),
//                            ),
//                          )),
//                    ),
//
//
//                  )),
//              onTap: () {},
//            ),
//            ListTile(
//              title: Row(
//                children: <Widget>[
//                  Expanded(
//                    child: Material(
//                        color: Colors.white,
//                        child: InkWell(
//                          onTap: () {},
//                          child: Container(
//                            child: Text('Price INR:' + " " + price,
//                                textAlign: TextAlign.center,
//                                style: style.copyWith(
//                                    color: Colors.black,
//                                    fontWeight: FontWeight.bold)),
//                            /*width: 110.0, height: 110.0*/
//                          ),
//                        )),
//                    flex: 1,
//                  ),
//                  Expanded(
//                    child: Text(''),
//                    flex: 1,
//                  ),
//                  Expanded(
//                    child: new Container(
//                      color: Colors.black,
////                        decoration: new BoxDecoration(
////                            color: Colors.white,
////                            borderRadius: new BorderRadius.only(
////                                topLeft: const Radius.circular(10.0),
////                                topRight: const Radius.circular(10.0))),
//
//                      child: Center(
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            Container(
//                              child: InputChip(
//                                label: const Text(
//                                  "-",
//                                  textDirection: TextDirection.ltr,
//                                  textAlign: TextAlign.left,
//                                  style: TextStyle(
//                                    fontWeight: FontWeight.bold,
//                                    color: Colors.white,
//                                  ),
//                                ),
//                                onPressed: () {
//
//                                },
//                              ),
//                            ),
//                            FlatButton(
//                                onPressed: () {},
//                                child: Text(
//                                  "1",
//                                  textDirection: TextDirection.ltr,
//                                  textAlign: TextAlign.left,
//                                  style: TextStyle(
//                                      fontWeight: FontWeight.bold,
//                                      color: Colors.white),
//                                )),
//                            Container(
//                              child: InputChip(
//                                label: const Text(
//                                  "+",
//                                  textDirection: TextDirection.ltr,
//                                  textAlign: TextAlign.left,
//                                  style: TextStyle(
//                                    fontWeight: FontWeight.bold,
//                                    color: Colors.white,
//                                  ),
//                                ),
//                                onPressed: () {},
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
//                    flex: 2,
//                  )
//                ],
//              ),
//              onTap: () {},
//            ),
//            ListTile(
//              title: Container(
//                decoration: new BoxDecoration(
//                    color: Colors.white,
//                    borderRadius: new BorderRadius.only(
//                        topLeft: const Radius.circular(0.0),
//                        topRight: const Radius.circular(0.0))),
//                child: new Center(
//                  child: new Material(
//                    elevation: 5.0,
//                    borderRadius: BorderRadius.circular(30.0),
//                    color: Colors.orange,
//                    child: MaterialButton(
//                      minWidth: MediaQuery
//                          .of(context)
//                          .size
//                          .width,
//                      onPressed: () {
//                        Navigator.of(context).pop();
//                      },
//                      child: Text("Add To Cart",
//                          textAlign: TextAlign.center,
//                          style: style.copyWith(
//                              color: Colors.white,
//                              fontWeight: FontWeight.bold)),
//                    ),
//                  ),
//                ),
//              ),
//              onTap: () {},
//            ),
//          ],
//        );
//      });
//}
//
