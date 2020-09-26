import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ugao/Classes/Product_Model_Fetch.dart';
import 'package:ugao/components/appbar.dart';
import 'package:ugao/components/body_text.dart';
import 'package:ugao/components/button_loading.dart';
import 'package:ugao/components/h1.dart';
import 'package:ugao/components/h2.dart';
import 'package:ugao/components/h3.dart';
import 'package:ugao/components/shadowBoxList.dart';
import 'package:ugao/constants.dart';
import 'package:ugao/screens/cart/cart_screen.dart';

import 'background_view_product.dart';

class EditProduct extends StatefulWidget {
  ProductFetch productObj;
  Future<dynamic> creatorUserObj;

  EditProduct({
    Key key,
    this.productObj,
  }) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
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
        pageName: "View/Edit Product",
      ),
      body: Background_VP(
        child: SafeArea(
          child: Center(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 200,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 0.0,
                        child: Image.network(
                          widget.productObj.prodImage,
                          height: 200,
                          width: 200,
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
                                    textBody: "Creator: " +
                                        widget.productObj.creator),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0),
                                child: H3(
                                    textBody: "Product Id:" +
                                        widget.productObj.creator),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                ShadowBoxList(
                  icon: Icon(Icons.edit),
                  widgetColumn: <Widget>[
                    H2(textBody: "Product Name"),
                    SizedBox(height: 5),
                    BodyText(textBody: widget.productObj.prodName),
                    SizedBox(height: 10),
                    H2(textBody: "Product Description"),
                    SizedBox(height: 5),
                    BodyText(textBody: widget.productObj.prodDesc),
                    SizedBox(height: 10),
                    H2(textBody: "Product Quanity"),
                    SizedBox(height: 5),
                    BodyText(textBody: widget.productObj.quantity.toString()),
                    SizedBox(height: 10),
                    H2(textBody: "Product Service Type"),
                    SizedBox(height: 5),
                    BodyText(textBody: widget.productObj.serviceType),
                    SizedBox(height: 10),
                  ],
                  onTapFunction: () {
                    Alert(
                        context: context,
                        title: "Edit",
                        style: AlertStyle(
                          titleStyle: H2TextStyle(color: kPrimaryAccentColor),
                        ),
                        content: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            H3(textBody: "Edit Here"),
                            SizedBox(
                              height: 10,
                            ),
                            ButtonLoading(
                              onTap:
                                  (startLoading, stopLoading, btnState) async {
                                if (btnState == ButtonState.Idle) {
                                  startLoading();
                                  //Add code here
                                  stopLoading();
                                  Navigator.pop(context);
                                } else {
                                  stopLoading();
                                }
                              },
                              labelText: 'SAVE',
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
                ),
                ShadowBoxList(
                  icon: Icon(Icons.edit),
                  widgetColumn: <Widget>[
                    H2(textBody: "Product Price Type"),
                    SizedBox(height: 5),
                    BodyText(textBody: widget.productObj.priceType),
                    SizedBox(height: 10),
                    H2(textBody: "Product Price"),
                    SizedBox(height: 5),
                    BodyText(textBody: widget.productObj.price.toString()),
                    SizedBox(height: 10),
                  ],
                  onTapFunction: () {
                    Alert(
                        context: context,
                        title: "Edit",
                        style: AlertStyle(
                          titleStyle: H2TextStyle(color: kPrimaryAccentColor),
                        ),
                        content: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            H3(textBody: "Edit Here"),
                            SizedBox(
                              height: 10,
                            ),
                            ButtonLoading(
                              onTap:
                                  (startLoading, stopLoading, btnState) async {
                                if (btnState == ButtonState.Idle) {
                                  startLoading();
                                  //Add code here
                                  stopLoading();
                                  Navigator.pop(context);
                                } else {
                                  stopLoading();
                                }
                              },
                              labelText: 'SAVE',
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
                ),
                ShadowBoxList(
                  icon: Icon(Icons.edit),
                  widgetColumn: <Widget>[
                    H2(textBody: "Product Weight Unit"),
                    SizedBox(height: 5),
                    BodyText(textBody: widget.productObj.weightUnit),
                    SizedBox(height: 10),
                    H2(textBody: "Product Weight"),
                    SizedBox(height: 5),
                    BodyText(textBody: widget.productObj.weight.toString()),
                    SizedBox(height: 10),
                  ],
                  onTapFunction: () {
                    Alert(
                        context: context,
                        title: "Edit",
                        style: AlertStyle(
                          titleStyle: H2TextStyle(color: kPrimaryAccentColor),
                        ),
                        content: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            H3(textBody: "Edit Here"),
                            SizedBox(
                              height: 10,
                            ),
                            ButtonLoading(
                              onTap:
                                  (startLoading, stopLoading, btnState) async {
                                if (btnState == ButtonState.Idle) {
                                  startLoading();
                                  //Add code here
                                  stopLoading();
                                  Navigator.pop(context);
                                } else {
                                  stopLoading();
                                }
                              },
                              labelText: 'SAVE',
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
