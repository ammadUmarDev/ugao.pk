import 'package:flutter/material.dart';

//my own imports
import 'package:ugao/screens/dashboard/dashboard.dart';
import 'package:ugao/components/appbar.dart';
import 'package:ugao/screens/checkout/checkout_screen.dart';
import '../../constants.dart';
import 'package:flutter/material.dart';
import 'package:ugao/Classes/Cart_Product_Model.dart';
import 'package:ugao/Providers/general_provider.dart';
import 'package:ugao/Providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:ugao/Classes/User_Model.dart';
import 'package:ugao/Classes/Product_Model_Fetch.dart';
import 'package:ugao/screens/cart/single_cart_product.dart';

var total = 0;

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    List<CartProduct> Products_on_the_cart =
        Provider.of<General_Provider>(context, listen: false).cart;

    return Scaffold(
      appBar: AppBarPageName(
        pageName: 'Cart',
      ),

      // =============== Products in Cart =================

      body: ListView.builder(
          // =========== PRODUCTS IN CART =====================
          itemCount: Products_on_the_cart.length,
          itemBuilder: (context, index) {
            total = 0;
            getTotalPrice(Products_on_the_cart);
            return Single_cart_product(
              cartIndex: index,
            );
          }),
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
                child: ListTile(
              title: new Text(
                "Total:",
                style: TextStyle(fontSize: 14.0),
              ),
              subtitle: new Text("\Rs." + total.toString()),
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

  int getTotalPrice(List cart) {
    if (cart.length == 0) return 0;
    for (var i = 0; i < cart.length; i++)
      total = total + cart[i].product.price * cart[i].quantity;
    return total;
  }
}
