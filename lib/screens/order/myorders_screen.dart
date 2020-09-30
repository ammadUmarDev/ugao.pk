import 'package:flutter/material.dart';
//my imports
import 'package:ugao/components/appbar.dart';
import 'package:ugao/components/body_text.dart';
import 'package:ugao/components/h2.dart';
import 'package:ugao/components/h3.dart';
import 'package:ugao/screens/order/orders_details.dart';
import '../../constants.dart';
import 'package:ugao/Classes/Order_Model.dart';
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => orderDetails(
                                orderID: orders[index].orderID,
                              )),
                    );
                  },
                  highlightColor: kPrimaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10),
                        H2(
                          textBody: "Order Number: " + orders[index].orderID,
                        ),
                        SizedBox(height: 5),
                        H3(
                          textBody: "Service Type: " + orders[index].service,
                        ),
                        SizedBox(height: 5),
                        H3(
                          textBody: "Status: " + orders[index].status,
                        ),
                        Divider(),
                        SizedBox(height: 5),
                        BodyText(textBody: "Tap to view more details"),
                        SizedBox(height: 10),
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
    if (orderId == o[j].order) return false;
  }
  return true;
}
