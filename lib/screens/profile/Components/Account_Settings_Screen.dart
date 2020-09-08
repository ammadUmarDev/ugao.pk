import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ugao/Classes/User_Model.dart';
import 'package:ugao/Classes/firebase_functions.dart';
import 'package:ugao/Providers/general_provider.dart';
import 'package:ugao/components/appbar.dart';
import 'package:ugao/components/body_text.dart';
import 'package:ugao/components/button_loading.dart';
import 'package:ugao/components/h2.dart';
import 'package:ugao/components/shadowBoxList.dart';
import 'package:ugao/screens/product/background_view_product.dart';
import 'package:ugao/screens/profile/Components/Change_User_Type_Model/Change_User_Type_Screen.dart';

import '../../../constants.dart';

class Account_Settings_State extends StatefulWidget {
  Account_Settings createState() => Account_Settings();
}

class Account_Settings extends State<Account_Settings_State> {
  String new_user_name;
  String new_phone_no;
  User u;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  LinearGradient mainButton = LinearGradient(
      colors: [Color(0xFF2b580c), Color(0xFF2b580c), Color(0xFF2b580c)],
      begin: FractionalOffset.topCenter,
      end: FractionalOffset.bottomCenter);

  List<BoxShadow> shadow = [
    BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
  ];
  @override
  Widget build(BuildContext context) {
    u = Provider.of<General_Provider>(context, listen: false).get_user();
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBarPageName(
        pageName: "Account Settings",
      ),
      body: Background_VP(
        child: SafeArea(
          child: Column(
            children: [
              ShadowBoxList(
                icon: Icon(Icons.edit),
                widgetColumn: <Widget>[
                  H2(textBody: "User_Name: " + u.fullName),
                  SizedBox(height: 5),
                ],
                onTapFunction: () {
                  Alert(
                      context: context,
                      title: "Edit",
                      style: AlertStyle(
                        titleStyle: H2TextStyle(color: kPrimaryAccentColor),
                      ),
                      content: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Please Enter The New User_Name"),
                            onChanged: (value) => {this.new_user_name = value},
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ButtonLoading(
                            onTap: (startLoading, stopLoading, btnState) async {
                              if (btnState == ButtonState.Idle) {
                                startLoading();
                                //Add code here
                                var fire = Provider.of<General_Provider>(
                                        context,
                                        listen: false)
                                    .get_firebase_user();
                                var check =
                                    await change_User_Name(u, new_user_name);
                                if (check == true) {
                                  setState(() {
                                    this.u.fullName = new_user_name;
                                  });
                                  SnackBar sc = new SnackBar(
                                    content: Text(
                                      "Name Changed Successfully",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  );
                                  _scaffoldKey.currentState.showSnackBar(sc);
                                }
                                stopLoading();
                                Navigator.pop(context);
                              } else {
                                stopLoading();
                              }
                            },
                            labelText: 'SAVE',
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
              ),
              ShadowBoxList(
                icon: Icon(Icons.edit),
                widgetColumn: <Widget>[
                  H2(textBody: "Phone_No: " + u.phone_no),
                  SizedBox(height: 5),
                ],
                onTapFunction: () {
                  Alert(
                      context: context,
                      title: "Edit",
                      style: AlertStyle(
                        titleStyle: H2TextStyle(color: kPrimaryAccentColor),
                      ),
                      content: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Please Enter The New Phone_No"),
                            onChanged: (value) => {this.new_phone_no = value},
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ButtonLoading(
                            onTap: (startLoading, stopLoading, btnState) async {
                              if (btnState == ButtonState.Idle) {
                                startLoading();
                                //Add code here
                                var check =
                                    await change_Phone_No(u, this.new_phone_no);
                                if (check == true) {
                                  setState(() {
                                    this.u.phone_no = this.new_phone_no;
                                  });
                                  SnackBar sc = new SnackBar(
                                    content: Text(
                                      "PhoneNo Changed Successfully",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  );
                                  _scaffoldKey.currentState.showSnackBar(sc);
                                }
                                stopLoading();
                                Navigator.pop(context);
                              } else {
                                stopLoading();
                              }
                            },
                            labelText: 'SAVE',
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
              ),
              ShadowBoxList(
                icon: Icon(Icons.edit),
                widgetColumn: <Widget>[
                  H2(textBody: "User_Type: " + u.usertype),
                  SizedBox(height: 5),
                ],
                onTapFunction: () {
                  Alert(
                      context: context,
                      title: "Edit",
                      style: AlertStyle(
                        titleStyle: H2TextStyle(color: kPrimaryAccentColor),
                      ),
                      content: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    "Click Update Button To Change User_Type"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ButtonLoading(
                            onTap: (startLoading, stopLoading, btnState) async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => Change_User_Type_State()));
                            },
                            labelText: 'Update',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
