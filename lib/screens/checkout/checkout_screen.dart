import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ugao/Classes/Cart_Product_Model.dart';
import 'package:ugao/Classes/Order_Model.dart';
import 'package:ugao/Providers/general_provider.dart';
import 'package:ugao/Classes/firebase_functions.dart';
// my own imports
import 'package:ugao/components/appbar.dart';
import 'package:ugao/components/body_text.dart';
import 'package:ugao/components/h1.dart';
import 'package:ugao/components/h2.dart';
import 'package:ugao/components/h3.dart';
import 'package:ugao/components/rounded_button.dart';
import 'package:ugao/screens/dashboard/components/main_background.dart';
import '../../constants.dart';
import 'package:ugao/components/rounded_input_field.dart';
import 'package:ugao/screens/order/order_confirmed.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool new_add_check = false;
  var new_address;
  List<String> addressChoiceList = <String>[
    "Default Address",
    "Add New Address"
  ];
  String addressChoice;

  List<String> paymentChoiceList = <String>[
    "Cash on Delivery",
    "Easypaisa",
    "Jazz Cash",
    "Bank Transfer"
  ];
  String paymentChoice;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarPageName(
        pageName: 'Order Details',
      ),
      body: SafeArea(
        child: CustomPaint(
          painter: MainBackground(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                H2(
                  textBody: "Select Billing and Shipping Address",
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  isDense: false,
                  style: H2TextStyle(),
                  hint: Text("Choose Address"),
                  value: addressChoice,
                  onChanged: (String value) {
                    setState(() {
                      addressChoice = value;
                      if (addressChoice == "Default Address") {
                        this.new_add_check = false;
                      } else {
                        this.new_add_check = true;
                      }
                    });
                  },
                  items: addressChoiceList.map((String choice) {
                    return DropdownMenuItem<String>(
                      value: choice,
                      child: H2(
                        textBody: choice,
                        color: kPrimaryAccentColor,
                      ),
                    );
                  }).toList(),
                ),
                RoundedInputField(
                    hintText: "Enter New Address",
                    enabled: new_add_check,
                    icon: FontAwesomeIcons.addressBook,
                    onChanged: (value) {
                      this.new_address = value;
                      setState(() {
                        this.new_address = value;
                      });
                    }),
                SizedBox(height: 20),
                H2(
                  textBody: "Select Payment Method",
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  isDense: false,
                  style: H2TextStyle(),
                  hint: Text("Choose Pyament Method"),
                  value: paymentChoice,
                  onChanged: (String value) {
                    setState(() {
                      paymentChoice = "Cash on Delivery";
                      if (paymentChoice != "Cash on Delivery") {
                        Alert(
                            context: context,
                            title: "Oops",
                            style: AlertStyle(
                              titleStyle:
                                  H2TextStyle(color: kPrimaryAccentColor),
                            ),
                            content: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                H3(
                                    textBody:
                                        "Only cash on delivery is available :("),
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
                      }
                    });
                  },
                  items: paymentChoiceList.map((String choice) {
                    return DropdownMenuItem<String>(
                      value: choice,
                      child: H2(
                        textBody: choice,
                        color: kPrimaryAccentColor,
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                BodyText(textBody: "Only cash on delivery is available :("),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.white,
                kPrimaryLightColor,
              ],
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
                color: kPrimaryAccentColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                border: Border.all(
                  width: 3,
                  color: kPrimaryAccentColor,
                  style: BorderStyle.solid,
                )),
            child: MaterialButton(
              onPressed: () {
                if (this.new_add_check) {
                  print("Entered");
                  Order orderobj = Order();
                  var user =
                      Provider.of<General_Provider>(context, listen: false)
                          .get_user();
                  String defaultaddress = "None";
                  if (user.usertype == "Farmer") {
                    defaultaddress = user.farmer.fAddress;
                  }
                  if (user.usertype == "Customer") {
                    defaultaddress = "None";
                  }
                  if (user.usertype == "Supplier") {
                    defaultaddress = user.supplier.sAddress;
                  }
                  //Variables Needed for firebase storage

                  var size =
                      Provider.of<General_Provider>(context, listen: false)
                          .cart
                          .length;
                  if (size > 0) {
                    print("The size is:");
                    print(size);
                    for (int i = 0; i < size; i++) {
                      CartProduct obj =
                          Provider.of<General_Provider>(context, listen: false)
                              .getCartProduct(i);

                      orderobj.product = obj.product;
                      orderobj.address = new_address.toString();
                      orderobj.paymentMethod = "Cash on Delivery";
                      orderobj.productQuantity = obj.quantity;
                      orderobj.status = "Placed";
                      orderobj.service = obj.serviceType;
                      orderobj.customerID = user.cnic.toString();
                      orderobj.sellerID = obj.product.creator.toString();
                      orderobj.product.creationTimestamp = DateTime.now();
                      orderobj.orderID = obj.product.documentID +
                          "-" +
                          obj.product.creationTimestamp.millisecondsSinceEpoch
                              .toString();
                      order_Store(orderobj);
                    }
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderConfirmedScreen(
                            orderAddress: this.new_address)),
                  );
                } else {
                  Order orderobj = Order();
                  var user =
                      Provider.of<General_Provider>(context, listen: false)
                          .get_user();
                  String defaultaddress = "None";
                  if (user.usertype == "Farmer") {
                    defaultaddress = user.farmer.fAddress;
                  }
                  if (user.usertype == "Customer") {
                    defaultaddress = "None";
                  }
                  if (user.usertype == "Supplier") {
                    defaultaddress = user.supplier.sAddress;
                  }
                  //Variables Needed for firebase storage

                  var size =
                      Provider.of<General_Provider>(context, listen: false)
                          .cart
                          .length;
                  if (size > 0) {
                    print("The size is:");
                    print(size);
                    for (int i = 0; i < size; i++) {
                      CartProduct obj =
                          Provider.of<General_Provider>(context, listen: false)
                              .getCartProduct(i);
                      orderobj.product = obj.product;
                      orderobj.address = defaultaddress;
                      orderobj.paymentMethod = "Cash on Delivery";
                      orderobj.productQuantity = obj.quantity;
                      orderobj.status = "Placed";
                      orderobj.service = obj.serviceType;
                      orderobj.customerID = user.cnic.toString();
                      orderobj.sellerID = obj.product.creator.toString();
                      orderobj.product.creationTimestamp = DateTime.now();
                      orderobj.orderID = obj.product.documentID +
                          "-" +
                          obj.product.creationTimestamp.millisecondsSinceEpoch
                              .toString();
                      order_Store(orderobj);
                    }
                  }
                  Alert(
                      context: context,
                      title: "Order Confirmed :)",
                      style: AlertStyle(
                        titleStyle: H2TextStyle(color: kPrimaryAccentColor),
                      ),
                      content: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Your Order is Confirmed :D\nGo to 'My Orders' to see the details.\nContinue Shopping :D ",
                            style: H3TextStyle(),
                            textAlign: TextAlign.center,
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
                }
              },
              child: H2(
                textBody: "Confirm Order",
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
