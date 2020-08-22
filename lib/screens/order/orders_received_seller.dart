import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrdersReceivedSeller extends StatefulWidget {
  @override
  _OrdersReceivedSellerState createState() => _OrdersReceivedSellerState();
}

class _OrdersReceivedSellerState extends State<OrdersReceivedSeller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Text("Orders Received Seller"),
            ],
          ),
        ),
      ),
    );
  }
}
