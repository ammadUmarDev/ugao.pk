import 'package:flutter/material.dart';
import 'package:ugao/components/text_field_container.dart';
import '../constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);
  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {

  bool _obscureText=true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              obscureText: _obscureText,
              onChanged: widget.onChanged,
              cursorColor: kPrimaryAccentColor,
              decoration: InputDecoration(
                hintText: "Password",
                icon: Icon(
                  Icons.lock,
                  color: kPrimaryAccentColor,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              _obscureText?Icons.visibility:Icons.visibility_off,
              color: kPrimaryAccentColor,
            ),
            onPressed: () {
              setState(() {
                _obscureText=!_obscureText;
              });
            },
          ),
        ],
      ),
    );
  }
}
