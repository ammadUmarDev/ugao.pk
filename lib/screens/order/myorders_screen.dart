import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

//my imports
import 'package:ugao/components/appbar.dart';
import '../../constants.dart';
import 'package:ugao/Classes/Order_Model.dart';
import 'package:ugao/Classes/Cart_Product_Model.dart';
import 'package:ugao/Providers/general_provider.dart';
import 'package:provider/provider.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  ///=====temporary order list - remove once backend implemented========
  var orders_test = [
    {
      'orderID': 1,
      'productName': 'Fertilizer',
      'status': 'Shipped',
      'service': 'Delivery',
      'address': 'House',
      'qty': 2,
      'payment': 'COD',
      'date': '9/28/2020',
    },
  ];
  @override
  Widget build(BuildContext context) {
    /*uncomment this line and fetch all orders against user 
    List<Order> orders=*/
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBarPageName(
          pageName: 'My Orders',
        ),

        //============ORDERS LIST=============
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(1.0)),
              child: Card(
                color: kPrimaryLightColor,
                child: InkWell(
                  onTap: () {},
                  highlightColor: kPrimaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Order Number: " +
                                    orders_test[index]['orderID'].toString(),
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 4.0, bottom: 10.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                orders_test[index]['date'],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Status: ",
                                style: new TextStyle(
                                  fontSize: 16.5,
                                ),
                              ),
                              Text(
                                orders_test[index]['status'],
                                style: new TextStyle(
                                    fontSize: 16.5,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
