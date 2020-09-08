import 'package:flutter/cupertino.dart';
import 'package:ugao/Classes/Cart_Product_Model.dart';
import 'package:ugao/Classes/Product_Model_Fetch.dart';
import 'package:ugao/Classes/User_Model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

// ignore: camel_case_types
class General_Provider extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  User user;
  FirebaseUser firebaseUser;
  List<CartProduct> cart = [
    /*CartProduct(
        product: ProductFetch(
            prodName: "Green Up Lawn Fertilizer",
            prodImage:
                "https://firebasestorage.googleapis.com/v0/b/ugao-58f32.appspot.com/o/data%2Fuser%2F0%2Fcom.vectech.ugao%2Fcache%2Fimage_picker2573009106067769771.jpg?alt=media&token=06f7a0c2-7cfb-4855-9b3b-3246e710331d",
            price: 4000),
        quantity: 5,
        serviceType: "Delivery"),
    CartProduct(
        product: ProductFetch(
            prodName: "Green Up Lawn Fertilizer",
            prodImage:
                "https://firebasestorage.googleapis.com/v0/b/ugao-58f32.appspot.com/o/data%2Fuser%2F0%2Fcom.vectech.ugao%2Fcache%2Fimage_picker2573009106067769771.jpg?alt=media&token=06f7a0c2-7cfb-4855-9b3b-3246e710331d",
            price: 4000),
        quantity: 2,
        serviceType: "Pickup"),
    CartProduct(
        product: ProductFetch(
            prodName: "Green Up Lawn Fertilizer",
            prodImage:
                "https://firebasestorage.googleapis.com/v0/b/ugao-58f32.appspot.com/o/data%2Fuser%2F0%2Fcom.vectech.ugao%2Fcache%2Fimage_picker2573009106067769771.jpg?alt=media&token=06f7a0c2-7cfb-4855-9b3b-3246e710331d",
            price: 4000),
        quantity: 5,
        serviceType: "Delivery"),*/
  ];

  CartProduct getCartProduct(int index) {
    return cart[index];
  }

  void incrementInCart(int index) {
    cart[index].quantity += 1;
  }

  void decrementInCart(int index) {
    cart[index].quantity -= 1;
  }

  User get_user() {
    if (user == null) {
      print("User has not been set yet");
    }
    return user;
  }

  void addToCart(ProductFetch product, int quantity, String serviceType)
  {
    this.cart.add(CartProduct(product: product,quantity: quantity,serviceType: serviceType));
  }

  void set_user(User u) {
    this.user = u;
    /*const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    this.user.pass = String.fromCharCodes(Iterable.generate(
        5, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));*/
  }

  FirebaseUser get_firebase_user() {
    if (firebaseUser == null) {
      print("Firebase user has not been set yet");
    }
    return firebaseUser;
  }

  void set_firebase_user(FirebaseUser u) {
    this.firebaseUser = u;
  }
}
