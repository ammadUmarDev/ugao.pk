import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ugao/components/h1.dart';
import 'package:ugao/screens/cart/cart_screen.dart';
import 'package:ugao/screens/dashboard/dashboard.dart';
import '../constants.dart';

class AppBarPageName extends StatelessWidget implements PreferredSizeWidget {
  AppBarPageName({this.pageName});
  final pageName;
  @override
  Size get preferredSize => const Size.fromHeight(55);
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.light,
      iconTheme: IconThemeData(
        color: kPrimaryAccentColor, //change your color here
      ),
      backgroundColor: Colors.transparent,
      title: H1(
        textBody: pageName,
        color: kPrimaryAccentColor,
      ),
      elevation: 0,
      actions: [
        ClipOval(
          child: Material(
            color: Colors.white, // button color
            child: InkWell(
              splashColor: kPrimaryLightColor, // inkwell color
              child: SizedBox(
                width: 56,
                height: 56,
                child: Icon(
                  Icons.home,
                  color: kPrimaryAccentColor,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return DashBoard();
                    },
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        ClipOval(
          child: Material(
            color: Colors.white, // button color
            child: InkWell(
              splashColor: kPrimaryLightColor, // inkwell color
              child: SizedBox(
                width: 56,
                height: 56,
                child: Icon(
                  Icons.shopping_cart,
                  color: kPrimaryAccentColor,
                ),
              ),
              onTap: () {
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
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
