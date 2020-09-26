import 'package:flutter/material.dart';
import 'package:ugao/Classes/Cart_Product_Model.dart';
import 'package:ugao/Providers/general_provider.dart';
import 'package:provider/provider.dart';
import 'package:ugao/screens/cart/single_cart_product.dart';

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  @override
  Widget build(BuildContext context) {
    List<CartProduct> Products_on_the_cart =
        Provider.of<General_Provider>(context, listen: false).cart;

    return new ListView.builder(

        // =========== PRODUCTS IN CART =====================

        itemCount: Products_on_the_cart.length,
        itemBuilder: (context, index) {
          return Single_cart_product(
            cartIndex: index,
          );
        });
  }
}
