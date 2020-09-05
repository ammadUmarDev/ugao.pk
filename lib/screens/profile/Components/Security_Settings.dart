import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ugao/components/appbar.dart';
import 'package:ugao/components/body_text.dart';
import 'package:ugao/components/h2.dart';
import 'package:ugao/components/h3.dart';
import 'package:ugao/screens/login/components/background.dart';

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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBarPageName(
          pageName: "Change Password",
        ),
        body: ListView(
          children: [
            ShadowBoxList(
              icon: Icon(Icons.edit),
              widgetColumn: <Widget>[
                H2(textBody: "Product Name"),
                SizedBox(height: 5),
                BodyText(textBody: "Hello 1st Box"),
                SizedBox(height: 10),
                H2(textBody: "Product Description"),
                SizedBox(height: 5),
                BodyText(textBody: "Hello 2nt Box"),
                SizedBox(height: 10),
                H2(textBody: "Product Quanity"),
                SizedBox(height: 5),
                BodyText(textBody: "Hello 3nd Box"),
                SizedBox(height: 10),
                H2(textBody: "Product Service Type"),
                SizedBox(height: 5),
                BodyText(textBody: "Hello 4nd Box"),
                SizedBox(height: 10),
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
                        H3(textBody: "Edit Here"),
                        SizedBox(
                          height: 10,
                        ),
                        ButtonLoading(
                          onTap: (startLoading, stopLoading, btnState) async {
                            if (btnState == ButtonState.Idle) {
                              startLoading();
                              //Add code here
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
          ],
        ),
      ),
    );
    // TODO: implement build
  }
}
