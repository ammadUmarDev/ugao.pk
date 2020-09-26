import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedAlertDialog extends StatelessWidget {
  final Function onButtonPressed;
  final Function onChanged;
  final String title;
  final String buttonName;

  RoundedAlertDialog(
      {@required this.title,
      this.onChanged,
      this.buttonName = "OK",
      @required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(this.title),
      content: this.onChanged != null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  onChanged: this.onChanged,
                  // controller: _codeController,
                ),
              ],
            )
          : null,
      actions: <Widget>[
        FlatButton(
          child: Text(this.buttonName),
          textColor: Colors.white,
          color: Colors.blue,
          onPressed: this.onButtonPressed,
        )
      ],
    );
  }
}
