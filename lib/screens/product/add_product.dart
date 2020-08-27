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
    //TODO: add support for multiline text input
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
  List<String>pTypes=["Per Unit Price","Bulk Price"]; //TODO: fetch from firebase
  String priceType;
  List<String> pCategories=["Fertilizer"]; //TODO: fetch from firebase
  String productCategory;
  List<String> sTypes=["Pickup","Delivery"]; //TODO: fetch from firebase
  String serviceType;

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
                  DropdownButton<String>(
                    isExpanded: true,
                    isDense: false,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    hint: Text(
                      priceType==null?"Price Type":priceType,
                      style: TextStyle(fontSize: 15.5),
                    ),
                    //value: priceType==null?"Price Type":priceType,
                    onChanged: (String value) {
                      setState(() {
                        priceType = value;
                      });
                    },
                    items: pTypes.map((String user) {
                      return DropdownMenuItem<String>(
                        value: user,
                        child: Row(
                          children: <Widget>[
                            Text(
                              user,
                              style: TextStyle(
                                fontSize: 15.5,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  productPrice,
                  productQuantity,
                  productWeight,
                  DropdownButton<String>(
                    isExpanded: true,
                    isDense: false,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    hint: Text(
                      productCategory==null?"Product Category":productCategory,
                      style: TextStyle(fontSize: 15.5),
                    ),
                    //value: priceType==null?"Price Type":priceType,
                    onChanged: (String value) {
                      setState(() {
                        productCategory = value;
                      });
                    },
                    items: pCategories.map((String user) {
                      return DropdownMenuItem<String>(
                        value: user,
                        child: Row(
                          children: <Widget>[
                            Text(
                              user,
                              style: TextStyle(
                                fontSize: 15.5,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  roundedImagePicker,
                  DropdownButton<String>(
                    isExpanded: true,
                    isDense: false,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    hint: Text(
                      serviceType==null?"Service Type":serviceType,
                      style: TextStyle(fontSize: 15.5),
                    ),
                    //value: priceType==null?"Price Type":priceType,
                    onChanged: (String value) {
                      setState(() {
                        serviceType = value;
                      });
                    },
                    items: sTypes.map((String user) {
                      return DropdownMenuItem<String>(
                        value: user,
                        child: Row(
                          children: <Widget>[
                            Text(
                              user,
                              style: TextStyle(
                                fontSize: 15.5,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
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
