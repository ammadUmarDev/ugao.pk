import 'package:flutter/material.dart';
import 'package:ugao/Providers/general_provider.dart';
import 'package:ugao/screens/login/Login_Provider/login_provider.dart';
import 'package:ugao/screens/login/login_screen.dart';
import 'package:ugao/screens/signup/signup_screen.dart';
import 'package:ugao/screens/signupfollowup/signup_screen_followup.dart';
import 'package:ugao/screens/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => General_Provider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ugao',
        theme: ThemeData(
          primaryColor: kPrimaryTextColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: "welcomePage",
        routes: {
          "welcomePage": (context) => WelcomeScreen(),
          "signupPage": (context) => SignUpScreen(),
          "signupPageFollowup": (context) => SignUpScreenFollowup(),
          "loginPage": (context) => LoginScreen(),
        },
      ),
    );
  }
}
