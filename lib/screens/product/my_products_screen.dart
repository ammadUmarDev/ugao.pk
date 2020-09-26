import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ugao/components/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:ugao/Classes/Product_Model_Fetch.dart';
import 'package:ugao/Providers/product_provider.dart';
import 'package:ugao/components/grid_tile_product.dart';
import 'package:ugao/components/h3.dart';
import 'package:ugao/screens/product/background_catagory.dart';

class MyProductsSeller extends StatefulWidget {
  String userCnic;

  MyProductsSeller({
    Key key,
    this.userCnic,
  }) : super(key: key);

  @override
  _MyProductsSellerState createState() => _MyProductsSellerState();
}

class _MyProductsSellerState extends State<MyProductsSeller> {
  ProductFetch productObj;

  @override
  Widget build(BuildContext context) {
    Widget catagoryProducts = StreamBuilder<QuerySnapshot>(
        stream: Provider.of<Product_Provider>(context, listen: false)
            .get_productsRef()
            .where('Creator', isEqualTo: widget.userCnic)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return H3(
                textBody: 'Error in fetching products: ${snapshot.error}');
          }

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return H3(textBody: 'Not connected to the Stream or null');

            case ConnectionState.waiting:
              return H3(textBody: 'Awaiting for interaction');

            case ConnectionState.active:
              print("Stream has started but not finished");

              var totalProductCount = 0;
              List<DocumentSnapshot> catagoryProducts;

              if (snapshot.hasData) {
                catagoryProducts = snapshot.data.documents;
                totalProductCount = catagoryProducts.length;

                if (totalProductCount > 0) {
                  return new GridView.builder(
                      itemCount: totalProductCount,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) {
                        return Center(
                          child: Card(
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              onTap: () {
                                print('Tapped on thumbnail.');
                                print(
                                    'Product doc id: ${catagoryProducts[index].documentID}');
                              },
                              child: Container(
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                    GridTileProduct(
                                      type: "view",
                                      product: Provider.of<Product_Provider>(
                                              context,
                                              listen: false)
                                          .from_firebase_document_to_fetch_object(
                                        catagoryProducts[index],
                                      ),
                                    )
                                  ])),
                            ),
                          ),
                        );
                      });
                }
              }
              return new Center(
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                  ),
                  H3(
                    textBody: "No products found.",
                  )
                ],
              ));

            case ConnectionState.done:
              return H3(textBody: 'All products fetched');
          }

          return Container(
            child: H3(textBody: "No products found."),
          );
        });
    return Scaffold(
      appBar: AppBarPageName(pageName: "My Products"),
      body: Background_CP(
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              catagoryProducts,
            ],
          ),
        ),
      ),
    );
  }
}
