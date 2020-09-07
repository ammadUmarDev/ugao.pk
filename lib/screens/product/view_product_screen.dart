import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ugao/Classes/Product_Model_Fetch.dart';
import 'package:ugao/Classes/User_Model.dart';
import 'package:ugao/Providers/product_provider.dart';
import 'package:ugao/components/appbar.dart';
import 'package:ugao/components/body_text.dart';
import 'package:ugao/components/button_loading.dart';
import 'package:ugao/components/h1.dart';
import 'package:ugao/components/h2.dart';
import 'package:ugao/components/h3.dart';
import 'package:ugao/constants.dart';
import 'package:ugao/screens/cart/cart_screen.dart';

import 'background_view_product.dart';

class ViewProduct extends StatefulWidget {
  ProductFetch productObj;
  Future<dynamic> creatorUserObj;

  ViewProduct({
    Key key,
    this.productObj,
  }) : super(key: key);

  @override
  _ViewProductState createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  LinearGradient mainButton = LinearGradient(
      colors: [Color(0xFF2b580c), Color(0xFF2b580c), Color(0xFF2b580c)],
      begin: FractionalOffset.topCenter,
      end: FractionalOffset.bottomCenter);

  List<BoxShadow> shadow = [
    BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBarPageName(
        pageName: widget.productObj.prodName,
      ),
      body: Background_VP(
        child: SafeArea(
          child: Center(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 205,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 10,
                        left: 0.0,
                        child: Image.network(
                          widget.productObj.prodImage,
                          height: 150,
                          width: 150,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        right: 0.0,
                        child: Container(
                          height: 200,
                          width: 350,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0),
                                child: H1(textBody: widget.productObj.prodName),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0),
                                child: H3(
                                    textBody: "Catagory: " +
                                        widget.productObj.prodCategory),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0),
                                child: H3(
                                    textBody: widget.productObj.priceType +
                                        ": PKR " +
                                        widget.productObj.price.toString() +
                                        " "),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              InkWell(
                                onTap: () async {
                                  Alert(
                                      context: context,
                                      title: "Quantity",
                                      style: AlertStyle(
                                        titleStyle: H2TextStyle(
                                            color: kPrimaryAccentColor),
                                      ),
                                      content: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 10,
                                          ),
                                          H3(
                                              textBody:
                                                  "TODO: Add quantity adder/subtracter"),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          ButtonLoading(
                                            onTap: (startLoading, stopLoading,
                                                btnState) async {
                                              if (btnState ==
                                                  ButtonState.Idle) {
                                                startLoading();
                                                Navigator.pop(context);
                                                stopLoading();
                                              } else {
                                                stopLoading();
                                              }
                                            },
                                            labelText: 'Continue :)',
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                      buttons: [
                                        DialogButton(
                                          color: Colors.white,
                                          height: 0,
                                        ),
                                      ]).show();
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      gradient: mainButton,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30.0),
                                          bottomLeft: Radius.circular(30.0))),
                                  padding: EdgeInsets.symmetric(vertical: 16.0),
                                  child: Center(
                                    child: H2(
                                      textBody: 'Add to Cart',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: kPrimaryAccentColor,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 24.0),
                  child: H2(
                    textBody: "Seller Information:",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 24.0),
                  child: BodyText(
                    textBody:
                        "TODO: Take creator id from product object and fetch user doc. Show seller info and pass user object to view seller info page.",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 24.0),
                  child: H2(
                    textBody: "Product Description:",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 24.0),
                  child: BodyText(
                    textBody: widget.productObj.prodDesc,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
