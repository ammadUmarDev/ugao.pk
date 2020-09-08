import 'package:flutter/material.dart';
import 'package:ugao/Classes/Cart_Product_Model.dart';
import 'package:ugao/Providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:ugao/Classes/User_Model.dart';
import 'package:ugao/Classes/Product_Model_Fetch.dart';

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  List<CartProduct> Products_on_the_cart = [
    CartProduct(
        product: ProductFetch(
            prodName: "Green Up Lawn Fertilizer",
            prodImage:
                "https://firebasestorage.googleapis.com/v0/b/ugao-58f32.appspot.com/o/data%2Fuser%2F0%2Fcom.vectech.ugao%2Fcache%2Fimage_picker2573009106067769771.jpg?alt=media&token=06f7a0c2-7cfb-4855-9b3b-3246e710331d",
            price: 4000),
        quantity: 5,
        serviceType: "Delivery"),
    CartProduct(
        product: ProductFetch(
            prodName: "Green Up Lawn Fertilizer",
            prodImage:
                "https://firebasestorage.googleapis.com/v0/b/ugao-58f32.appspot.com/o/data%2Fuser%2F0%2Fcom.vectech.ugao%2Fcache%2Fimage_picker2573009106067769771.jpg?alt=media&token=06f7a0c2-7cfb-4855-9b3b-3246e710331d",
            price: 4000),
        quantity: 2,
        serviceType: "Pickup"),
    CartProduct(
        product: ProductFetch(
            prodName: "Green Up Lawn Fertilizer",
            prodImage:
                "https://firebasestorage.googleapis.com/v0/b/ugao-58f32.appspot.com/o/data%2Fuser%2F0%2Fcom.vectech.ugao%2Fcache%2Fimage_picker2573009106067769771.jpg?alt=media&token=06f7a0c2-7cfb-4855-9b3b-3246e710331d",
            price: 4000),
        quantity: 5,
        serviceType: "Delivery"),
  ];

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(

        // =========== PRODUCTS IN CART =====================

        itemCount: Products_on_the_cart.length,
        itemBuilder: (context, index) {
          return Single_cart_product(
            cart_prod_name: Products_on_the_cart[index].product.prodName,
            cart_prod_picture: Products_on_the_cart[index].product.prodImage,
            cart_prod_price: Products_on_the_cart[index].product.price,
            cart_prod_qty: Products_on_the_cart[index].quantity,
            cart_prod_service: Products_on_the_cart[index].serviceType,
          );
        });
  }
}

class Single_cart_product extends StatefulWidget {
  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_price;
  final cart_prod_service;
  final cart_prod_qty;

  Single_cart_product({
    this.cart_prod_name,
    this.cart_prod_picture,
    this.cart_prod_price,
    this.cart_prod_qty,
    this.cart_prod_service,
  });
  @override
  _Single_cart_productState createState() =>
      _Single_cart_productState(this.cart_prod_qty);
}

class _Single_cart_productState extends State<Single_cart_product> {
  int cart_prod_qty;

  _Single_cart_productState(this.cart_prod_qty);
  void incQuantity() {
    setState(() {
      this.cart_prod_qty = this.cart_prod_qty + 1;
    });
  }

  void decQuantity() {
    setState(() {
      this.cart_prod_qty = this.cart_prod_qty - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        // Leading Section
        leading: new Image.network(
          widget.cart_prod_picture,
          width: 100.0,
          height: 100.0,
        ),
        title: new Text(
          widget.cart_prod_name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: new Column(
          children: <Widget>[
            //Row inside Column
            new Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                  child: new Text(widget.cart_prod_service),
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
                    "Rs." + (widget.cart_prod_price * cart_prod_qty).toString(),
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
                    this.incQuantity();
                  }),
              new IconButton(
                  icon: Icon(Icons.arrow_drop_down),
                  onPressed: () {
                    this.decQuantity();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
