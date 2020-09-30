import 'package:flutter/material.dart';

//my imports
import 'package:ugao/components/appbar.dart';
import 'package:ugao/Classes/Order_Model.dart';
import 'package:ugao/components/h3.dart';

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
            child: H3(
              textBody: "OrderID: \n" + widget.order.orderID,
            ),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Row inside Column
              SizedBox(height: 5),
              H3(textBody: "Service: " + widget.order.service),
              H3(textBody: "Payment: " + widget.order.paymentMethod),
              H3(
                  textBody:
                      "Quantity: " + widget.order.productQuantity.toString()),
              H3(
                  textBody: "Total Price: PKR " +
                      (widget.order.productQuantity *
                              widget.order.product.price)
                          .toString()),
              H3(textBody: "Customer Address: " + widget.order.address),
              H3(
                  textBody:
                      "Customer Contact: " + widget.order.customer.phone_no),
              H3(textBody: "Status: " + widget.order.status),
            ],
          ),
        ),
      ),
    );
  }
}
