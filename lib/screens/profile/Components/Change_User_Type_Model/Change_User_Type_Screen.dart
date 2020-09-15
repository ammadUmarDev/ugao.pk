import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ugao/Classes/User_Model.dart';
import 'package:ugao/Classes/firebase_functions.dart';
import 'package:ugao/Providers/general_provider.dart';
import 'package:ugao/components/already_have_an_account_acheck.dart';
import 'package:ugao/components/rounded_alert_dialog.dart';
import 'package:ugao/components/rounded_button.dart';
import 'package:ugao/components/rounded_cnic_field.dart';
import 'package:ugao/components/rounded_input_field.dart';
import 'package:ugao/components/rounded_password_field.dart';
import 'package:ugao/components/rounded_phone_input_field.dart';
import 'package:ugao/screens/login/login_screen.dart';
import 'package:ugao/screens/profile/Components/Change_User_Type_Model/FollowUp/Follow_Up.dart';

import '../../../../constants.dart';
import 'background.dart';

class Change_User_Type_State extends StatefulWidget {
  Change_User_Type createState() => Change_User_Type();
}

class Change_User_Type extends State<Change_User_Type_State> {
  User u;
  List<String> users = <String>[FARMER, SUPPLIER, CUSTOMER];
  String fullName;
  String cnic;
  String password;
  String typeUser;
  String phone_no;
  @override
  Widget build(BuildContext context) {
    this.u = Provider.of<General_Provider>(context, listen: false).get_user();
    this.fullName = u.fullName;
    this.cnic = u.cnic;
    this.password = u.pass;
    this.phone_no = u.phone_no;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.05),
              Text(
                "Update_UserType",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              Image.asset(
                "assets/images/bgloginsignup.png",
                width: double.infinity,
                height: size.height * 0.15,
              ),
              SizedBox(height: size.height * 0.03),
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
                  if (cnic.length != 15) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return RoundedAlertDialog(
                          title: "Invalid CNIC",
                          buttonName: "OK",
                          onButtonPressed: () {
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  } else {
                    //Navigator.pushNamed(context, "signupPageFollowup");
                    if ((checkUniquenessOfCNIC(cnic) &&
                            checkUniquenessOfPhone(
                                phone_no)) //TODO: put at the specific fields
                        ==
                        true) {
                      if (fullName == null ||
                          cnic == null ||
                          password == null ||
                          typeUser == null ||
                          phone_no == null) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return RoundedAlertDialog(
                              title: "Please fill all fields",
                              onButtonPressed: () {
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Change_User_Type_FollowUp_State(
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
                  }
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
