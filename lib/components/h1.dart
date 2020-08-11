import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ugao/constants.dart';

class H1TextStyle extends TextStyle {
  final fontFamily = "Cantarell";
  final fontSize = h1Size;
  final Color color;
  final fontWeight = FontWeight.w900;
  H1TextStyle({this.color = const Color(0xFF35495e)});
}

class H1 extends StatelessWidget {
  H1({
    this.textBody,
    this.color = kPrimaryAccentColor,
  });
  final String textBody;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      textBody,
      style: H1TextStyle(),
    );
  }
}
