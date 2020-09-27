import 'package:flutter/material.dart';

//my imports
import 'package:ugao/components/appbar.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPageName(
        pageName: 'My Orders',
      ),

      //============ORDERS LISTED=============
    );
  }
}
