import 'package:flutter/material.dart';

//my own imports
import 'package:ugao/components/appbar.dart';
import 'package:ugao/screens/checkout/checkout_screen.dart';
import '../../constants.dart';
import 'package:ugao/Classes/Cart_Product_Model.dart';
import 'package:ugao/Providers/general_provider.dart';
import 'package:provider/provider.dart';

var total = 0;

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    List<CartProduct> cartProducts =
        Provider.of<General_Provider>(context, listen: false).cart;

    return Scaffold(
      appBar: AppBarPageName(
        pageName: 'Cart',
      ),

      // =============== Products in Cart =================

      body: ListView.builder(
          // =========== PRODUCTS IN CART =====================
          itemCount: cartProducts.length,
          itemBuilder: (context, index) {
            total = 0;
            getTotalPrice(cartProducts);
            return (Provider.of<General_Provider>(context, listen: false)
                        .getCartProduct(index)
                        .quantity <=
                    0)
                ? Container()
                : Card(
                    child: ListTile(
                      // Leading Section
                      leading: new Image.network(
                        Provider.of<General_Provider>(context, listen: false)
                            .getCartProduct(index)
                            .product
                            .prodImage,
                        width: 100.0,
                        height: 100.0,
                      ),
                      title: new Text(
                        Provider.of<General_Provider>(context, listen: false)
                            .getCartProduct(index)
                            .product
                            .prodName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: new Column(
                        children: <Widget>[
                          //Row inside Column
                          new Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 8.0, 0.0, 8.0),
                                child: new Text(Provider.of<General_Provider>(
                                        context,
                                        listen: false)
                                    .getCartProduct(index)
                                    .serviceType),
                              ),
                            ],
                          ),
                          new Row(
                            children: <Widget>[
                              //qty of product
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 8.0, 0.0, 8.0),
                                child: new Text("Quantity:"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: new Text(Provider.of<General_Provider>(
                                        context,
                                        listen: false)
                                    .getCartProduct(index)
                                    .quantity
                                    .toString()),
                              ),
                            ],
                          ),
                          new Row(
                            children: <Widget>[
                              //price of product
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: new Text(
                                  "Rs." +
                                      (Provider.of<General_Provider>(context,
                                                      listen: false)
                                                  .getCartProduct(index)
                                                  .product
                                                  .price *
                                              Provider.of<General_Provider>(
                                                      context,
                                                      listen: false)
                                                  .getCartProduct(index)
                                                  .quantity)
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[300]),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      trailing: FittedBox(
                        fit: BoxFit.fill,
                        child: Column(
                          children: <Widget>[
                            // ======== inc Quantity dec Quantity ============
                            new IconButton(
                                icon: Icon(Icons.arrow_drop_up),
                                onPressed: () {
                                  setState(() {
                                    Provider.of<General_Provider>(context,
                                            listen: false)
                                        .incrementInCart(index);
                                  });
                                }),
                            new IconButton(
                                icon: Icon(Icons.arrow_drop_down),
                                onPressed: () {
                                  setState(() {
                                    Provider.of<General_Provider>(context,
                                            listen: false)
                                        .decrementInCart(index);
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
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
    );
  }

  int getTotalPrice(List cart) {
    if (cart.length == 0) return 0;
    for (var i = 0; i < cart.length; i++)
      total = total + cart[i].product.price * cart[i].quantity;
    return total;
  }
}
