import 'package:flutter/material.dart';

class CartFunctions extends ChangeNotifier {

  int cartItems = 0 ;

  int get cartCount {
    return cartItems ;
  }

    setCartCount(int count) {
    cartItems = count ;

    notifyListeners();
  }

  int incrementCounter() {

   cartItems = cartItems + 1;

    notifyListeners() ;

}

 int decrementCounter() {

   cartItems = cartItems - 1;

   notifyListeners() ;

 }


}