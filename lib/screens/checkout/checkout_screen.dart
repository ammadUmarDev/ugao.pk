import 'package:flutter/material.dart';

// my own imports
import 'package:ugao/components/appbar.dart';
import 'package:ugao/components/rounded_bordered_container.dart';
import 'package:ugao/components/rounded_button.dart';
import '../../constants.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPageName(
        pageName: 'Checkout',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              "Select Address and Payment Method",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            const SizedBox(height: 80.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: RoundedContainer(
                    margin: EdgeInsets.symmetric(horizontal: 80),
                    color: kPrimaryLightColor,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Default Address",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        /*const SizedBox(
                          height: 10.0,
                        ),
                        Text("User's default address here",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            ))*/
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: RoundedContainer(
                    margin: EdgeInsets.symmetric(horizontal: 80),
                    color: kPrimaryLightColor,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Add New Address",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: new MaterialButton(
                onPressed: () {},
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
