import 'package:flutter/material.dart';
import 'package:ugao/Classes/User_Model.dart';
import 'package:ugao/components/appbar.dart';
import 'package:ugao/components/body_text.dart';
import 'package:ugao/components/h2.dart';
import 'package:ugao/components/h3.dart';

import '../../constants.dart';

class SellerProfileScreen extends StatefulWidget {
  User userObj;

  @override
  _SellerProfileScreenState createState() => _SellerProfileScreenState();
  SellerProfileScreen({
    Key key,
    this.userObj,
  }) : super(key: key);
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  String description = "Null";
  String userImagePath;
  @override
  Widget build(BuildContext context) {
    if (widget.userObj.usertype == FARMER) {
      userImagePath = "assets/icons/farmIcon.png";
    }
    if (widget.userObj.usertype == SUPPLIER) {
      userImagePath = "assets/icons/supIcon.png";
    }
    if (widget.userObj.usertype == CUSTOMER) {
      userImagePath = "assets/icons/custIcon.png";
    }
    Widget showCustomerCommercialDescription() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          H3(textBody: "Company Name:"),
          SizedBox(height: 5),
          BodyText(textBody: this.widget.userObj.customer.ccName),
          SizedBox(height: 10),
          H3(textBody: "Company Phone No:"),
          SizedBox(height: 5),
          BodyText(textBody: this.widget.userObj.customer.ccPhoneNumber),
          SizedBox(height: 10),
          H3(textBody: "Company Website:"),
          SizedBox(height: 5),
          BodyText(textBody: this.widget.userObj.customer.ccWebsite),
          SizedBox(height: 10),
          H3(textBody: "Account Status:"),
          SizedBox(height: 5),
          BodyText(textBody: "Active"),
        ],
      );
    }

    // ignore: missing_return
    Widget showDesciption() {
      if (widget.userObj.usertype == FARMER) {
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
                    BodyText(textBody: "Verified"),
                    SizedBox(height: 10),
                    H3(textBody: "Account Type:"),
                    SizedBox(height: 5),
                    BodyText(textBody: this.widget.userObj.usertype),
                    SizedBox(height: 10),
                    H3(textBody: "Phone#:"),
                    SizedBox(height: 5),
                    BodyText(textBody: widget.userObj.phone_no),
                    SizedBox(height: 10),
                    H3(textBody: "Address:"),
                    SizedBox(height: 5),
                    BodyText(textBody: this.widget.userObj.farmer.fAddress),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  H3(textBody: "Farming Experience:"),
                  SizedBox(height: 5),
                  BodyText(
                      textBody:
                          this.widget.userObj.farmer.fExperience + " years"),
                  SizedBox(height: 10),
                  H3(textBody: "Catagory Type:"),
                  SizedBox(height: 5),
                  BodyText(textBody: this.widget.userObj.farmer.fCategory),
                  SizedBox(height: 10),
                  H3(textBody: "Service Type:"),
                  SizedBox(height: 5),
                  BodyText(textBody: this.widget.userObj.farmer.fService),
                  SizedBox(height: 10),
                  H3(textBody: "Account Status:"),
                  SizedBox(height: 5),
                  BodyText(textBody: "Active"),
                ],
              ),
            ],
          ),
        );
      }
      if (widget.userObj.usertype == SUPPLIER) {
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
                  BodyText(textBody: "Verified"),
                  SizedBox(height: 10),
                  H3(textBody: "Account Type:"),
                  SizedBox(height: 5),
                  BodyText(textBody: this.widget.userObj.usertype),
                  SizedBox(height: 10),
                  H3(textBody: "Phone#:"),
                  SizedBox(height: 5),
                  BodyText(textBody: widget.userObj.phone_no),
                  SizedBox(height: 10),
                  H3(textBody: "Address:"),
                  SizedBox(height: 5),
                  BodyText(textBody: this.widget.userObj.supplier.sAddress),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  H3(textBody: "Work Experience:"),
                  SizedBox(height: 5),
                  BodyText(
                    textBody:
                        this.widget.userObj.supplier.scExperience + " years",
                  ),
                  SizedBox(height: 10),
                  H3(textBody: "Catagory Type:"),
                  SizedBox(height: 5),
                  BodyText(textBody: this.widget.userObj.supplier.scExperience),
                  SizedBox(height: 10),
                  H3(textBody: "Service Type:"),
                  SizedBox(height: 5),
                  BodyText(
                      textBody: this
                                  .widget
                                  .userObj
                                  .supplier
                                  .sSelectedTypes
                                  .toString() !=
                              null
                          ? this
                              .widget
                              .userObj
                              .supplier
                              .sSelectedTypes
                              .toString()
                          : "Not Selected"),
                  SizedBox(height: 10),
                  H3(textBody: "Account Status:"),
                  SizedBox(height: 5),
                  BodyText(textBody: "Active"),
                ],
              ),
            ],
          ),
        );
      }
      if (widget.userObj.usertype == CUSTOMER) {
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
                  BodyText(textBody: "Verified"),
                  SizedBox(height: 10),
                  H3(textBody: "Account Type:"),
                  SizedBox(height: 5),
                  BodyText(textBody: this.widget.userObj.usertype),
                  SizedBox(height: 10),
                  H3(textBody: "Phone#:"),
                  SizedBox(height: 5),
                  BodyText(textBody: widget.userObj.phone_no),
                  SizedBox(height: 10),
                  H3(textBody: "Customer type:"),
                  SizedBox(height: 5),
                  BodyText(textBody: this.widget.userObj.customer.cAccountType),
                ],
              ),
              this.widget.userObj.customer.cAccountType == "Commercial"
                  ? showCustomerCommercialDescription()
                  : SizedBox(height: 0),
            ],
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      appBar: AppBarPageName(pageName: "Seller Profile"),
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
                    child: H2(textBody: this.widget.userObj.fullName)),
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
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
