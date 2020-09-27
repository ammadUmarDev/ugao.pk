import 'package:flutter/material.dart';
import 'package:ugao/components/body_text.dart';
import 'package:ugao/components/h1.dart';
import 'package:ugao/constants.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
            colors: [
              kPrimaryAccentColor,
              kPrimaryLightColor,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Ugao.pk",
                            style: TextStyle(
                              fontFamily: "Cantarell",
                              fontSize: 40.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Revolutionizing Agriculture in Pakistan",
                            style: TextStyle(
                              fontFamily: "Cantarell",
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: ListView(
                    children: <Widget>[
                      H1(textBody: "Get to know us"),
                      SizedBox(height: 5),
                      BodyText(
                          textBody:
                              "Welcome to Vectech®. We provide intelligent solutions to unlock new possibilities. Together, we can bring your ideas to life so reach out for a new project."),
                      SizedBox(height: 15),
                      H1(textBody: "What is Ugao.pk ® ?"),
                      SizedBox(height: 5),
                      BodyText(
                          textBody:
                              "Farmers not getting the deserved worth of the product due to presence of and mismanagement by middlemen i.e. the people linking farmers and market places. Ugao.pk would help farmers by maximizing their profits through minimizing the role of middlemen."),
                      SizedBox(height: 15),
                      H1(textBody: "Contact us"),
                      SizedBox(height: 5),
                      BodyText(
                          textBody:
                              "Reach out to Vechtech® at vechtech.contact@gmail.com"),
                      SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
