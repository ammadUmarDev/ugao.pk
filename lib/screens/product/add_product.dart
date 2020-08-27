import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ugao/Classes/Firebase_Model.dart';
import 'package:ugao/Classes/Product_Model.dart';
import 'package:ugao/components/rounded_alert_dialog.dart';
import 'package:ugao/components/rounded_button.dart';
import 'package:ugao/components/rounded_image_picker.dart';

import '../../components/rounded_input_field.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  Product product = new Product();
  List<String> pTypes = [
    "Per Unit Price",
    "Bulk Price"
  ]; //TODO: fetch from firebase
  List<String> pCategories = ["Fertilizer"]; //TODO: fetch from firebase
  List<String> sTypes = ["Pickup", "Delivery"]; //TODO: fetch from firebase
  List<String> wUnits=["Kgs"]; //TODO: decide weight units (firebase? hard coded?)

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
                    onChanged: (newVal) {
                      setState(() {
                        if (newVal != null) product.prodName = newVal;
                      });
                    },
                  ),
                  RoundedInputField(
                    //keyboardType: TextInputType.multiline,
                    //TODO: add support for multiline text input
                    hintText: "Product Description",
                    icon: Icons.keyboard,
                    onChanged: (newVal) {
                      setState(() {
                        if (newVal != null) product.prodDesc = newVal;
                      });
                    },
                  ),
                  DropdownButton<String>(
                    isExpanded: true,
                    isDense: false,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    hint: Text(
                      product.priceType == null
                          ? "Price Type"
                          : product.priceType,
                      style: TextStyle(fontSize: 15.5),
                    ),
                    //value: priceType==null?"Price Type":priceType,
                    onChanged: (String value) {
                      setState(() {
                        product.priceType = value;
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
                  RoundedInputField(
                    keyboardType: TextInputType.number,
                    hintText: "Price",
                    icon: Icons.keyboard, //TODO: find appropriate icon
                    onChanged: (newVal) {
                      setState(() {
                        if (newVal != null)
                          product.price = int.parse(
                              newVal //TODO: add onError for robustness
                              );
                      });
                    },
                  ),
                  RoundedInputField(
                    keyboardType: TextInputType.number,
                    hintText: "Quantity",
                    icon: Icons.keyboard,
                    onChanged: (newVal) {
                      setState(() {
                        if (newVal != null)
                          product.quantity = int.parse(
                              newVal //TODO: add onError for robustness
                              );
                      });
                    },
                  ),
                  DropdownButton<String>(
                    isExpanded: true,
                    isDense: false,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    hint: Text(
                      product.weightUnit == null
                          ? "Weight Unit"
                          : product.weightUnit,
                      style: TextStyle(fontSize: 15.5),
                    ),
                    //value: priceType==null?"Price Type":priceType,
                    onChanged: (String value) {
                      setState(() {
                        product.weightUnit = value;
                      });
                    },
                    items: wUnits.map((String user) {
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
                  RoundedInputField(
                    keyboardType: TextInputType.number,
                    //TODO: add option to select weight unit
                    hintText: "Weight",
                    icon: Icons.keyboard, //TODO: find appropriate icon
                    onChanged: (newVal) {
                      setState(() {
                        if (newVal != null)
                          product.weight = int.parse(
                              newVal //TODO: add onError for robustness
                              );
                      });
                    },
                  ),
                  DropdownButton<String>(
                    isExpanded: true,
                    isDense: false,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    hint: Text(
                      product.prodCategory == null
                          ? "Product Category"
                          : product.prodCategory,
                      style: TextStyle(fontSize: 15.5),
                    ),
                    //value: priceType==null?"Price Type":priceType,
                    onChanged: (String value) {
                      setState(() {
                        product.prodCategory = value;
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
                  RoundedImagePicker(
                    hintText: "Product Image",
                    onPicked: (newImage) {
                      setState(() {
                        if (newImage != null) product.prodImage = newImage;
                      });
                    },
                  ),
                  DropdownButton<String>(
                    isExpanded: true,
                    isDense: false,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    hint: Text(
                      product.serviceType == null
                          ? "Service Type"
                          : product.serviceType,
                      style: TextStyle(fontSize: 15.5),
                    ),
                    //value: priceType==null?"Price Type":priceType,
                    onChanged: (String value) {
                      setState(() {
                        product.serviceType = value;
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
                  //product.prodImage == null ? Container() : Image.file(product.prodImage),
                  RoundedButton(
                    text: "Add Product",
                    press: () async {
                      var firebase_object = new Firebase();
                      String nullField=product.get_null_field();
                      print("nullField");
                      print(nullField);
                      if (nullField==null) {
                        bool check = await firebase_object.add_a_product(
                            this.product, context);
                        if (check == true) {
                          this.product.printf();
                          return true;
                        }
                      }else{
                        final String content=('Please set all fields in order to proceed. '+nullField+' is not set.').toString();
                        showDialog(
                          context: context,
                          builder: (context) => RoundedAlertDialog(
                            content: content,
                          ),
                        );
                        return false; //TODO: add warning message that a field has not been set
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
