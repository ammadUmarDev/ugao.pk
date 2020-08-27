import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedAlertDialog extends StatelessWidget {
  final String content;

  RoundedAlertDialog({this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(content==null?"Alert Dialog":content), //TODO: make dialog pretty
    );
  }
}
