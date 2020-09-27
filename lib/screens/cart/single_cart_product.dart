import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ugao/Classes/Cart_Product_Model.dart';
import 'package:ugao/Providers/general_provider.dart';

class Single_cart_product extends StatefulWidget {
  final cartIndex;
  var total;

  Single_cart_product({
    this.cartIndex,
    this.total,
  });
  @override
  _Single_cart_productState createState() => _Single_cart_productState();
}

class _Single_cart_productState extends State<Single_cart_product> {
  @override
  Widget build(BuildContext context) {
    CartProduct cartProd = Provider.of<General_Provider>(context, listen: false)
        .getCartProduct(widget.cartIndex);

    if (cartProd.quantity < 0)
      return Container();
    else
      return Card(
        child: ListTile(
          // Leading Section
          leading: new Image.network(
            cartProd.product.prodImage,
            width: 100.0,
            height: 100.0,
          ),
          title: new Text(
            cartProd.product.prodName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: new Column(
            children: <Widget>[
              //Row inside Column
              new Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                    child: new Text(cartProd.serviceType),
                  ),
                ],
              ),
              new Row(
                children: <Widget>[
                  //qty of product
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                    child: new Text("Quantity:"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: new Text(cartProd.quantity.toString()),
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
                          (cartProd.product.price * cartProd.quantity)
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
                        Provider.of<General_Provider>(context, listen: false)
                            .incrementInCart(widget.cartIndex);
                      });
                    }),
                new IconButton(
                    icon: Icon(Icons.arrow_drop_down),
                    onPressed: () {
                      setState(() {
                        Provider.of<General_Provider>(context, listen: false)
                            .decrementInCart(widget.cartIndex);
                      });
                    }),
              ],
            ),
          ),
        ),
      );
  }
}
