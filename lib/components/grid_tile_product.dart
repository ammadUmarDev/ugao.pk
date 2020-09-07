import 'package:flutter/material.dart';
import 'package:ugao/Classes/Product_Model_Fetch.dart';
import 'package:ugao/components/body_text.dart';
import 'package:ugao/components/h3.dart';
import 'package:ugao/screens/dashboard/dashboard.dart';
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
    return InkWell(
      onTap: () {
        if (type == "buy") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => /*add route to product page*/ ViewProduct(
                productObj: product,
              ),
            ),
          );
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
      child: Flexible(
        child: Container(
          padding: EdgeInsets.only(top: 5),
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
                      width: 130,
                      height: 130,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    H3(
                      textBody: product.prodName.length <= 40
                          ? product.prodName
                          : product.prodName.substring(0, 40),
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
      ),
    );
  }
}
