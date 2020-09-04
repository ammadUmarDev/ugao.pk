import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ugao/Providers/general_provider.dart';
import 'package:ugao/components/already_have_an_account_acheck.dart';
import 'package:ugao/components/rounded_button.dart';
import 'package:ugao/components/rounded_cnic_field.dart';
import 'package:ugao/components/rounded_input_field.dart';
import 'package:ugao/components/rounded_password_field.dart';
import 'package:ugao/screens/dashboard/dashboard.dart';
import 'package:ugao/screens/dashboard/dashboard_customer_screen.dart';
import 'package:ugao/screens/dashboard/dashboard_supplier_screen.dart';
import 'package:ugao/screens/signup/signup_screen.dart';

import '../../constants.dart';
import 'package:ugao/Classes/firebase_functions.dart';
import 'components/background.dart';
import 'package:ugao/Classes/User_Model.dart';
import 'package:ugao/components/rounded_alert_dialog.dart';
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
              RoundedButton(
                text: "LOGIN",
                color: kPrimaryAccentColor,
                press: () async {
                  User userDocument = await getUser(cnic);
                  if (userDocument != null) {
                    if (userDocument.pass == password) {
                      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                      firebaseAuth.verifyPhoneNumber(
                        phoneNumber: userDocument.phone_no,
                        timeout: Duration(seconds: 60),
                        verificationCompleted: (AuthCredential a) {
                          print("verification completed");
                        },
                        verificationFailed: (AuthException a) {
                          print("verification failed " + a.code.toString());
                        },
                        codeSent: (String verificationID, [int b]) async {
                          String code;
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Give the code?"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      TextField(
                                        onChanged: (enteredCode) {
                                          code = enteredCode;
                                        },
                                        // controller: _codeController,
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Confirm"),
                                      textColor: Colors.white,
                                      color: Colors.blue,
                                      onPressed: () async {
                                        code = code.trim();
                                        AuthCredential credential =
                                            PhoneAuthProvider.getCredential(
                                                verificationId: verificationID,
                                                smsCode: code);

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
                                          if (userDocument.usertype == "Farmer") {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return DashBoard();
                                                },
                                              ),
                                            );
                                          }else if (userDocument.usertype == "Customer") {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return DashboardCustomerScreen();
                                                },
                                              ),
                                            );
                                          }else if (userDocument.usertype == "Supplier") {
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
                                    )
                                  ],
                                );
                              });
                        },
                        codeAutoRetrievalTimeout: (String a) {
                          print("auto retrieval timeout");
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return RoundedAlertDialog(
                            title: "Incorrect password entered",
                            buttonName: "OK",
                            onButtonPressed: () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    }
                  } else {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return RoundedAlertDialog(
                          title: "Invalid CNIC entered",
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
