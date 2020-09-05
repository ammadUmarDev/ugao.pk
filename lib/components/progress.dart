import 'package:flutter/material.dart';
import 'package:ugao/constants.dart';

Widget linearProgress(context) {
  return Container(
    padding: EdgeInsets.only(bottom: 10.0),
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(kPrimaryAccentColor),
      backgroundColor: kPrimaryLightColor,
    ),
  );
}
