import 'package:flutter/material.dart';

//my own imports
import 'package:ugao/screens/dashboard/dashboard.dart';
import 'package:ugao/screens/cart/cart_products.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          elevation: 0.1,
          backgroundColor: Colors.green[300],
          title: Text('Cart'),
          actions: <Widget>[
            new IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DashBoard()));
                })
          ]),
      body: new Cart_products(),
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
              subtitle: new Text("\Rs."),
            )),
            Expanded(
                child: new MaterialButton(
              onPressed: () {},
              child: new Text(
                "Check out",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.green[300],
            ))
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
