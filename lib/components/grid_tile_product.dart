import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ugao/Classes/Firebase_Functions.dart';
import 'package:ugao/Classes/Product_Model_Fetch.dart';
import 'package:ugao/components/body_text.dart';
import 'package:ugao/components/h3.dart';
import 'package:ugao/screens/product/edit_product_screen.dart';
import 'package:ugao/screens/product/view_product_screen.dart';

class GridTileProduct extends StatelessWidget {
  final ProductFetch product;
  final String type;

  GridTileProduct({
    Key key,
    this.product,
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height / 7;
    double cardWidth = MediaQuery.of(context).size.width / 7;
    return InkWell(
      onTap: () async {
        if (type == "buy") {
          var userObj = await getUser(product.creator).then((result) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => /*add route to product page*/ ViewProduct(
                  productObj: product,
                  userObj: result,
                ),
              ),
            );
          });
        }
        if (type == "view") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => /*add route to product page*/ EditProduct(
                productObj: product,
              ),
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.only(top: 0),
        child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            elevation: 0,
            child: Center(
              child: Column(
                children: <Widget>[
                  Image.network(
                    product.prodImage,
                    width: cardWidth,
                    height: cardHeight,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  H3(
                    textBody: product.prodName.length <= 20
                        ? product.prodName
                        : product.prodName.substring(0, 20),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  BodyText(
                    textBody: "PKR " + product.price.toString(),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
