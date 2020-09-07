import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ugao/Classes/Product_Model_Fetch.dart';
import 'package:ugao/Providers/product_provider.dart';
import 'package:ugao/components/appbar.dart';
import 'package:ugao/components/grid_tile_product.dart';
import 'package:ugao/components/h3.dart';
import 'package:ugao/screens/product/background_view_product.dart';

import 'background_catagory.dart';

class ProductsScreen extends StatefulWidget {
  String catagoryName;

  ProductsScreen({
    Key key,
    this.catagoryName,
  }) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  ProductFetch productObj;

  @override
  Widget build(BuildContext context) {
    Widget catagoryProducts = StreamBuilder<QuerySnapshot>(
        stream: Provider.of<Product_Provider>(context, listen: false)
            .get_productsRef()
            .where('Prod_Category', isEqualTo: widget.catagoryName)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                ),
                H3(
                  textBody: "Error in fetching products: ${snapshot.error}.",
                )
              ],
            ));
          }

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                  ),
                  H3(
                    textBody: "Not connected to the Stream or null.",
                  )
                ],
              ));

            case ConnectionState.waiting:
              return Center(
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                  ),
                  H3(
                    textBody: "Awaiting for interaction.",
                  )
                ],
              ));

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
                                      type: "buy",
                                      product: Provider.of<Product_Provider>(
                                              context,
                                              listen: false)
                                          .from_firebase_document_to_fetch_object(
                                              catagoryProducts[index]),
                                    )
                                  ])),
                            ),
                          ),
                        );
                      });
                }
              }
              return Center(
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
              return Center(
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                  ),
                  H3(
                    textBody: "All products fetched.",
                  )
                ],
              ));
          }

          return Container(
            child: Center(
                child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                ),
                H3(
                  textBody: "No products found.",
                )
              ],
            )),
          );
        });
    return Scaffold(
      appBar: AppBarPageName(pageName: widget.catagoryName),
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
