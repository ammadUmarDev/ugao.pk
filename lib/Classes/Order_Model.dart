import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:ugao/Classes/Product_Model_Fetch.dart';

import 'Firebase_Functions.dart';
import 'User_Model.dart';

class Order {
  String orderID;
  ProductFetch product;
  int productQuantity;
  String sellerID;
  String customerID;
  String address;
  String paymentMethod;
  String status;
  String service;
  User customer;

  Order(
      {this.product,
      this.address,
      this.customerID,
      this.orderID,
      this.productQuantity,
      this.sellerID,
      this.paymentMethod,
      this.status,
      this.service});
  void printt() {
    print(orderID);
    print(productQuantity);
    print(sellerID);
    print(customerID);
    print(address);
    print(paymentMethod);
    print(status);
    print(service);
    product.printt();
  }

  Future<void> fromFirebaseDocument(DocumentSnapshot document) async {
    this.product = new ProductFetch();
    this.customerID = document["customerID"].toString();
    this.customer = await getUser(this.customerID);
    this.address = document["address"].toString();
    this.orderID = document["orderID"].toString();
    this.paymentMethod = document["paymentMethod"].toString();
    this.productQuantity = document["productQuantity"];
    this.sellerID = document["sellerID"].toString();
    this.service = document["service"].toString();
    this.status = document["status"].toString();
    this.product.creationTimestamp =
        DateTime.parse(document["creationTimestamp"]);
    this.product.creator = document["creator"].toString();
    this.product.documentID = document["documentID"].toString();
    this.product.price = document["price"];
    this.product.priceType = document["priceType"].toString();
    this.product.prodCategory = document["productCategory"].toString();
    this.product.prodDesc = document["prodDesc"].toString();
    this.product.prodImage = document["prodImage"].toString();
    this.product.prodName = document["prodName"].toString();
    this.product.quantity = document["quantity"];
    this.product.serviceType = document["serviceType"].toString();
    this.product.weight = document["weight"];
    this.product.weightUnit = document["weightUnits"];
  }
}
