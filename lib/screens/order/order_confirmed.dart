import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ugao/Classes/Order_Model.dart';
import 'package:ugao/Providers/general_provider.dart';

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
  //Order orderObj;
  String add;

  _OrderConfirmedScreenState({Key key, String add}) {
    //this.orderObj.address = add;
    this.add = add;
    Provider.of<General_Provider>(context, listen: false).clearCart();
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
            SizedBox(height: size.height * 0.1),
            Text(
              "Order \n Placed",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36.0,
              ),
            ),
            SizedBox(height: size.height * 0.1),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Check My Orders for more details",
                    //textAlign: TextAlign.center,
                    //overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 24.0,
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
