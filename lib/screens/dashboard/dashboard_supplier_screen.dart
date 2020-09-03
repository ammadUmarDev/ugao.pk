import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ugao/Classes/User_Model.dart';
import 'package:ugao/Providers/general_provider.dart';
import 'package:ugao/components/rounded_button.dart';
import 'package:ugao/screens/order/orders_received_seller.dart';
import 'package:ugao/screens/product/add_product.dart';
import 'package:ugao/screens/product/my_products_screen.dart';

import '../../constants.dart';

class DashboardSupplierScreen extends StatefulWidget {
  @override
  _DashboardSupplierScreenState createState() =>
      _DashboardSupplierScreenState();
}

class _DashboardSupplierScreenState extends State<DashboardSupplierScreen> {
  User currentUser;
  @override
  void initState() {
    super.initState();
    setState(() {
      currentUser =
          Provider.of<General_Provider>(context, listen: false).get_user();
      print(currentUser.cnic);
    });
  }

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
                Text("Dashboard Supplier"),
                RoundedButton(
                    text: "Orders Recieved",
                    color: kPrimaryAccentColor,
                    press: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return OrdersReceivedSeller();
                          },
                        ),
                      );
                    }),
                RoundedButton(
                  text: "My Products",
                  color: kPrimaryAccentColor,
                  press: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MyProductsSeller(
                            userCnic: currentUser.cnic,
                          );
                        },
                      ),
                    );
                  },
                ),
                RoundedButton(
                    text: "Add a Product",
                    color: kPrimaryAccentColor,
                    press: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return AddProduct();
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
