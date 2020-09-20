import 'package:flutter/material.dart';

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
            /*Positioned(
              //bottom: 0,
              child: Image.asset(
                "assets/images/bp6.png",
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
                //width: size.width,
              ),
            ),*/
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              orderConfirmed(order_address: this.new_address)),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              orderConfirmed(order_address: "")),
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
