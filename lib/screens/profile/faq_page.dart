import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ugao/components/appbar.dart';
import 'package:ugao/components/body_text.dart';
import 'package:ugao/components/h3.dart';
import 'package:ugao/constants.dart';

class FaqScreen extends StatefulWidget {
  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  List<Panel> panels = [
    Panel(
        'HOW CAN I CHANGE MY SHIPPING ADDRESS?',
        'By default, the last used shipping address will be saved intoto your Sample Store account. When you are checkingout your order, the default shipping address will be displayedand you have the option to amend it if you need to.',
        false),
    Panel(
        'HOW MANY FREE SAMPLES CAN I REDEEM?',
        'Due to the limited quantity, each member`s account is only entitled to 1 unique free sample. You can check out up to 4 free samples in each checkout.',
        false),
    Panel(
        'HOW CAN I TRACK MY ORDERS & PAYMENT?',
        'By default, the last used shipping address will be saved intoto your Sample Store account. When you are checkingout your order, the default shipping address will be displayedand you have the option to amend it if you need to.',
        false),
    Panel(
        'HOW LONG WILL IT TAKE FOR MY ORDER TO ARRIVE AFTER I MAKE PAYMENT?',
        'By default, the last used shipping address will be saved intoto your Sample Store account. When you are checkingout your order, the default shipping address will be displayedand you have the option to amend it if you need to.',
        false),
    Panel(
        'HOW DO YOU SHIP MY ORDERS?',
        'By default, the last used shipping address will be saved intoto your Sample Store account. When you are checkingout your order, the default shipping address will be displayedand you have the option to amend it if you need to.',
        false),
    Panel(
        'HOW DO I MAKE PAYMENTS USING PAYPAL? HOW DOES IT WORK?',
        'By default, the last used shipping address will be saved intoto your Sample Store account. When you are checkingout your order, the default shipping address will be displayedand you have the option to amend it if you need to.',
        false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarPageName(
        pageName: "FAQs",
      ),
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: ListView(
            children: <Widget>[
              ...panels
                  .map((panel) => ExpansionTile(
                          title: H3(textBody: panel.title),
                          children: [
                            Container(
                                padding: EdgeInsets.all(16.0),
                                color: kPrimaryLightColor.withOpacity(0.3),
                                child: BodyText(textBody: panel.content))
                          ]))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}

class Panel {
  String title;
  String content;
  bool expanded;

  Panel(this.title, this.content, this.expanded);
}
