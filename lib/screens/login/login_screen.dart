import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ugao/Providers/general_provider.dart';
import 'package:ugao/components/already_have_an_account_acheck.dart';
import 'package:ugao/components/button_loading.dart';
import 'package:ugao/components/h2.dart';
import 'package:ugao/components/h3.dart';
import 'package:ugao/components/rounded_cnic_field.dart';
import 'package:ugao/components/rounded_input_field.dart';
import 'package:ugao/components/rounded_password_field.dart';
import 'package:ugao/screens/dashboard/dashboard.dart';
import 'package:ugao/screens/dashboard/dashboard_customer_screen.dart';
import 'package:ugao/screens/dashboard/dashboard_supplier_screen.dart';
import 'package:ugao/screens/signup/signup_screen.dart';

import '../../constants.dart';
import 'package:ugao/Classes/Firebase_Functions.dart';
import 'background.dart';
import 'package:ugao/Classes/User_Model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String cnic;
  String password;

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "LOGIN",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  FlatButton.icon(
                    onPressed: () {
                      Alert(
                          context: context,
                          title: "Help",
                          style: AlertStyle(
                            titleStyle: H2TextStyle(color: kPrimaryAccentColor),
                          ),
                          content: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Trouble with login?\nLogin as a farmer using dummy account\nCnic: 23456-7890123-4\nPassword: abcdefgh\nOtp: 123456",
                                style: H3TextStyle(),
                                textAlign: TextAlign.center,
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
                    icon: Icon(FontAwesomeIcons.infoCircle),
                    label: H3(
                      textBody: "Help",
                    ),
                  )
                ],
              ),
              SizedBox(height: size.height * 0.05),
              Image.asset(
                "assets/images/bgloginsignup.png",
                width: double.infinity,
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.05),
              RoundedCNICField(
                onChanged: (value) {
                  setState(() {
                    cnic = value.trim();
                    print(cnic);
                  });
                },
              ),
              RoundedPasswordField(
                onChanged: (newVal) {
                  setState(() {
                    if (newVal != null) this.password = newVal.trim();
                  });
                },
              ),
              SizedBox(
                height: 5,
              ),
              ButtonLoading(
                labelText: "LOGIN",
                onTap: () async {
                  if (cnic.length != 15) {
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
                  } else {
                    User userDocument = await getUser(cnic);
                    if (userDocument != null) {
                      if (userDocument.pass == password) {
                        FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                        firebaseAuth.verifyPhoneNumber(
                          phoneNumber: userDocument.phone_no,
                          timeout: Duration(seconds: 60),
                          verificationCompleted:
                              (AuthCredential credential) async {
                            print("verification completed");
                            AuthResult result = await firebaseAuth
                                .signInWithCredential(credential);

                            if (result.user != null) {
                              print("Verification successful");
                              Navigator.of(context).pop();
                              Provider.of<General_Provider>(context,
                                      listen: false)
                                  .set_user(userDocument);
                              Provider.of<General_Provider>(context,
                                      listen: false)
                                  .set_firebase_user(result.user);
                              if (userDocument.usertype == FARMER) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return DashBoard();
                                    },
                                  ),
                                );
                              } else if (userDocument.usertype == CUSTOMER) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return DashboardCustomerScreen();
                                    },
                                  ),
                                );
                              } else if (userDocument.usertype == SUPPLIER) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return DashboardSupplierScreen();
                                    },
                                  ),
                                );
                              }
                            }
                          },
                          verificationFailed: (AuthException a) {
                            print("verification failed " + a.code.toString());
                          },
                          codeSent: (String verificationID, [int b]) async {
                            String code;
                            Alert(
                                context: context,
                                title: "Enter one time password",
                                style: AlertStyle(
                                  titleStyle:
                                      H2TextStyle(color: kPrimaryAccentColor),
                                ),
                                content: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "We have sent an OTP to your registered mobile number",
                                      style: H3TextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    RoundedInputField(
                                      onChanged: (enteredCode) {
                                        code = enteredCode;
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ButtonLoading(
                                      onTap: () async {
                                        code = code.trim();
                                        try {
                                          AuthCredential credential =
                                              PhoneAuthProvider.getCredential(
                                                  verificationId:
                                                      verificationID,
                                                  smsCode: code);

                                          AuthResult result = await firebaseAuth
                                              .signInWithCredential(credential);

                                          if (result.user != null) {
                                            print("Verification successful");
                                            Navigator.of(context).pop();
                                            Provider.of<General_Provider>(
                                                    context,
                                                    listen: false)
                                                .set_user(userDocument);
                                            Provider.of<General_Provider>(
                                                    context,
                                                    listen: false)
                                                .set_firebase_user(result.user);
                                            if (userDocument.usertype ==
                                                "Farmer") {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return DashBoard();
                                                  },
                                                ),
                                              );
                                            } else if (userDocument.usertype ==
                                                "Customer") {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return DashboardCustomerScreen();
                                                  },
                                                ),
                                              );
                                            } else if (userDocument.usertype ==
                                                "Supplier") {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return DashboardSupplierScreen();
                                                  },
                                                ),
                                              );
                                            }
                                          }
                                        } catch (PlatformException) {
                                          print("CAUGHT_PLATFORM_EXCEPTION");
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      "Incorrect PIN entered"),
                                                );
                                              });
                                        }
                                      },
                                      labelText: "Confirm",
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
                          codeAutoRetrievalTimeout: (String a) {
                            print("auto retrieval timeout");
                          },
                        );
                      } else {
                        Alert(
                            context: context,
                            title: "Incorrect Password entered",
                            style: AlertStyle(
                              titleStyle:
                                  H2TextStyle(color: kPrimaryAccentColor),
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
                    } else {
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
                    }
                  }
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
      ),
    );
  }
}
