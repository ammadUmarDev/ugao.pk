import 'package:flutter/material.dart';
import 'package:ugao/components/h1.dart';
import 'package:ugao/constants.dart';

import '../screens/product/catagory_products_screen.dart';

class StaggeredCardCard extends StatefulWidget {
  final Color begin;
  final Color end;
  final String categoryName;

  const StaggeredCardCard({Key key, this.begin, this.end, this.categoryName})
      : super(key: key);

  @override
  _StaggeredCardCardState createState() => _StaggeredCardCardState();
}

class _StaggeredCardCardState extends State<StaggeredCardCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [kPrimaryColor, kPrimaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
              alignment: Alignment(-1, 0),
              child: H1(
                textBody: widget.categoryName,
                color: Colors.white,
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
//        mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(24))),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'View more',
                    style: TextStyle(
                        color: kPrimaryAccentColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => /*add route to product page*/ ProductsScreen(
                        catagoryName: widget.categoryName,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
