import 'package:flutter/material.dart';
import 'package:ugao/Classes/Category_Model.dart';
import 'package:ugao/components/appbar.dart';
import 'package:ugao/constants.dart';
import 'package:ugao/components/staggered_category_card.dart';

import 'background_catagory.dart';

class CategoryListScreen extends StatefulWidget {
  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Category> categories = [
    Category(
      'Machinery',
    ),
    Category(
      'Tools & Equipment',
    ),
    Category(
      'Pesticide',
    ),
    Category(
      'Fertilizer',
    ),
    Category(
      'Livestock',
    ),
    Category(
      'Dairy',
    ),
    Category(
      'Meat',
    ),
    Category(
      'Crop',
    ),
  ];

  List<Category> searchResults;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchResults = categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBarPageName(
        pageName: "Categories",
      ),
      body: Background_CP(
        child: SafeArea(
          child: Material(
            color: Color(0xffF9F9F9),
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (_, index) => Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: StaggeredCardCard(
                          begin: kPrimaryLightColor,
                          end: kPrimaryLightColor,
                          categoryName: searchResults[index].category,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
