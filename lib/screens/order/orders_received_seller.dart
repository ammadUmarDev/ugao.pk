import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//my imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ugao/Classes/Order_Model.dart';
import 'package:ugao/components/appbar.dart';
import 'package:ugao/components/h3.dart';
import 'package:ugao/screens/order/orderDetails_seller.dart';
import '../../constants.dart';
import 'package:ugao/Providers/general_provider.dart';
import 'package:provider/provider.dart';
import 'package:ugao/Classes/User_Model.dart';

class OrdersReceivedSeller extends StatefulWidget {
  @override
  _OrdersReceivedSellerState createState() => _OrdersReceivedSellerState();
}

class _OrdersReceivedSellerState extends State<OrdersReceivedSeller> {
  @override
  Widget build(BuildContext context) {
    User user =
        Provider.of<General_Provider>(context, listen: false).get_user();
    Widget allOrders = StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection("Orders")
            .where('sellerID', isEqualTo: user.cnic)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return H3(textBody: 'Error in fetching orders: ${snapshot.error}');
          }

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return H3(textBody: 'Not connected to the Stream or null');

            case ConnectionState.waiting:
              return H3(textBody: 'Awaiting for interaction');

            case ConnectionState.active:
              print("Stream has started but not finished");

              var totalOrdersCount = 0;
              List<DocumentSnapshot> orders;

              if (snapshot.hasData) {
                orders = snapshot.data.documents;
                totalOrdersCount = orders.length;

                if (totalOrdersCount > 0) {
                  return new ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return Container(
                        /*decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(1.0)),*/
                        child: Card(
                          color: kPrimaryLightColor,
                          child: InkWell(
                            onTap: () async {
                              Order order = Order();
                              await order.fromFirebaseDocument(orders[index]);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderDetailsSeller(
                                            order: order,
                                          )));
                            },
                            highlightColor: kPrimaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 4.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            "Order Number: " +
                                                orders[index]["orderID"]
                                                    .toString(),
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
                                    padding: const EdgeInsets.only(
                                        top: 4.0, bottom: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          orders[index]["service"].toString(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 2.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Receiver Address: ",
                                          style: new TextStyle(
                                            fontSize: 16.5,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            orders[index]["address"].toString(),
                                            style: new TextStyle(
                                                fontSize: 16.5,
                                                color: kPrimaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
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
                  );
                }
              }
              return new Center(
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                  ),
                  H3(
                    textBody: "No orders found.",
                  )
                ],
              ));

            case ConnectionState.done:
              return H3(textBody: 'All orders fetched');
          }

          return Container(
            child: H3(textBody: "No orders found."),
          );
        });
    return Scaffold(
      appBar: AppBarPageName(
        pageName: 'My Orders',
      ),
      body: allOrders,
    );
  }
}
