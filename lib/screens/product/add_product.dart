import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ugao/components/rounded_image_picker.dart';

import '../../components/rounded_input_field.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  RoundedImagePicker roundedImagePicker = RoundedImagePicker(
    hintText: "Product Image",
  );
  RoundedInputField productName = RoundedInputField(
    hintText: "Product Name",
    icon: Icons.keyboard,
  );
  RoundedInputField productDescription = RoundedInputField(
    //keyboardType: TextInputType.multiline,
    hintText: "Product Description",
    icon: Icons.keyboard,
  );
  RoundedInputField productPrice = RoundedInputField(
    keyboardType: TextInputType.number,
    hintText: "Price",
    icon: Icons.keyboard, //TODO: find appropriate icon
  );
  RoundedInputField productQuantity = RoundedInputField(
    keyboardType: TextInputType.number,
    hintText: "Quantity",
    icon: Icons.keyboard,
  );
  RoundedInputField productWeight = RoundedInputField(
    keyboardType: TextInputType.number,
    //TODO: add option to select weight unit
    hintText: "Weight",
    icon: Icons.keyboard, //TODO: find appropriate icon
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              ListView(
                children: [
                  productName,
                  productDescription,
                  //TODO: add dropdown to select type of price here. options: ["Per Unit Price", "Bulk Price"]
                  productPrice,
                  productQuantity,
                  productWeight,
                  //TODO: add dropdown to select category
                  roundedImagePicker,
                  //TODO: add dropdown to select service type
                  //_image == null ? Container() : Image.file(_image),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
