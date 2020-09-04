import 'package:flutter/material.dart';
import 'package:ugao/components/rounded_cnic_field.dart';
import 'package:ugao/components/rounded_input_field.dart';
import 'package:ugao/components/rounded_password_field.dart';
import 'package:ugao/components/rounded_phone_input_field.dart';
import 'components/background.dart';
import 'package:ugao/Screens/Login/login_screen.dart';
import 'package:ugao/components/already_have_an_account_acheck.dart';
import 'package:ugao/components/rounded_button.dart';
import 'package:ugao/constants.dart';
import 'package:ugao/screens/signupfollowup/signup_screen_followup.dart';
import 'package:ugao/Classes/firebase_functions.dart';
import 'package:ugao/components/rounded_alert_dialog.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  List<String> users = <String>['Farmer', 'Supplier', 'Customer'];
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
              RoundedInputField(
                hintText: "Full Name",
                icon: Icons.person,
                onChanged: (value) {
                  setState(() {
                    fullName = value.trim();
                  });
                },
              ),
              RoundedCNICField(
                onChanged: (value) {
                  setState(() {
                    cnic = value.trim();
                    print(cnic);
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
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.7,
                decoration: new BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: Column(
                  children: <Widget>[
                    DropdownButton<String>(
                      isExpanded: true,
                      isDense: false,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      hint: Text("User Type", style: TextStyle(fontSize: 15.5)),
                      value: typeUser,
                      onChanged: (String value) {
                        setState(() {
                          typeUser = value;
                        });
                      },
                      items: users.map((String user) {
                        return DropdownMenuItem<String>(
                          value: user,
                          child: Row(
                            children: <Widget>[
                              Text(
                                user,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15.5,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              RoundedButton(
                text: "NEXT",
                press: () {
                  //Navigator.pushNamed(context, "signupPageFollowup");
                  if ((checkUniquenessOfCNIC(cnic) &&
                          checkUniquenessOfPhone(
                              phone_no)) //TODO: put at the specific fields
                      ==
                      true) {
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
                  } else {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return RoundedAlertDialog(
                          title: "CNIC or Phone No is not unique",
                          buttonName: "OK",
                          onButtonPressed: () {
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
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
          DropdownButton<String>(
            isExpanded: true,
            isDense: false,
            style: TextStyle(
              color: Colors.black,
            ),
            hint: Text(
              "Produce Type",
              style: TextStyle(fontSize: 15.5),
            ),
            value: value,
            onChanged: (String value) {
              setState(() {
                value = value;
              });
            },
            items: valuesList.map((String user) {
              return DropdownMenuItem<String>(
                value: user,
                child: Row(
                  children: <Widget>[
                    Text(
                      user,
                      style: TextStyle(
                        fontSize: 15.5,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
