import 'package:flutter/material.dart';
import 'package:ugao/components/text_field_container.dart';
import '../constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryAccentColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryAccentColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryAccentColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
