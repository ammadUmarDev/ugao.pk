import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyProductsSeller extends StatefulWidget {
  @override
  _MyProductsSellerState createState() => _MyProductsSellerState();
}

class _MyProductsSellerState extends State<MyProductsSeller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Text("My Products Seller"),
            ],
          ),
        ),
      ),
    );
  }
}
