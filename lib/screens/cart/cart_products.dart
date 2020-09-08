import 'package:flutter/material.dart';
import 'package:ugao/Classes/Cart_Product_Model.dart';
import 'package:ugao/Providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:ugao/Classes/User_Model.dart';
import 'package:ugao/Classes/Product_Model_Fetch.dart';
import 'package:ugao/screens/cart/single_cart_product.dart';

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  List<CartProduct> Products_on_the_cart = [
    CartProduct(
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
        serviceType: "Delivery"),
  ];

  @override
  Widget build(BuildContext context) {
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
