import 'package:flutter/material.dart';

//my imports
import 'package:ugao/components/appbar.dart';

class orderConfirmed extends StatefulWidget {
  String order_address;

  orderConfirmed({Key key, this.order_address}) : super(key: key);

  @override
  _orderConfirmedState createState() =>
      _orderConfirmedState(add: this.order_address);
}

class _orderConfirmedState extends State<orderConfirmed> {
  String order_address;

  _orderConfirmedState({Key key, String add}) : this.order_address = add;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBarPageName(
          pageName: 'Checkout',
        ),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Address:" + this.order_address),
          ],
        )));
  }
}
