import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ugao/components/body_text.dart';
import 'package:ugao/constants.dart';
import 'package:ugao/screens/product/category_products_screen.dart';

class CategoryDisplay extends StatelessWidget {
  double width, height = 55.0;
  double customFontSize = 13;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Column(
                children: [
                  Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductsScreen(
                                    categoryName: "Machinery",
                                  )),
                        );
                      },
                      shape: CircleBorder(),
                      child: Icon(
                        FontAwesomeIcons.tractor,
                        color: kPrimaryAccentColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  BodyText(textBody: "Machinery"),
                ],
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductsScreen(
                                    categoryName: "Tools & Equipment",
                                  )),
                        );
                      },
                      shape: CircleBorder(),
                      child: Icon(
                        FontAwesomeIcons.toolbox,
                        color: kPrimaryAccentColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  BodyText(textBody: "Tools & Equipment"),
                ],
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Column(
                children: [
                  Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductsScreen(
                                    categoryName: "Pesticide",
                                  )),
                        );
                      },
                      shape: CircleBorder(),
                      child: Icon(
                        FontAwesomeIcons.bug,
                        color: kPrimaryAccentColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  BodyText(textBody: "Pesticide"),
                ],
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductsScreen(
                                    categoryName: "Fertilizer",
                                  )),
                        );
                      },
                      shape: CircleBorder(),
                      child: Icon(
                        FontAwesomeIcons.seedling,
                        color: kPrimaryAccentColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  BodyText(textBody: "Fertilizer"),
                ],
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Column(
                children: [
                  Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductsScreen(
                                    categoryName: "Livestock",
                                  )),
                        );
                      },
                      shape: CircleBorder(),
                      child: Icon(
                        FontAwesomeIcons.horseHead,
                        color: kPrimaryAccentColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  BodyText(textBody: "Livestock"),
                ],
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductsScreen(
                                    categoryName: "Dairy",
                                  )),
                        );
                      },
                      shape: CircleBorder(),
                      child: Icon(
                        FontAwesomeIcons.glassWhiskey,
                        color: kPrimaryAccentColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  BodyText(textBody: "Dairy"),
                ],
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Column(
                children: [
                  Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductsScreen(
                                    categoryName: "Meat",
                                  )),
                        );
                      },
                      shape: CircleBorder(),
                      child: Icon(
                        FontAwesomeIcons.drumstickBite,
                        color: kPrimaryAccentColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  BodyText(textBody: "Meat"),
                ],
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductsScreen(
                                    categoryName: "Crop",
                                  )),
                        );
                      },
                      shape: CircleBorder(),
                      child: Icon(
                        FontAwesomeIcons.leaf,
                        color: kPrimaryAccentColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  BodyText(textBody: "Crop"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
