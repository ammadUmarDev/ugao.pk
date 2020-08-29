import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ugao/components/h1.dart';
import '../constants.dart';

class AppBarPageName extends StatelessWidget implements PreferredSizeWidget {
  AppBarPageName({this.pageName});
  final pageName;
  @override
  Size get preferredSize => const Size.fromHeight(55);
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.light,
      iconTheme: IconThemeData(
        color: kPrimaryAccentColor, //change your color here
      ),
      backgroundColor: Colors.transparent,
      title: H1(
        textBody: pageName,
        color: kPrimaryAccentColor,
      ),
      elevation: 0,
    );
  }
}
