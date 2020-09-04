import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ugao/components/text_field_container.dart';

import '../constants.dart';

class RoundedCNICField extends StatelessWidget {
  final onChanged;
  final _mobileFormatter = NumberTextInputFormatter();

  RoundedCNICField({@required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryAccentColor,
        keyboardType: TextInputType.number,
        maxLength: 15,
        decoration: InputDecoration(
          icon: Icon(
            Icons.person,
            color: kPrimaryAccentColor,
          ),
          hintText: "Your CNIC",
          border: InputBorder.none,
        ),
        inputFormatters: [
          WhitelistingTextInputFormatter.digitsOnly,
          _mobileFormatter
        ],
      ),
    );
  }
}

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = new StringBuffer();
    if (newTextLength >= 6) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 5) + '-');
      if (newValue.selection.end >= 5) selectionIndex += 1;
    }
    if (newTextLength >= 13) {
      newText.write(newValue.text.substring(5, usedSubstringIndex = 12) + '-');
      if (newValue.selection.end >= 12) selectionIndex += 1;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}