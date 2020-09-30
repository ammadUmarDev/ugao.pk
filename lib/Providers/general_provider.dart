import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ugao/Classes/Cart_Product_Model.dart';
import 'package:ugao/Classes/Firebase_Functions.dart';
import 'package:ugao/Classes/Order_Model.dart';
import 'package:ugao/Classes/Product_Model_Fetch.dart';
import 'package:ugao/Classes/User_Model.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: camel_case_types
class General_Provider extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  User user;
  FirebaseUser firebaseUser;
  List<Order> orders = [];
  List<CartProduct> cart = [];

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

  void addToCart(ProductFetch product, int quantity, String serviceType) {
    this.cart.add(CartProduct(
        product: product, quantity: quantity, serviceType: serviceType));
  }

  void clearCart() {
    this.cart.clear();
  }

  void set_user(User u) {
    this.user = u;
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

  Future<bool> fetch_orders() async {
    //this.orders.clear();
    Firestore firestore = Firestore.instance;
    var snapshot = await firestore
        .collection("Orders")
        //.where(idType + "==" + this.user.cnic)
        .getDocuments();
    if (snapshot.documents.length > 0) {
      for (var document in snapshot.documents) {
        Order obj = new Order();
        obj.product = new ProductFetch();
        obj.customerID = document["customerID"].toString();
        obj.customer = await getUser(obj.customerID);
        obj.address = document["address"].toString();
        obj.orderID = document["orderID"].toString();
        obj.paymentMethod = document["paymentMethod"].toString();
        obj.productQuantity = document["productQuantity"];
        obj.sellerID = document["sellerID"].toString();
        obj.service = document["service"].toString();
        obj.status = document["status"].toString();
        obj.product.creationTimestamp =
            DateTime.parse(document["creationTimestamp"]);
        obj.product.creator = document["creator"].toString();
        obj.product.documentID = document["documentID"].toString();
        obj.product.price = document["price"];
        obj.product.priceType = document["priceType"].toString();
        obj.product.prodCategory = document["productCategory"].toString();
        obj.product.prodDesc = document["prodDesc"].toString();
        obj.product.prodImage = document["prodImage"].toString();
        obj.product.prodName = document["prodName"].toString();
        obj.product.quantity = document["quantity"];
        obj.product.serviceType = document["serviceType"].toString();
        obj.product.weight = document["weight"];
        obj.product.weightUnit = document["weightUnits"];
        this.orders.add(obj);
        obj.printt();
      }
    }
  }
}
