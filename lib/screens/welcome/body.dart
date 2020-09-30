import 'package:flutter/material.dart';
import 'package:ugao/components/button_loading.dart';
import 'package:ugao/components/rounded_button.dart';

import '../../constants.dart';
import 'background.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/bgWelcome.jpg",
              width: size.width,
              height: size.height * 0.5,
            ),
            Text(
              "Revolutionize Argiculture in Pakistan",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: h1Size,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            ButtonLoading(labelText:  "LOGIN",
              onTap: () {
                Navigator.pushNamed(context, "loginPage");
              },
            ),
            SizedBox(height: 10,),
            ButtonLoading(
              labelText: "SIGN UP",
              onTap: () {
                Navigator.pushNamed(context, "signupPage");
              },
            ),
          ],
        ),
      ),
    );
  }
}
