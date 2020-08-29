import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RoundedDropDown extends StatelessWidget {
  const RoundedDropDown({
    Key key,
    this.name,
    this.size,
    this.text,
    this.value,
    this.onChanged,
    this.items,
    this.icon,
  }) : super(key: key);
  final String name;
  final Size size;
  final String text;
  final String value;
  final Function onChanged;
  final List<String> items;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.6,
      decoration: new BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: Column(
        children: <Widget>[
          DropdownButton<String>(
            icon: Icon(
              icon,
              color: kPrimaryAccentColor,
            ),
            isExpanded: true,
            isDense: false,
            style: TextStyle(
              color: Colors.black,
            ),
            hint: Text(
              text == null ? name : text,
              style: TextStyle(fontSize: 15.5),
            ),
            value: text,
            onChanged: onChanged,
            items: items.map((String user) {
              return DropdownMenuItem<String>(
                value: user,
                child: Row(
                  children: <Widget>[
                    Text(
                      user,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
