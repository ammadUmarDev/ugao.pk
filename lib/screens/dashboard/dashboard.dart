import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ugao/constants.dart';

import 'dashboard_customer_screen.dart';
import 'dashboard_supplier_screen.dart';

class DashBoard extends StatefulWidget {
  static final String id = 'dashBoard';

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: buildHomeScreen(),
    );
  }

  Scaffold buildHomeScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          DashboardCustomerScreen(),
          DashboardSupplierScreen(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        scrollDirection: Axis.horizontal,
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: kPrimaryLightColor,
        inactiveColor: kPrimaryAccentColor,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
            Icons.present_to_all,
            size: 25,
          )),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.supervisor_account,
            size: 25,
          )),
        ],
      ),
    );
  }
}
