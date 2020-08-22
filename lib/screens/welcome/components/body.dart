import 'package:flutter/material.dart';
import 'package:ugao/components/rounded_button.dart';
import '../../../constants.dart';
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
            RoundedButton(
              text: "LOGIN",
              color: kPrimaryAccentColor,
              textColor: kPrimaryTextColor,
              press: () {
                Navigator.pushNamed(context, "loginPage");
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: kPrimaryLightColor,
              textColor: kSecondaryTextColor,
              press: () {
                Navigator.pushNamed(context, "signupPage");
              },
            ),
          ],
        ),
      ),
    );
  }
}
