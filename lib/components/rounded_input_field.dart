import 'package:flutter/material.dart';
import 'package:ugao/components/text_field_container.dart';
import '../constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final keyboardType;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryAccentColor,
        keyboardType: this.keyboardType,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryAccentColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
