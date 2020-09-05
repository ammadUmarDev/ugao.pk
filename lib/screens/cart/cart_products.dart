import 'package:flutter/material.dart';

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  var Products_on_the_cart = [
    {
      "name": "Fertilizer",
      "picture": "fertilizer1.jpeg",
      "price": 3000,
      "quantity": 1,
    },
    {
      "name": "Rice",
      "picture": "rice1.jpeg",
      "price": 200,
      "quantity": 2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: Products_on_the_cart.length,
        itemBuilder: (context, index) {
          return Single_cart_product(
            cart_prod_name: Products_on_the_cart[index]["name"],
            cart_prod_picture: Products_on_the_cart[index]["picture"],
            cart_prod_price: Products_on_the_cart[index]["price"],
            cart_prod_qty: Products_on_the_cart[index]["quantity"],
          );
        });
  }
}

class Single_cart_product extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_price;
  final cart_prod_qty;

  Single_cart_product(
      {this.cart_prod_name,
      this.cart_prod_picture,
      this.cart_prod_price,
      this.cart_prod_qty});
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: new Text(
        cart_prod_name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: new Column(
        children: <Widget>[
          //Row inside Column
          new Row(
            children: <Widget>[
              //qty of product
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                child: new Text("Quantity:"),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: new Text(cart_prod_qty.toString()),
              ),
            ],
          ),
          new Row(
            children: <Widget>[
              //price of product
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: new Text(
                  "Rs." + cart_prod_price.toString(),
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
    ));
  }
}
