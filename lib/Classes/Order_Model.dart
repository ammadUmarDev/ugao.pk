import 'package:ugao/Classes/Product_Model_Fetch.dart';

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
}
