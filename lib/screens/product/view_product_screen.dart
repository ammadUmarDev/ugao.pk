import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ugao/Classes/Product_Model_Fetch.dart';
import 'package:ugao/Classes/User_Model.dart';
import 'package:ugao/Providers/general_provider.dart';
import 'package:ugao/components/appbar.dart';
import 'package:ugao/components/body_text.dart';
import 'package:ugao/components/button_loading.dart';
import 'package:ugao/components/h1.dart';
import 'package:ugao/components/h2.dart';
import 'package:ugao/components/h3.dart';
import 'package:ugao/components/rounded_drop_down.dart';
import 'package:ugao/components/rounded_input_field.dart';
import 'package:ugao/constants.dart';
import 'package:ugao/screens/product/seller_profile_screen.dart';

import 'background_view_product.dart';
import 'category_list_screen.dart';

class ViewProduct extends StatefulWidget {
  ProductFetch productObj;
  User userObj;

  ViewProduct({
    Key key,
    this.productObj,
    this.userObj,
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
  List<String> sTypes = ["Pickup", "Delivery"];

  @override
  Widget build(BuildContext context) {
    int cartQuantity = 0;
    String serviceType;
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
                          width: 250,
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
                                          RoundedInputField(
                                            hintText: "Quantity",
                                            keyboardType: TextInputType.number,
                                            onChanged: (newVal) {
                                              cartQuantity = (newVal == null)
                                                  ? null
                                                  : int.parse(
                                                      newVal //TODO: add onError for robustness
                                                      );
                                            },
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          RoundedDropDown(
                                            name: "Service Type",
                                            size: MediaQuery.of(context).size,
                                            text: serviceType,
                                            value: serviceType,
                                            onChanged: (String value) {
                                              setState(() {
                                                serviceType = value;
                                                if (serviceType.isEmpty)
                                                  serviceType = null;
                                              });
                                            },
                                            items: sTypes,
                                            icon: Icons.departure_board,
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          ButtonLoading(
                                            onTap: () async {
                                              print(cartQuantity);
                                              print(serviceType);
                                              Provider.of<General_Provider>(
                                                      context,
                                                      listen: false)
                                                  .addToCart(
                                                      widget.productObj,
                                                      cartQuantity,
                                                      serviceType);
                                              Navigator.pop(context);
                                            },
                                            labelText: 'Add Product',
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
                      vertical: 10, horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      H2(
                        textBody: "Seller Information:",
                      ),
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                              color: kPrimaryLightColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24))),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Text(
                            'View Seller Profile',
                            style: TextStyle(
                                color: kPrimaryAccentColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SellerProfileScreen(userObj: widget.userObj),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 18.0),
                  child: BodyText(
                    textBody: "Sold by: " +
                        widget.userObj.fullName +
                        "\n" +
                        "Contact: " +
                        widget.userObj.phone_no,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 18.0),
                  child: H2(
                    textBody: "Product Description:",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 18.0),
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
