import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ugao/components/text_field_container.dart';
import '../constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final keyboardType;
  Set<TextInputFormatter> inputFormatters = Set<TextInputFormatter>();
  RoundedInputField({
    Key key,
    this.hintText,
    this.icon,
    this.onChanged,
    this.keyboardType,
    inputFormatters,
  }) : super(key: key) {
    if (inputFormatters != null) this.inputFormatters = inputFormatters;
  }

  @override
  Widget build(BuildContext context) {
    if (keyboardType == TextInputType.number) {
      inputFormatters.add(WhitelistingTextInputFormatter.digitsOnly);
    }
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
        inputFormatters: inputFormatters.toList(),
      ),
    );
  }
}
