import 'package:flutter/material.dart';

//my imports
import 'package:ugao/components/appbar.dart';
import '../../constants.dart';

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
