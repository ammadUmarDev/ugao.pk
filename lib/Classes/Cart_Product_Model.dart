import 'package:flutter/cupertino.dart';

import 'Product_Model_Fetch.dart';

class CartProduct {
  ProductFetch product;
  int quantity;
  String serviceType;

  CartProduct({@required this.product,this.quantity,@required this.serviceType});
}
