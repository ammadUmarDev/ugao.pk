import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/drop_down_field.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_input_field.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              ListView(
                children: [
                  RoundedInputField(
                    hintText: "Product Name",
                    icon: Icons.keyboard,
                  ),
                  RoundedInputField(
                    hintText: "Product Description",
                    icon: Icons.keyboard,
                  ),
                  //TODO: add dropdown to select type of price here. options: ["Per Unit Price", "Bulk Price"]
                  RoundedInputField(
                    //TODO: limit to integer only input
                    hintText: "Price",
                    icon: Icons.keyboard, //TODO: find appropriate icon
                  ),
                  RoundedInputField(
                    //TODO: limit to integer only input
                    hintText: "Quantity",
                    icon: Icons.keyboard,
                  ),
                  RoundedInputField(
                    //TODO: limit to integer only input
                    //TODO: add option to select weight unit
                    hintText: "Weight",
                    icon: Icons.keyboard, //TODO: find appropriate icon
                  ),
                  //TODO: add dropdown to select category
                  //TODO: create image picker for product image
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
