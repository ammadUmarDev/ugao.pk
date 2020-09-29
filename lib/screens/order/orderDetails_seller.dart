import 'package:flutter/material.dart';

//my imports
import 'package:ugao/components/appbar.dart';
import 'package:ugao/Classes/Order_Model.dart';

class OrderDetailsSeller extends StatefulWidget {
  @override
  final Order order;

  OrderDetailsSeller({Key key, this.order}) : super(key: key);
  _OrderDetailsSellerState createState() => _OrderDetailsSellerState();
}

class _OrderDetailsSellerState extends State<OrderDetailsSeller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPageName(
        pageName: 'Order Details',
      ),
      body: Card(
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
                    padding:
                        const EdgeInsets.only(left: 2.0, top: 8.0, bottom: 8.0),
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
                      child: Text("Customer Address: " + widget.order.address)),
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
    );
  }
}
