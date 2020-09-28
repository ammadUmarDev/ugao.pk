import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ugao/Classes/Cart_Product_Model.dart';
import 'package:ugao/Classes/Order_Model.dart';
import 'package:ugao/Providers/general_provider.dart';
import 'package:ugao/Classes/firebase_functions.dart';
// my own imports
import 'package:ugao/components/appbar.dart';
import 'package:ugao/components/rounded_button.dart';
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarPageName(
        pageName: 'Checkout',
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.025),
            Text(
              "Select Address & Payment Method",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: size.height * 0.11),
            RoundedButton(
              color: kPrimaryLightColor,
              text: "Default Address",
              textColor: Colors.white,
              press: () {
                setState(() {
                  this.new_add_check = false;
                });
              },
            ),
            RoundedButton(
              color: kPrimaryLightColor,
              text: "Add New Address",
              textColor: Colors.white,
              press: () {
                setState(() {
                  this.new_add_check = true;
                });
              },
            ),
            RoundedInputField(
                hintText: "Enter New Address",
                enabled: new_add_check,
                onChanged: (value) {
                  this.new_address = value;
                  setState(() {
                    this.new_address = value;
                  });
                }),
            //const SizedBox(height: 30.0),
            Row(),
            SizedBox(height: size.height * 0.07),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 30.0, 0.0, 30.0),
                  child: new Radio(
                    value: 0,
                    groupValue: 0,
                    activeColor: kPrimaryAccentColor,
                    onChanged: (int value) {},
                  ),
                ),
                new Text("Cash on Delivery",
                    style: TextStyle(color: Colors.black, fontSize: 18.0))
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: new MaterialButton(
                onPressed: () {
                  if (this.new_add_check) {
                    print("Entered");
                    Order orderobj = new Order();
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
                        CartProduct obj = Provider.of<General_Provider>(context,
                                listen: false)
                            .getCartProduct(i);
                        orderobj.product = obj.product;
                        orderobj.address = new_address.toString();
                        orderobj.paymentMethod = "Cash on Delivery";
                        orderobj.productQuantity = obj.quantity;
                        orderobj.status = "Placed";
                        orderobj.service = obj.serviceType;
                        orderobj.customerID = user.cnic.toString();
                        orderobj.sellerID = obj.product.creator.toString();
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
                    Order orderobj = new Order();
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
                        CartProduct obj = Provider.of<General_Provider>(context,
                                listen: false)
                            .getCartProduct(i);
                        orderobj.product = obj.product;
                        orderobj.address = defaultaddress;
                        orderobj.paymentMethod = "Cash on Delivery";
                        orderobj.productQuantity = obj.quantity;
                        orderobj.status = "Placed";
                        orderobj.service = obj.serviceType;
                        orderobj.customerID = user.cnic.toString();
                        orderobj.sellerID = obj.product.creator.toString();
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
                              orderAddress: defaultaddress)),
                    );
                  }
                },
                child: new Text(
                  "Confirm Order",
                  style: TextStyle(color: Colors.white),
                ),
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
