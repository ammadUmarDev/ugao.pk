import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class H3 extends StatelessWidget {
  H3({
    this.textBody,
    this.color = kPrimaryAccentColor,
  });
  final String textBody;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      textBody,
      style: TextStyle(
        fontFamily: "Cantarell",
        fontSize: h3Size,
        color: color,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
