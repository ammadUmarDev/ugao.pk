import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ugao/Classes/User_Model.dart';
import 'package:ugao/Providers/general_provider.dart';
import 'package:ugao/components/appbar.dart';
import 'package:ugao/components/body_text.dart';
import 'package:ugao/components/h2.dart';
import 'package:ugao/components/h3.dart';
import 'package:ugao/constants.dart';
import 'package:ugao/screens/profile/settings/security_settings.dart';
import 'package:ugao/screens/profile/settings/general_settings_screen.dart';

import 'faq_page.dart';

class Profile_Page_State extends StatefulWidget {
  ProfilePage createState() => ProfilePage();
}

class ProfilePage extends State<Profile_Page_State> {
  User user;
  String description = "Null";
  String userImagePath;
  @override
  Widget build(BuildContext context) {
    user = Provider.of<General_Provider>(context, listen: false).get_user();
    Widget showDesciption() {
      if (user.usertype == FARMER) {
//        this.description = "CNIC: " +
//            this.user.cnic +
//            "\n\nUserType: " +
//            this.user.usertype +
//            "\n\nPhone Number: " +
//            user.phone_no +
//            "\nAddress:" +
//            this.user.farmer.fAddress;
        userImagePath = "assets/icons/farmIcon.png";
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  H3(textBody: "CNIC:"),
                  SizedBox(height: 5),
                  BodyText(textBody: this.user.cnic),
                  Divider(),
                  H3(textBody: "Account Type:"),
                  SizedBox(height: 5),
                  BodyText(textBody: this.user.usertype),
                  Divider(),
                  H3(textBody: "Phone#:"),
                  SizedBox(height: 5),
                  BodyText(textBody: user.phone_no),
                  Divider(),
                  H3(textBody: "Address:"),
                  SizedBox(height: 5),
                  BodyText(textBody: this.user.farmer.fAddress),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  H3(textBody: "Farming Experience:"),
                  SizedBox(height: 5),
                  BodyText(textBody: this.user.farmer.fExperience + " years"),
                  Divider(),
                  H3(textBody: "Catagory Type:"),
                  SizedBox(height: 5),
                  BodyText(textBody: this.user.farmer.fCategory),
                  Divider(),
                  H3(textBody: "Service Type:"),
                  SizedBox(height: 5),
                  BodyText(textBody: this.user.farmer.fService),
                  Divider(),
                  H3(textBody: "Account Status:"),
                  SizedBox(height: 5),
                  BodyText(textBody: "Active"),
                ],
              ),
            ],
          ),
        );
      }
      if (user.usertype == SUPPLIER) {
//        this.description = "CNIC: " +
//            this.user.cnic +
//            "\nPhone_NO: " +
//            user.phone_no +
//            "\nUserType: " +
//            this.user.usertype +
//            "\nAddress:" +
//            this.user.supplier.sAddress;
        userImagePath = "assets/icons/supIcon.png";
      }
      if (user.usertype == CUSTOMER) {
//        this.description = "CNIC: " +
//            this.user.cnic +
//            "\nPhone_NO: " +
//            user.phone_no +
//            "\nUserType: " +
//            this.user.usertype +
//            "\nWebsite:" +
//            this.user.customer.ccWebsite;
        userImagePath = "assets/icons/custIcon.png";
      }
    }

    Widget showOrder() {
      if (user.usertype == CUSTOMER || user.usertype == FARMER) {
        return Container(
          child: ListTile(
            title: Text('Orders'),
            subtitle: Text('Check placed order statuses'),
            leading: Icon(FontAwesomeIcons.thList),
            trailing: Icon(Icons.chevron_right, color: kPrimaryLightColor),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => SettingsScreen())),
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      appBar: AppBarPageName(pageName: ""),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  maxRadius: 45,
                  backgroundImage: AssetImage(userImagePath),
                  backgroundColor: kPrimaryLightColor.withOpacity(0.5),
                ),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: H2(textBody: this.user.fullName)),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            //change to app color
                            color: kPrimaryLightColor,
                            blurRadius: 5,
                            spreadRadius: 4,
                            offset: Offset(0, 1))
                      ]),
                  child: Center(
                    child: showDesciption(),
                  ),
                ),
                SizedBox(height: 5),
                ListTile(
                  title: Text('General Settings'),
                  subtitle: Text('Change account details and logout'),
                  leading: Icon(FontAwesomeIcons.userCog),
                  trailing:
                      Icon(Icons.chevron_right, color: kPrimaryLightColor),
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => SettingsScreen())),
                ),
                Divider(),
                showOrder(),
                Divider(),
                ListTile(
                  title: Text('FAQ'),
                  subtitle: Text('Questions and Answer'),
                  leading: Icon(FontAwesomeIcons.solidQuestionCircle),
                  trailing:
                      Icon(Icons.chevron_right, color: kPrimaryLightColor),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => FaqScreen())),
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
