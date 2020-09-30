import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

//my imports
import 'package:ugao/components/appbar.dart';
import 'package:ugao/Classes/Order_Model.dart';
import 'package:ugao/components/button_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:ugao/Classes/Firebase_Functions.dart';
import 'package:ugao/components/h2.dart';
import 'package:ugao/components/rounded_drop_down.dart';
import 'package:ugao/constants.dart';

class OrderDetailsSeller extends StatefulWidget {
  @override
  final Order order;

  OrderDetailsSeller({Key key, this.order}) : super(key: key);
  _OrderDetailsSellerState createState() => _OrderDetailsSellerState();
}

class _OrderDetailsSellerState extends State<OrderDetailsSeller> {
  List<String> orderStatuses = [
    "Placed",
    "Confirmed",
    "Shipped/Ready",
    "Delivered/Picked Up",
  ];
  String newStatus="";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarPageName(
        pageName: 'Order Details',
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              // Leading Section
              leading: (widget.order.product.prodImage == null)
                  ? Text("No Image Found")
                  : new Image.network(
                widget.order.product.prodImage,
                width: 80.0,
                height: 80.0,
              ),
              title: Expanded(
                child: Text(
                  "OrderID: \n" + widget.order.orderID,
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
                        child: new Text(widget.order.service,
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
                          child: new Text(widget.order.paymentMethod,
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
                          widget.order.productQuantity.toString(),
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
                          (widget.order.productQuantity *
                              widget.order.product.price)
                              .toString(),
                          style: TextStyle(color: Colors.green[300]),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                              "Customer Address: " + widget.order.address)),
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
                          child: Text("Customer Contact: " +
                              widget.order.customer.phone_no)),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      //price of product
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2.0, 10.0, 0.0, 2.0),
                        child: new Text(
                          "Status: " + widget.order.status,
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
          ),
          ButtonLoading(
            labelText: "Edit Status",
            onTap: () {
              Alert(
                  context: context,
                  title: "Select new status",
                  style: AlertStyle(
                    titleStyle: H2TextStyle(color: kPrimaryAccentColor),
                  ),
                  content: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButton<String>(
                        isExpanded: true,
                        isDense: false,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        hint: Text("Account Type",
                            style: TextStyle(fontSize: 15.5)),
                        value: newStatus,
                        onChanged: (String value) {
                          setState(() {
                            newStatus = value;
                          });
                        },
                        items: orderStatuses.map((String user) {
                          return DropdownMenuItem<String>(
                            value: user,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  user,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15.5,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ButtonLoading(
                        onTap: () async {},
                        labelText: 'Update Status',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  buttons: [
                    DialogButton(
                      color: Colors.white,
                      height: 0,
                    ),
                  ]).show();
            },
          ),
        ],
      ),
    );
  }
}
