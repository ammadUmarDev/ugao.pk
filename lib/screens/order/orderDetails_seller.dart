import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ugao/Classes/Firebase_Functions.dart';

//my imports
import 'package:ugao/components/appbar.dart';
import 'package:ugao/Classes/Order_Model.dart';
import 'package:ugao/components/button_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:ugao/components/h2.dart';
import 'package:ugao/components/h3.dart';
import 'package:ugao/constants.dart';
import 'package:ugao/components/rounded_drop_down.dart';

class OrderDetailsSeller extends StatefulWidget {
  @override
  final Order order;

  OrderDetailsSeller({Key key, this.order}) : super(key: key);
  _OrderDetailsSellerState createState() => _OrderDetailsSellerState(order);
}

class _OrderDetailsSellerState extends State<OrderDetailsSeller> {
  List<String> orderStatuses = [
    "Placed",
    "Confirmed",
    "Shipped/Ready",
    "Delivered/Picked Up",
  ];
  Order order;
  String newStatus;

  _OrderDetailsSellerState(this.order);

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
                child: H3(
                  textBody: "OrderID: \n" + widget.order.orderID,
                ),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //Row inside Column
                  Divider(),
                  H3(textBody: "Service: " + widget.order.service),
                  H3(textBody: "Payment: " + widget.order.paymentMethod),
                  H3(
                      textBody: "Quantity: " +
                          widget.order.productQuantity.toString()),
                  H3(
                      textBody: "Total Price: PKR " +
                          (widget.order.productQuantity *
                                  widget.order.product.price)
                              .toString()),
                  H3(textBody: "Customer Address: " + widget.order.address),
                  H3(
                      textBody: "Customer Contact: " +
                          widget.order.customer.phone_no),
                  H3(textBody: "Status: " + widget.order.status),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: ButtonLoading(
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
                        RoundedDropDown(
                          name: "Account Type",
                          size: size,
                          text: newStatus,
                          value: newStatus,
                          onChanged: (String value) {
                            setState(() {
                              newStatus = value;
                            });
                          },
                          items: orderStatuses,
                          icon: Icons.departure_board,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ButtonLoading(
                          onTap: () async {
                            this.order.status = newStatus;
                            order_Store(this.order);
                            Alert(
                                context: context,
                                title: "Order Status updated",
                                style: AlertStyle(
                                  titleStyle:
                                      H2TextStyle(color: kPrimaryAccentColor),
                                ),
                                content: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ButtonLoading(
                                      onTap: () async {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      labelText: 'OK',
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
          ),
        ],
      ),
    );
  }
}
