import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class H2 extends StatelessWidget {
  H2({
    this.textBody,
    this.color = kPrimaryAccentColor,
    this.align = TextAlign.left,
  });
  final String textBody;
  final Color color;
  final align;
  @override
  Widget build(BuildContext context) {
    return Text(
      textBody,
      style: TextStyle(
        fontFamily: "Cantarell",
        fontSize: h2Size,
        color: color,
        fontWeight: FontWeight.w900,
      ),
      textAlign: align,
    );
  }
}
