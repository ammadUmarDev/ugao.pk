import 'package:flutter/material.dart';
import 'package:ugao/components/button_loading.dart';
import 'package:ugao/components/h2.dart';
import 'package:ugao/components/rounded_cnic_field.dart';
import 'package:ugao/components/rounded_drop_down.dart';
import 'package:ugao/components/rounded_input_field.dart';
import 'package:ugao/components/rounded_password_field.dart';
import 'package:ugao/components/rounded_phone_input_field.dart';
import 'background.dart';
import 'package:ugao/Screens/Login/login_screen.dart';
import 'package:ugao/components/already_have_an_account_acheck.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ugao/constants.dart';
import 'package:ugao/screens/signupfollowup/signup_screen_followup.dart';
import 'package:ugao/Classes/Firebase_Functions.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  List<String> users = <String>[FARMER, SUPPLIER, CUSTOMER];
  String fullName;
  String cnic;
  String password;
  String typeUser;
  String phone_no;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.05),
              Text(
                "SIGN UP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              Image.asset(
                "assets/images/bgloginsignup.png",
                width: double.infinity,
                height: size.height * 0.15,
              ),
              SizedBox(height: size.height * 0.03),
              RoundedCNICField(
                onChanged: (value) {
                  setState(() {
                    cnic = value.trim();
                    print(cnic);
                  });
                },
              ),
              RoundedInputField(
                hintText: "Full Name",
                icon: Icons.person,
                onChanged: (value) {
                  setState(() {
                    fullName = value.trim();
                  });
                },
              ),
              RoundedIntlPhoneField(
                onChanged: (value) {
                  setState(() {
                    phone_no = value.completeNumber;
                  });
                },
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  setState(() {
                    password = value.trim();
                  });
                },
              ),
              RoundedDropDown(
                name: "User Type",
                size: size,
                text: typeUser,
                value: typeUser,
                onChanged: (String value) {
                  setState(() {
                    typeUser = value.toString();
                    print("typeUser");
                    print(typeUser);
                  });
                },
                items: users,
                icon: Icons.departure_board,
              ),
              SizedBox(
                height: 5,
              ),
              ButtonLoading(
                labelText: "NEXT",
                onTap: () async {
                  if (phone_no.length != 13) {
                    Alert(
                        context: context,
                        title: "Invalid Phone No",
                        style: AlertStyle(
                          titleStyle: H2TextStyle(color: kPrimaryAccentColor),
                        ),
                        content: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            ButtonLoading(
                              onTap: () async {
                                Navigator.pop(context);
                              },
                              labelText: 'OK',
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
                  } else if (cnic.length != 15) {
                    Alert(
                        context: context,
                        title: "Invalid CNIC",
                        style: AlertStyle(
                          titleStyle: H2TextStyle(color: kPrimaryAccentColor),
                        ),
                        content: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            ButtonLoading(
                              onTap: () async {
                                Navigator.pop(context);
                              },
                              labelText: 'OK',
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
                  } else if (password.length <= 6) {
                    Alert(
                        context: context,
                        title: "Password length must be greater than 6 digits",
                        style: AlertStyle(
                          titleStyle: H2TextStyle(color: kPrimaryAccentColor),
                        ),
                        content: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            ButtonLoading(
                              onTap: () async {
                                Navigator.pop(context);
                              },
                              labelText: 'OK',
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
                  } else if ((await checkUniquenessOfCNIC(cnic) &&
                          await checkUniquenessOfPhone(
                              phone_no)) //TODO: put at the specific fields
                      ==
                      true) {
                    if (fullName.isEmpty ||
                        cnic.isEmpty ||
                        password.isEmpty ||
                        typeUser == null ||
                        typeUser.isEmpty ||
                        phone_no.isEmpty) {
                      Alert(
                          context: context,
                          title: "Please fill all fields",
                          style: AlertStyle(
                            titleStyle: H2TextStyle(color: kPrimaryAccentColor),
                          ),
                          content: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              ButtonLoading(
                                onTap: () async {
                                  Navigator.pop(context);
                                },
                                labelText: 'OK',
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
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreenFollowup(
                            fullName: fullName.trim(),
                            cnic: cnic.trim(),
                            password: password.trim(),
                            userType: typeUser.trim(),
                            phone_no: phone_no.trim(),
                          ),
                        ),
                      );
                    }
                  } else {
                    Alert(
                        context: context,
                        title: "CNIC or Phone No is not unique",
                        style: AlertStyle(
                          titleStyle: H2TextStyle(color: kPrimaryAccentColor),
                        ),
                        content: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            ButtonLoading(
                              onTap: () async {
                                Navigator.pop(context);
                              },
                              labelText: 'OK',
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
                  }
                },
              ),
              SizedBox(height: size.height * 0.02),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget DropdownField(
      BuildContext context, Size size, String value, List<String> valuesList) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.7,
      decoration: new BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: Column(
        children: <Widget>[
          RoundedDropDown(
            name: "Produce Type",
            size: size,
            text: value,
            value: value,
            onChanged: (String v) {
              setState(() {
                value = v;
              });
            },
            items: valuesList,
            icon: Icons.departure_board,
          ),
        ],
      ),
    );
  }
}
