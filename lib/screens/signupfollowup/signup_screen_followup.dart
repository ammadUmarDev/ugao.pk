import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:provider/provider.dart';
import 'package:ugao/Classes/Customer_Model.dart';
import 'package:ugao/Classes/Farmer_Model.dart';
import 'package:ugao/Classes/Supplier_Model.dart';
import 'package:ugao/Providers/general_provider.dart';
import 'package:ugao/Screens/Login/login_screen.dart';
import 'package:ugao/components/already_have_an_account_acheck.dart';
import 'package:ugao/components/h1.dart';
import 'package:ugao/components/rounded_button.dart';
import 'package:ugao/components/rounded_input_field.dart';
import 'package:ugao/components/rounded_phone_input_field.dart';
import 'package:ugao/constants.dart';
import 'package:ugao/screens/dashboard/dashboard_customer_screen.dart';
import 'package:ugao/screens/dashboard/dashboard_supplier_screen.dart';

import 'background.dart';
import 'package:ugao/Classes/User_Model.dart';
import 'package:ugao/Classes/firebase_functions.dart';
import 'package:ugao/components/rounded_alert_dialog.dart';
import 'package:ugao/screens/dashboard/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreenFollowup extends StatefulWidget {
  //General Signup
  final String fullName;
  final String cnic;
  final String password;
  final String userType;
  final String phone_no;

  SignUpScreenFollowup({
    this.fullName,
    this.cnic,
    this.password,
    this.userType,
    this.phone_no,
  });

  @override
  _SignUpScreenFollowupState createState() => _SignUpScreenFollowupState();
}

class _SignUpScreenFollowupState extends State<SignUpScreenFollowup> {
  //Farmer Signup
  Farmer fobject = new Farmer();

  List<String> fServices = <String>[
    'Pickup',
    'Delivery',
    'Pickup and Delivery',
  ];
  List<String> fCategories = <String>[
    'Raw Product',
    'End Product',
  ];

