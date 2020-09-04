import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ugao/components/text_field_container.dart';

import '../constants.dart';

class RoundedIntlPhoneField extends StatelessWidget {
  final onChanged;

  RoundedIntlPhoneField({@required this.onChanged});

  //TODO: change color of "+92"

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: IntlPhoneField(
        onChanged: onChanged,
        showDropdownIcon: false,
        initialCountryCode: "PK",
          decoration:InputDecoration(
            hintText: "Phone No",
            border: InputBorder.none,
            fillColor: kPrimaryAccentColor,
          )
      ),
    );
  }
}
