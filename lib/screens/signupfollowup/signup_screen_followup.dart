import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:ugao/Screens/Login/login_screen.dart';
import 'package:ugao/components/already_have_an_account_acheck.dart';
import 'package:ugao/components/h1.dart';
import 'package:ugao/components/rounded_button.dart';
import 'package:ugao/components/rounded_input_field.dart';
import 'package:ugao/components/rounded_password_field.dart';
import 'package:ugao/constants.dart';

import 'components/background.dart';

class SignUpScreenFollowup extends StatefulWidget {
  SignUpScreenFollowup({
    this.fullName,
    this.cnic,
    this.password,
    this.userType,
  });
  //General Signup
  final String fullName;
  final String cnic;
  final String password;
  final String userType;

  @override
  _SignUpScreenFollowupState createState() => _SignUpScreenFollowupState();
}

class _SignUpScreenFollowupState extends State<SignUpScreenFollowup> {
  //Farmer Signup
  String fExperience;
  String fAddress;
  String fService;
  String fCategory;
  String fCrops;
  String fAnimals;
  String fFreshProduce;
  String fDairy;
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
  String cAccountType;
  List<String> cAccountTypes = [
    'Individual',
    'Commercial',
  ];
  String cPhoneNumber;
  String ccName;
  String ccPhoneNumber;
  String ccWebsite;

  //Supplier
  String scExperience;
  String sPhoneNumber;
  String sAddress;
  String sType;
  List<String> sSelectedTypes;
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

    //Farmer
    Widget FProductTypeFollowUp() {
      if (fCategory == null) return SizedBox(height: 1);
      if (fCategory == "Raw Product")
        return Column(
          children: <Widget>[
            RoundedInputField(
              hintText: "Crops:",
              icon: Icons.local_florist,
              onChanged: (value) {
                setState(() {
                  fCrops = value;
                });
              },
            ),
            RoundedInputField(
              hintText: "Livestock:",
              icon: Icons.local_florist,
              onChanged: (value) {
                setState(() {
                  fAnimals = value;
                });
              },
            ),
          ],
        );
      if (fCategory == "End Product")
        return Column(
          children: <Widget>[
            RoundedInputField(
              hintText: "Fresh Produce (Fruits and Vegetables):",
              icon: Icons.panorama_wide_angle,
              onChanged: (value) {
                fFreshProduce = value;
              },
            ),
            RoundedInputField(
              hintText: "Dairy:",
              icon: Icons.panorama_wide_angle,
              onChanged: (value) {
                fDairy = value;
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
            onChanged: (value) {
              fExperience = value;
            },
          ),
          RoundedInputField(
            hintText: "Address/Location",
            icon: Icons.pin_drop,
            onChanged: (value) {
              fAddress = value;
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
                  value: fService,
                  onChanged: (String value) {
                    setState(() {
                      fService = value;
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
                  value: fCategory,
                  onChanged: (String value) {
                    setState(() {
                      fCategory = value;
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
          RoundedButton(
            text: "SIGNUP",
            press: () {
              Navigator.pushNamed(context, "signupScreen2");
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
              sSelectedTypes = checked;
            },
          ),
          RoundedInputField(
            hintText: "Years of Experience:",
            icon: Icons.local_florist,
            onChanged: (value) {
              setState(() {
                scExperience = value;
              });
            },
          ),
          RoundedInputField(
            hintText: "Phone Number:",
            icon: Icons.local_florist,
            onChanged: (value) {
              setState(() {
                sPhoneNumber = value;
              });
            },
          ),
          RoundedInputField(
            hintText: "Address:",
            icon: Icons.local_florist,
            onChanged: (value) {
              setState(() {
                scExperience = value;
              });
            },
          ),
          RoundedButton(
            text: "SIGNUP",
            press: () {
              Navigator.pushNamed(context, "signupScreen2");
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
          SizedBox(height: size.height * 0.02),
        ],
      );
    }

    //Customer
    Widget CCustomerTypeFollowUp() {
      if (cAccountType == null) return SizedBox(height: 1);
      if (cAccountType == "Individual")
        return Column(
          children: <Widget>[
            RoundedInputField(
              hintText: "Phone Number:",
              icon: Icons.local_florist,
              onChanged: (value) {
                setState(() {
                  cPhoneNumber = value;
                });
              },
            ),
          ],
        );
      if (cAccountType == "Commercial")
        return Column(
          children: <Widget>[
            RoundedInputField(
              hintText: "Company Name:",
              icon: Icons.panorama_wide_angle,
              onChanged: (value) {
                setState(() {
                  ccName = value;
                });
              },
            ),
            RoundedInputField(
              hintText: "Company Phone Number:",
              icon: Icons.panorama_wide_angle,
              onChanged: (value) {
                ccPhoneNumber = value;
              },
            ),
            RoundedInputField(
              hintText: "Company Website (optional):",
              icon: Icons.panorama_wide_angle,
              onChanged: (value) {
                ccWebsite = value;
              },
            ),
          ],
        );
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
                  value: cAccountType,
                  onChanged: (String value) {
                    setState(() {
                      cAccountType = value;
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
          RoundedButton(
            text: "SIGNUP",
            press: () {
              Navigator.pushNamed(context, "signupScreen2");
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
