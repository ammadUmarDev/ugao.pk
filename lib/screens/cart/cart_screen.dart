import 'package:flutter/material.dart';

//my own imports
import 'package:ugao/components/appbar.dart';
import 'package:ugao/components/h2.dart';
import 'package:ugao/components/h3.dart';
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
      body: SafeArea(
        child: Container(
          child: ListView.builder(
              itemCount: cartProducts.length,
              itemBuilder: (context, index) {
                total = 0;
                return (Provider.of<General_Provider>(context, listen: false)
                            .getCartProduct(index)
                            .quantity <=
                        0)
                    ? Container(
                        child: Center(
                          child: H3(
                            textBody: "Your cart is empty :(",
                            color: kPrimaryAccentColor,
                          ),
                        ),
                      )
                    : Card(
                        child: ListTile(
                          // Leading Section
                          leading: Image.network(
                            Provider.of<General_Provider>(context,
                                    listen: false)
                                .getCartProduct(index)
                                .product
                                .prodImage,
                            width: 100.0,
                            height: 100.0,
                          ),
                          title: H2(
                            textBody: Provider.of<General_Provider>(context,
                                    listen: false)
                                .getCartProduct(index)
                                .product
                                .prodName,
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //Row inside Column
                              SizedBox(height: 5),
                              H3(
                                  textBody: "Service Type: " +
                                      Provider.of<General_Provider>(context,
                                              listen: false)
                                          .getCartProduct(index)
                                          .serviceType),
                              SizedBox(height: 5),
                              H3(
                                  textBody: "Quantity:" +
                                      Provider.of<General_Provider>(context,
                                              listen: false)
                                          .getCartProduct(index)
                                          .quantity
                                          .toString()),
                              SizedBox(height: 5),
                              H3(
                                textBody: "Rs." +
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
                                color: kPrimaryAccentColor,
                              )
                            ],
                          ),
                          trailing: FittedBox(
                            fit: BoxFit.fill,
                            child: Column(
                              children: <Widget>[
                                // ======== inc Quantity dec Quantity ============
                                IconButton(
                                    icon: Icon(Icons.arrow_drop_up),
                                    onPressed: () {
                                      setState(() {
                                        Provider.of<General_Provider>(context,
                                                listen: false)
                                            .incrementInCart(index);
                                      });
                                    }),

                                IconButton(
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
        ),
      ),
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
                child: ListTile(
              title: H2(
                textBody: "Total:",
              ),
              subtitle:
                  H3(textBody: "\Rs." + getTotalPrice(cartProducts).toString()),
            )),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: kPrimaryAccentColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
                  border: Border.all(
                    width: 3,
                    color: kPrimaryAccentColor,
                    style: BorderStyle.solid,
                  )),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CheckoutScreen()),
                  );
                },
                child: H3(
                  textBody: "Check out",
                  color: Colors.white,
                ),
              ),
            ))
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
