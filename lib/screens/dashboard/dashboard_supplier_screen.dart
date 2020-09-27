import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ugao/Classes/User_Model.dart';
import 'package:ugao/Classes/greet_card.dart';
import 'package:ugao/Providers/general_provider.dart';
import 'package:ugao/Providers/product_provider.dart';
import 'package:ugao/components/body_text.dart';
import 'package:ugao/components/grid_tile_product.dart';
import 'package:ugao/components/h1.dart';
import 'package:ugao/components/h2.dart';
import 'package:ugao/components/h3.dart';
import 'package:ugao/components/shadowBoxList.dart';
import 'package:ugao/screens/cart/cart_screen.dart';
import 'package:ugao/screens/order/orders_received_seller.dart';
import 'package:ugao/screens/product/add_product.dart';
import 'package:ugao/screens/profile/profile_screen.dart';
import 'package:ugao/screens/tutorial/tutorial_screen.dart';

import '../../constants.dart';
import 'components/greet_list.dart';
import 'components/main_background.dart';

class DashboardSupplierScreen extends StatefulWidget {
  @override
  _DashboardSupplierScreenState createState() =>
      _DashboardSupplierScreenState();

  List<GreetCard> products = [
    GreetCard(
      'assets/images/promo2.png',
      'Increase Your Sales',
    ),
    GreetCard(
      'assets/images/promo4.png',
      'Work With Us',
    ),
    GreetCard(
      'assets/images/promo1.png',
      'Increase Your Profits',
    ),
  ];
}

class _DashboardSupplierScreenState extends State<DashboardSupplierScreen> {
  User currentUser;
  SwiperController swiperController;
  @override
  void initState() {
    super.initState();
    setState(() {
      currentUser =
          Provider.of<General_Provider>(context, listen: false).get_user();
      print(currentUser.cnic);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => CartScreen())),
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
    Widget recentProducts = StreamBuilder<QuerySnapshot>(
        stream: Provider.of<Product_Provider>(context, listen: false)
            .get_productsRef()
            .where('Creator', isEqualTo: currentUser.cnic)
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
                                      type: "view",
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
                        vertical: 10, horizontal: 10.0),
                    child: ShadowBoxList(
                      icon: Icon(FontAwesomeIcons.firstOrder),
                      widgetColumn: <Widget>[
                        SizedBox(height: 10),
                        H2(textBody: "Orders Recieved"),
                        SizedBox(height: 5),
                        BodyText(
                            textBody:
                                "View all orders recieved from customers."),
                        SizedBox(height: 10),
                      ],
                      onTapFunction: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrdersReceivedSeller(),
                            ));
                      },
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
                          textBody: "My Products",
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
                              'Add New',
                              style: TextStyle(
                                  color: kPrimaryAccentColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddProduct(),
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

//      Scaffold(
//      body: SafeArea(
//        child: Container(
//          child: Center(
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.center,
//              children: [
//                Text("Dashboard Supplier"),
//                RoundedButton(
//                    text: "Orders Recieved",
//                    color: kPrimaryAccentColor,
//                    press: () async {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (context) {
//                            return OrdersReceivedSeller();
//                          },
//                        ),
//                      );
//                    }),
//                RoundedButton(
//                  text: "My Products",
//                  color: kPrimaryAccentColor,
//                  press: () async {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) {
//                          return MyProductsSeller(
//                            userCnic: currentUser.cnic,
//                          );
//                        },
//                      ),
//                    );
//                  },
//                ),
//                RoundedButton(
//                    text: "Add a Product",
//                    color: kPrimaryAccentColor,
//                    press: () async {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (context) {
//                            return AddProduct();
//                          },
//                        ),
//                      );
//                    }
//                    //Navigator.pushNamed(context, "homePage");
//                    ),
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
  }
}
