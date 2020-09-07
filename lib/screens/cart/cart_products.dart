import 'package:flutter/material.dart';
import 'package:ugao/Providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:ugao/Classes/User_Model.dart';
import 'package:ugao/Classes/Product_Model_Fetch.dart';

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  var Products_on_the_cart = [
    {
      "name": "Fertilizer",
      "picture": "assets/images/bgwelcome.png",
      "price": 3000,
      "quantity": 1,
    },
    {
      "name": "Rice",
      "picture": "assets/images/clothes.jpeg",
      "price": 200,
      "quantity": 2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(

        // =========== PRODUCTS IN CART =====================

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
  var cart_prod_qty;

  Single_cart_product(
      {this.cart_prod_name,
      this.cart_prod_picture,
      this.cart_prod_price,
      this.cart_prod_qty});

  void incQuantity() {
    this.cart_prod_qty = this.cart_prod_qty + 1;
  }

  void decQuantity() {
    this.cart_prod_qty = this.cart_prod_qty - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            // Leading Section
            leading: new Image.asset(
              "assets/images/fertilizer1.jpg",
              width: 100.0,
              height: 100.0,
            ),
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
                        "Rs." + (cart_prod_price * cart_prod_qty).toString(),
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
                  new IconButton(
                      icon: Icon(Icons.arrow_drop_up),
                      onPressed: () {
                        this.incQuantity();
                      }),
                  new IconButton(
                      icon: Icon(Icons.arrow_drop_down),
                      onPressed: () {
                        this.decQuantity();
                      }),
                ],
              ),
            ) /*new Column(
        children: <Widget>[
          new Row(children: <Widget>[
            Expanded(
              child: new IconButton(
                  icon: Icon(Icons.arrow_drop_up), onPressed: () {}),
            )
          ]),
          new Row(
            children: <Widget>[
              //Padding(
              //padding: const EdgeInsets.all(1.0),
              //child:
              new IconButton(
                  icon: Icon(Icons.arrow_drop_down), onPressed: () {}),
              //)
            ],
          )
        ],
      ),*/
            ));
  }
}
