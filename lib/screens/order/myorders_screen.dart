import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

//my imports
import 'package:ugao/components/appbar.dart';
import '../../constants.dart';
import 'package:ugao/Classes/Order_Model.dart';
import 'package:ugao/Classes/Cart_Product_Model.dart';
import 'package:ugao/Providers/general_provider.dart';
import 'package:provider/provider.dart';
import 'package:ugao/Classes/User_Model.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    /*uncomment this line and fetch all orders against user 
    List<Order> orders=*/
    //Size size = MediaQuery.of(context).size;
    User user =
        Provider.of<General_Provider>(context, listen: false).get_user();
    Provider.of<General_Provider>(context, listen: false).fetch_orders();
    List<Order> all_Orders =
        Provider.of<General_Provider>(context, listen: false).orders;
    List<Order> orders = [];
    for (var i = 0; i < all_Orders.length; i++) {
      if (all_Orders[i].customerID == user.cnic &&
          isNotInOrders(orders, all_Orders[i].orderID))
        orders.add(all_Orders[i]);
    }
    return Scaffold(
        appBar: AppBarPageName(
          pageName: 'My Orders',
        ),

        //============ORDERS LIST=============
        body: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return Container(
              /*decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(1.0)),*/
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
                              Expanded(
                                child: Text(
                                  "Order Number: " + orders[index].orderID,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
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
                                orders[index].service,
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
                                orders[index].status,
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

bool isNotInOrders(List o, String orderId) {
  for (var j = 0; j < o.length; j++) {
    if (orderId == o[j].orderID) return false;
  }
  return true;
}
