import 'package:ugao/Classes/Product_Model_Fetch.dart';

class Order {
  String orderID;
  ProductFetch product;
  int productQuantity;
  String sellerID;
  String customerID;
  String address;

  Order(
      {this.product,
      this.address,
      this.customerID,
      this.orderID,
      this.productQuantity,
      this.sellerID});
}
