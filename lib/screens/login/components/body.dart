import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ugao/Providers/general_provider.dart';
import 'package:ugao/Screens/Signup/signup_screen.dart';
import 'package:ugao/components/already_have_an_account_acheck.dart';
import 'package:ugao/components/rounded_button.dart';
import 'package:ugao/components/rounded_input_field.dart';
import 'package:ugao/components/rounded_password_field.dart';
import 'package:ugao/constants.dart';
import 'package:ugao/screens/dashboard/dashboard.dart';
import 'package:ugao/screens/login/components/Login_Credentials.dart';
import 'background.dart';

class Body extends StatelessWidget {
  Login_Credentials lobject = new Login_Credentials();
  Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.05),
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            Image.asset(
              "assets/images/bgloginsignup.png",
              width: double.infinity,
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedInputField(
              hintText: "Your CNIC",
              onChanged: (value) {
                this.lobject.cnic = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                this.lobject.password = value;
              },
            ),
            RoundedButton(
              text: "LOGIN",
              color: kPrimaryAccentColor,
              press: () async {
                var check =
                    await Provider.of<General_Provider>(context, listen: false)
                        .login(lobject, context);
                if (check = true) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return DashBoard();
                      },
                    ),
                  );
                }
                //Navigator.pushNamed(context, "homePage");
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
