import 'package:flutter/material.dart';
import 'package:ugao/components/text_field_container.dart';

import '../constants.dart';

class RoundedCNICField extends StatelessWidget {
  final onChanged;

  RoundedCNICField({@required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryAccentColor,
        keyboardType: TextInputType.number,
        maxLength: 13,
        decoration: InputDecoration(
          icon: Icon(
            Icons.person,
            color: kPrimaryAccentColor,
          ),
          hintText: "Your CNIC",
          border: InputBorder.none,
        ),
      ),
    );
  }
}
