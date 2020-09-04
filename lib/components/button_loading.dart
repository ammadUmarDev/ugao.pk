import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ugao/components/h1.dart';
import 'package:ugao/constants.dart';

// ignore: must_be_immutable
class ButtonLoading extends StatefulWidget {
  ButtonLoading({@required this.onTap, @required this.labelText});

  dynamic Function(Function, Function, ButtonState) onTap;
  String labelText;

  @override
  _ButtonLoadingState createState() => _ButtonLoadingState();
}

class _ButtonLoadingState extends State<ButtonLoading> {
  @override
  Widget build(BuildContext context) {
    return ArgonButton(
      height: 45,
      roundLoadingShape: true,
      width: MediaQuery.of(context).size.width * 0.45,
      onTap: widget.onTap,
      child: Text(widget.labelText,
          style: H1TextStyle(color: kPrimaryAccentColor)),
      loader: Container(
        padding: EdgeInsets.all(10),
        child: SpinKitRotatingCircle(
          color: kPrimaryAccentColor,
        ),
      ),
      borderRadius: 20.0,
      color: Colors.white,
      borderSide: BorderSide(
        color: kPrimaryAccentColor,
        width: 5.0,
      ),
    );
  }
}
