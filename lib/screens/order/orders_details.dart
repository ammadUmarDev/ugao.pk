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
import 'package:ugao/components/appbar.dart';
import '../../constants.dart';
import 'package:ugao/Classes/Cart_Product_Model.dart';
import 'package:ugao/Providers/general_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ugao/components/body_text.dart';
import 'package:ugao/components/h2.dart';
import 'package:ugao/components/h3.dart';

class orderDetails extends StatefulWidget {
  @override
  final String orderID;

  orderDetails({Key key, this.orderID}) : super(key: key);
  _orderDetailsState createState() => _orderDetailsState(orderID: this.orderID);
}

class _orderDetailsState extends State<orderDetails> {
  @override
  User user;
  String description = "Null";
  //String userImagePath;
  String orderID;
  Order selectedOrder;

  _orderDetailsState({Key key, String orderID}) {
    this.orderID = orderID;
  }

  Widget build(BuildContext context) {
    Provider.of<General_Provider>(context, listen: false).fetch_orders();
    List<Order> all_Orders =
        Provider.of<General_Provider>(context, listen: false).orders;
    for (var i = 0; i < all_Orders.length; i++) {
      if (all_Orders[i].orderID == this.orderID) {
        selectedOrder = all_Orders[i];
        break;
      }
    }
    return Scaffold(
      appBar: AppBarPageName(
        pageName: 'Order Details',
      ),
      body: ListView.builder(
        // =========== ORDER DETAILS =====================
        itemCount: 1,
        itemBuilder: (context, index) {
          return (Card(
            child: ListTile(
              // Leading Section
              leading: new Image.network(
                selectedOrder.product.prodImage,
                width: 80.0,
                height: 80.0,
              ),
              title: Expanded(
                child: Text(
                  "OrderID: \n" + selectedOrder.orderID,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              subtitle: new Column(
                children: <Widget>[
                  //Row inside Column
                  new Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                        child: new Text("Service:"),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2.0, 8.0, 10.0, 8.0),
                        child: new Text(selectedOrder.service,
                            style: TextStyle(color: Colors.green[300])),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                        child: new Text("Payment:"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 2.0, top: 8.0, bottom: 8.0),
                        child: Expanded(
                          child: new Text(selectedOrder.paymentMethod,
                              style: TextStyle(color: Colors.green[300])),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      //qty of product
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 8.0),
                        child: new Text("Quantity:"),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2.0, 2.0, 5.0, 8.0),
                        child: new Text(
                          selectedOrder.productQuantity.toString(),
                          style: TextStyle(color: Colors.green[300]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(26.5, 2.0, 0.0, 8.0),
                        child: new Text("Total Price:"),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2.0, 2.0, 0.0, 8.0),
                        child: new Text(
                          (selectedOrder.productQuantity *
                                  selectedOrder.product.price)
                              .toString(),
                          style: TextStyle(color: Colors.green[300]),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      Expanded(child: Text("Seller Address: Fetch Address")),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      Padding(padding: const EdgeInsets.all(4.0)),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      Expanded(
                          child: Text("Seller Contact: Fetch Phone Number")),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      //price of product
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2.0, 10.0, 0.0, 2.0),
                        child: new Text(
                          "Status: " + selectedOrder.status,
                          style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[300]),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ));
        },
      ),
    );
  }
}
