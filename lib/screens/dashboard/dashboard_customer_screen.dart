import 'package:flutter/material.dart';
import 'package:ugao/components/rounded_button.dart';
import 'package:ugao/screens/Cart/cart_screen.dart';
import 'package:ugao/screens/product/category_list_screen.dart';
import 'package:ugao/screens/product/catagory_products_screen.dart';
import 'package:ugao/screens/profile/profile_screen.dart';
import 'package:ugao/screens/tutorial/tutorial_screen.dart';

import '../../constants.dart';

class DashboardCustomerScreen extends StatefulWidget {
  @override
  _DashboardCustomerScreenState createState() =>
      _DashboardCustomerScreenState();
}

class _DashboardCustomerScreenState extends State<DashboardCustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Dashboard Customer"),
                RoundedButton(
                    text: "Catagories",
                    color: kPrimaryAccentColor,
                    press: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CategoryListScreen();
                          },
                        ),
                      );
                    }),
                RoundedButton(
                    text: "Fertilizer Products",
                    color: kPrimaryAccentColor,
                    press: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProductsScreen(
                              catagoryName: "Fertilizer",
                            );
                          },
                        ),
                      );
                    }),
                RoundedButton(
                  text: "Cart",
                  color: kPrimaryAccentColor,
                  press: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CartScreen();
                        },
                      ),
                    );
                  },
                ),
                RoundedButton(
                    text: "Tutorials",
                    color: kPrimaryAccentColor,
                    press: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return TutorialScreen();
                          },
                        ),
                      );
                    }
                    //Navigator.pushNamed(context, "homePage");
                    ),
                RoundedButton(
                    text: "Profile",
                    color: kPrimaryAccentColor,
                    press: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProfilePage();
                          },
                        ),
                      );
                    }
                    //Navigator.pushNamed(context, "homePage");
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
