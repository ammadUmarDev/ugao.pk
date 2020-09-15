import 'package:flutter/material.dart';
import 'package:ugao/Classes/Category_Model.dart';
import 'category_card.dart';

class TabView extends StatelessWidget {
  List<Category> categories = [
    Category(
      'Gadgets',
    ),
    Category(
      'Gadgets',
    ),
    Category(
      'Gadgets',
    ),
    Category(
      'Gadgets',
    ),
    Category(
      'Gadgets',
    ),
    Category(
      'Gadgets',
    ),
    Category(
      'Gadgets',
    ),
    Category(
      'Gadgets',
    ),
  ];

  final TabController tabController;

  TabView({Key key, this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height / 9);
    return TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(8.0),
                    height: MediaQuery.of(context).size.height / 9,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (_, index) => CategoryCard(
                              category: categories[index],
                            ))),
                SizedBox(
                  height: 16.0,
                ),
                Flexible(child: Text("hello")),
              ],
            ),
          ),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: Text("hello")),
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: Text("hello")),
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: Text("hello")),
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: Text("hello")),
          ]),
        ]);
  }
}
