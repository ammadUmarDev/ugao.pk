import 'package:flutter/material.dart';
import 'package:ugao/Classes/Order_Model.dart';

//my imports
import 'package:ugao/components/appbar.dart';

class OrderConfirmedScreen extends StatefulWidget {
  final String orderAddress;

  OrderConfirmedScreen({Key key, this.orderAddress}) : super(key: key);

  @override
  _OrderConfirmedScreenState createState() =>
      _OrderConfirmedScreenState(add: this.orderAddress);
}

class _OrderConfirmedScreenState extends State<OrderConfirmedScreen> {
  Order orderObj;

  _OrderConfirmedScreenState({Key key, String add}) {
    this.orderObj.address = add;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBarPageName(
          pageName: 'Order Confirmed',
        ),
        //backgroundColor: kPrimaryLightColor,
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.05),
            Text(
              "Order #<Insert Order Number> \n CONFIRMED",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.8, vertical: size.height * 0.2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Colors.blueGrey,
                  )),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Order Summary",
                    //textAlign: TextAlign.center,
                    //overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.11),
            //Row(),
          ],
        )));
  }
}
