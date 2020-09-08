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
import 'package:ugao/components/h3.dart';
import 'package:ugao/components/shadowBoxList.dart';
import 'package:ugao/screens/product/background_view_product.dart';

import '../../../constants.dart';

class Security_Settings_State extends StatefulWidget {
  Security_Settings createState() => Security_Settings();
}

class Security_Settings extends State<Security_Settings_State> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  LinearGradient mainButton = LinearGradient(
      colors: [Color(0xFF2b580c), Color(0xFF2b580c), Color(0xFF2b580c)],
      begin: FractionalOffset.topCenter,
      end: FractionalOffset.bottomCenter);
  List<BoxShadow> shadow = [
    BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
  ];
  String new_password;
  String oldPassword;
  User u;
  @override
  Widget build(BuildContext context) {
    u = Provider.of<General_Provider>(context, listen: false).get_user();
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBarPageName(
          pageName: "Change Password",
        ),
        body: Background_VP(
          child: Column(
            children: [
              ShadowBoxList(
                icon: Icon(Icons.edit),
                widgetColumn: <Widget>[
                  H2(textBody: "Password: "),
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
                                hintText: "Please Enter The Old Password"),
                            obscureText: true,
                            onChanged: (value) => {this.oldPassword = value},
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Please Enter The New Password"),
                            obscureText: true,
                            onChanged: (value) => {this.new_password = value},
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ButtonLoading(
                            onTap: (startLoading, stopLoading, btnState) async {
                              //Add code here

                              var check = await changePassword(
                                  u, this.new_password, this.oldPassword);
                              if (check == true) {
                                setState(() {
                                  this.u.pass = this.new_password;
                                  print(u.pass);
                                });
                                SnackBar sc = new SnackBar(
                                  content: Text(
                                    "Password Change Successfully",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontStyle: FontStyle.italic),
                                  ),
                                );
                                Navigator.pop(context);
                                _scaffoldKey.currentState.showSnackBar(sc);
                              } else {
                                stopLoading();
                                Navigator.pop(context);
                                print("Not Entered");
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
            ],
          ),
        ),
      ),
    );
    // TODO: implement build
  }
}
