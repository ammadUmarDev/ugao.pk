import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//my imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ugao/Classes/Order_Model.dart';
import 'package:ugao/components/appbar.dart';
import 'package:ugao/components/h2.dart';
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 10),
                                  H2(
                                    textBody: "Order Number: " +
                                        orders[index]["orderID"].toString(),
                                  ),
                                  SizedBox(height: 5),
                                  H3(
                                    textBody: "Timestamp: " +
                                        orders[index]["creationTimestamp"]
                                            .toString()
                                            .substring(0, 19),
                                  ),
                                  SizedBox(height: 5),
                                  H3(
                                    textBody: "Service Type: " +
                                        orders[index]["service"].toString(),
                                  ),
                                  SizedBox(height: 5),
                                  H3(
                                    textBody: "Customer Address: " +
                                        orders[index]["address"].toString(),
                                  ),
                                  Divider(),
                                  SizedBox(height: 5),
                                  H3(textBody: "Tap to view more details"),
                                  SizedBox(height: 10),
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