  //Customer
  Customer cobject = new Customer();
  List<String> cAccountTypes = [
    'Individual',
    'Commercial',
  ];
  //Supplier
  Supplier sobject = new Supplier();
  List<String> sTypes = [
    'Fertilizer',
    'Pesticide',
    'Nutrients',
    'Animal and Feed',
    'Farm Tools and Machinery',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget signupButton = RoundedButton(
      text: "SIGNUP",
      color: kPrimaryAccentColor,
      textColor: Colors.white,
      press: () async {
        User user = User(
          cnic: widget.cnic,
          pass: widget.password,
          fullName: widget.fullName,
          usertype: widget.userType,
          phone_no: widget.phone_no,
          farmer: this.fobject,
          customer: this.cobject,
          supplier: this.sobject,
        );
        var check = await signup(user);
        if (check == true) {
          FirebaseAuth firebaseAuth = FirebaseAuth.instance;
          firebaseAuth.verifyPhoneNumber(
            phoneNumber: widget.phone_no,
            timeout: Duration(seconds: 60),
            verificationCompleted: (AuthCredential a) {
              print("verification completed");
            },
            verificationFailed: (AuthException a) {
              print("verification failed " + a.message.toString());
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
                                  .set_user(user);
                              Provider.of<General_Provider>(context,
                                      listen: false)
                                  .set_firebase_user(result.user);
                              user.print_user();
                              Provider.of<General_Provider>(context,
                                      listen: false)
                                  .get_user()
                                  .print_user();
                              print(Provider.of<General_Provider>(context,
                                      listen: false)
                                  .get_firebase_user());
                              if (user.usertype == "Farmer") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return DashBoard();
                                    },
                                  ),
                                );
                              } else if (user.usertype == "Customer") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return DashboardCustomerScreen();
                                    },
                                  ),
                                );
                              } else if (user.usertype == "Supplier") {
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
                title: "Check your internet connection",
                buttonName: "OK",
                onButtonPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          );
        }
      },
    );

    //Farmer
    Widget FProductTypeFollowUp() {
      if (fobject.fCategory == null) return SizedBox(height: 1);
      if (fobject.fCategory == "Raw Product")
        return Column(
          children: <Widget>[
            RoundedInputField(
              hintText: "Crops:",
              icon: Icons.local_florist,
              onChanged: (value) {
                setState(() {
                  fobject.fCrops = value.trim();
                });
              },
            ),
            RoundedInputField(
              hintText: "Livestock:",
              icon: Icons.local_florist,
              onChanged: (value) {
                setState(() {
                  fobject.fAnimals = value.trim();
                });
              },
            ),
          ],
        );
      if (fobject.fCategory == "End Product")
        return Column(
          children: <Widget>[
            RoundedInputField(
              hintText: "Fresh Produce (Fruits and Vegetables):",
              icon: Icons.panorama_wide_angle,
              onChanged: (value) {
                fobject.fFreshProduce = value.trim();
              },
            ),
            RoundedInputField(
              hintText: "Dairy:",
              icon: Icons.panorama_wide_angle,
              onChanged: (value) {
                fobject.fDairy = value;
              },
            ),
          ],
        );
    }

    Widget FarmerSignUp() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.05),
          Text(
            "FEW MORE QUESTIONS :)",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: size.height * 0.02),
          Image.asset(
            "assets/images/bgloginsignup.png",
            width: double.infinity,
            height: size.height * 0.1,
          ),
          SizedBox(height: size.height * 0.02),
          RoundedInputField(
            hintText: "Years of Experience",
            icon: Icons.donut_large,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              fobject.fExperience = value.trim();
            },
          ),
          RoundedInputField(
            hintText: "Address/Location",
            icon: Icons.pin_drop,
            onChanged: (value) {
              fobject.fAddress = value.trim();
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
                  hint: Text(
                    "Service Type",
                    style: TextStyle(fontSize: 15.5),
                  ),
                  value: fobject.fService,
                  onChanged: (String value) {
                    setState(() {
                      fobject.fService = value.trim();
                    });
                  },
                  items: fServices.map((String user) {
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
                  hint: Text(
                    "Produce Type",
                    style: TextStyle(fontSize: 15.5),
                  ),
                  value: fobject.fCategory,
                  onChanged: (String value) {
                    setState(() {
                      fobject.fCategory = value.trim();
                    });
                  },
                  items: fCategories.map((String user) {
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
          ),
          FProductTypeFollowUp(),
          signupButton,
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
      );
    }

    //Supplier

    Widget SupplierSignUp() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.05),
          Text(
            "FEW MORE QUESTIONS :)",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: size.height * 0.02),
          Image.asset(
            "assets/images/bgloginsignup.png",
            width: double.infinity,
            height: size.height * 0.1,
          ),
          SizedBox(height: size.height * 0.02),
          H1(
            textBody: "Supplier Type:",
          ),
          CheckboxGroup(
            //TODO: customize display according to brand standards
            labels: <String>[
              'Fertilizer',
              'Pesticide',
              'Nutrients',
              'Animal and Feed',
              'Farm Tools and Machinery',
            ],
            onSelected: (List<String> checked) {
              sobject.sSelectedTypes = checked;
            },
          ),
          RoundedInputField(
            hintText: "Years of Experience:",
            icon: Icons.local_florist,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                sobject.scExperience = value.trim();
              });
            },
          ),
          RoundedInputField(
            hintText: "Address:",
            icon: Icons.local_florist,
            onChanged: (value) {
              setState(() {
                sobject.sAddress = value.trim();
              });
            },
          ),
          signupButton,
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
          SizedBox(height: size.height * 0.02),
        ],
      );
    }

    //Customer
    Widget CCustomerTypeFollowUp() {
      if (cobject.cAccountType == "Commercial")
        return Column(
          children: <Widget>[
            RoundedInputField(
              hintText: "Company Name:",
              icon: Icons.panorama_wide_angle,
              onChanged: (value) {
                setState(() {
                  cobject.ccName = value;
                });
              },
            ),
            RoundedIntlPhoneField(
              hintText: "Company Phone Number:",
              onChanged: (value) {
                cobject.ccPhoneNumber = value.trim();
              },
            ),
            RoundedInputField(
              hintText: "Company Website (optional):",
              icon: Icons.panorama_wide_angle,
              onChanged: (value) {
                cobject.ccWebsite = value;
              },
            ),
          ],
        );
      if (cobject.cAccountType == "Individual") {
        return Column(
          children: [
            SizedBox(height: 1),
            Text(
              "NO MORE QUESTIONS, THANKYOU!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        );
      }
      return SizedBox(height: 1);
    }

    Widget CustomerSignUp() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.05),
          Text(
            "FEW MORE QUESTIONS :)",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: size.height * 0.02),
          Image.asset(
            "assets/images/bgloginsignup.png",
            width: double.infinity,
            height: size.height * 0.1,
          ),
          SizedBox(height: size.height * 0.02),
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
                  hint: Text(
                    "Account Type",
                    style: TextStyle(fontSize: 15.5),
                  ),
                  value: cobject.cAccountType,
                  onChanged: (String value) {
                    setState(() {
                      cobject.cAccountType = value;
                    });
                  },
                  items: cAccountTypes.map((String user) {
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
          ),
          CCustomerTypeFollowUp(),
          signupButton,
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
      );
    }

    Widget FollowUpSignUp() {
      if (widget.userType == "Farmer") {
        return FarmerSignUp();
      }
      if (widget.userType == "Supplier") {
        return SupplierSignUp();
      }
      if (widget.userType == "Customer") {
        return CustomerSignUp();
      }
    }

    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: FollowUpSignUp(),
        ),
      ),
    );
  }
}
