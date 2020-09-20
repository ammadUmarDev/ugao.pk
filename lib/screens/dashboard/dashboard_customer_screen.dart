import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:ugao/Classes/greet_card.dart';
import 'package:ugao/Providers/product_provider.dart';
import 'package:ugao/components/grid_tile_product.dart';
import 'package:ugao/components/h3.dart';
import 'package:ugao/components/rounded_button.dart';
import 'package:ugao/components/search_widget.dart';
import 'package:ugao/components/h1.dart';
import 'package:ugao/screens/Cart/cart_screen.dart';
import 'package:ugao/screens/cart/cart_screen.dart';
import 'package:ugao/screens/product/category_list_screen.dart';
import 'package:ugao/screens/profile/profile_screen.dart';
import 'package:ugao/screens/tutorial/tutorial_screen.dart';
import 'package:ugao/settings/components/custom_background.dart';
import 'package:ugao/screens/cart/cart_screen.dart';

import '../../constants.dart';
import 'components/greet_list.dart';

class DashboardCustomerScreen extends StatefulWidget {
  @override
  _DashboardCustomerScreenState createState() =>
      _DashboardCustomerScreenState();

  List<GreetCard> products = [
    GreetCard(
      'assets/images/promo2.png',
      'increase your yeild',
    ),
    GreetCard(
      'assets/images/promo4.png',
      'grow with us',
    ),
    GreetCard(
      'assets/images/promo1.png',
      'all under one app',
    ),
  ];
}

class _DashboardCustomerScreenState extends State<DashboardCustomerScreen> {
  SwiperController swiperController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget recentProducts = StreamBuilder<QuerySnapshot>(
        stream: Provider.of<Product_Provider>(context, listen: false)
            .get_productsRef()
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
              ),
            ),
          );
        });
    Widget appBar = Container(
      height: kToolbarHeight + MediaQuery.of(context).padding.top,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              IconButton(
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => TutorialScreen())),
                  icon: Icon(
                    Icons.live_tv,
                    size: 30,
                    color: kPrimaryAccentColor,
                  )),
            ],
          ),
          Container(
            child: Row(
              children: [
                IconButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => Profile_Page_State())),
                    icon: Icon(
                      Icons.person,
                      size: 30,
                      color: kPrimaryAccentColor,
                    )),
                IconButton(
                    //TODO: fix this later
                    //onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CartScreen())),
                    icon: Icon(
                  Icons.shopping_cart,
                  size: 30,
                  color: kPrimaryAccentColor,
                )),
              ],
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: CustomPaint(
        painter: MainBackground(),
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: appBar,
                ),
                SliverToBoxAdapter(
                  child: SearchWidget(),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GreetList(
                      products: widget.products,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        H1(
                          textBody: "Categories",
                          color: kPrimaryAccentColor,
                        ),
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24))),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Text(
                              'View All',
                              style: TextStyle(
                                  color: kPrimaryAccentColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryListScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
              child: ListView(
                children: <Widget>[
                  recentProducts,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
