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
import 'package:ugao/screens/profile/about_us.dart';
import 'package:ugao/screens/profile/settings/general_settings_screen.dart';
import 'faq_page.dart';
import 'package:ugao/screens/order/myorders_screen.dart';

// ignore: camel_case_types
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
    if (user.usertype == FARMER) {
      userImagePath = "assets/icons/farmIcon.png";
    }
    if (user.usertype == SUPPLIER) {
      userImagePath = "assets/icons/supIcon.png";
    }
    if (user.usertype == CUSTOMER) {
      userImagePath = "assets/icons/custIcon.png";
    }
    Widget showCustomerCommercialDescription() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          H3(textBody: "Company Name:"),
          SizedBox(height: 5),
          BodyText(textBody: this.user.customer.ccName),
          Divider(),
          H3(textBody: "Company Phone No:"),
          SizedBox(height: 5),
          BodyText(textBody: this.user.customer.ccPhoneNumber),
          Divider(),
          H3(textBody: "Company Website:"),
          SizedBox(height: 5),
          BodyText(textBody: this.user.customer.ccWebsite),
          Divider(),
          H3(textBody: "Account Status:"),
          SizedBox(height: 5),
          BodyText(textBody: "Active"),
        ],
      );
    }

    // ignore: missing_return
    Widget showDesciption() {
      if (user.usertype == FARMER) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
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
                  BodyText(textBody: this.user.supplier.sAddress),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  H3(textBody: "Work Experience:"),
                  SizedBox(height: 5),
                  BodyText(
                      textBody: this.user.supplier.scExperience + " years"),
                  Divider(),
                  H3(textBody: "Catagory Type:"),
                  SizedBox(height: 5),
                  BodyText(textBody: this.user.supplier.scExperience),
                  Divider(),
                  H3(textBody: "Service Type:"),
                  SizedBox(height: 5),
                  BodyText(
                      textBody:
                          this.user.supplier.sSelectedTypes.toString() != null
                              ? this.user.supplier.sSelectedTypes.toString()
                              : "Not Selected"),
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
      if (user.usertype == CUSTOMER) {
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
                  H3(textBody: "Customer type:"),
                  SizedBox(height: 5),
                  BodyText(textBody: this.user.customer.cAccountType),
                ],
              ),
              this.user.customer.cAccountType == "Commercial"
                  ? showCustomerCommercialDescription()
                  : SizedBox(height: 0),
            ],
          ),
        );
      }
    }

    Widget showOrder() {
      if (user.usertype == CUSTOMER || user.usertype == FARMER) {
        return Container(
          child: Column(
            children: [
              ListTile(
                title: Text('Orders'),
                subtitle: Text('Check placed order statuses'),
                leading: Icon(FontAwesomeIcons.thList),
                trailing: Icon(Icons.chevron_right, color: kPrimaryLightColor),
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => MyOrders())),
              ),
              Divider(),
            ],
          ),
        );
      } else {
        return SizedBox(
          height: 0,
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
                ListTile(
                  title: Text('About Us'),
                  subtitle: Text('Get to know Vectech'),
                  leading: Icon(FontAwesomeIcons.building),
                  trailing:
                      Icon(Icons.chevron_right, color: kPrimaryLightColor),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => About())),
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
