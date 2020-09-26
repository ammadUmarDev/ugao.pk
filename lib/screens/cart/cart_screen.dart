import 'package:flutter/material.dart';
import 'package:ugao/screens/cart/cart_products.dart';
import 'package:ugao/components/appbar.dart';
import 'package:ugao/screens/checkout/checkout_screen.dart';
import '../../constants.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPageName(
        pageName: 'Cart',
      ),

      // =============== Products in Cart =================

      body: new Cart_products(),
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            // ========== TOTAL OF ORDER - ADD FUNCTION TO TOTAL ================
            Expanded(
                child: ListTile(
              title: new Text(
                "Total:",
                style: TextStyle(fontSize: 14.0),
              ),
              subtitle: new Text("\Rs."),
            )),

            Expanded(
                child: new MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckoutScreen()),
                      );
                    },
                    child: new Text(
                      "Check out",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: kPrimaryColor))
          ],
        ),
      ),
      /*body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Text("Cart under dev"),
            ],
          ),
        ),
      ),*/
    );
  }
}
