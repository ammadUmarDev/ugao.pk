import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ugao/Classes/Product_Model_Upload.dart';
import 'package:ugao/Providers/general_provider.dart';
import 'package:ugao/components/appbar.dart';
import 'package:ugao/components/button_loading.dart';
import 'package:ugao/components/rounded_alert_dialog.dart';
import 'package:ugao/components/rounded_button.dart';
import 'package:ugao/components/rounded_drop_down.dart';
import 'package:ugao/components/rounded_image_picker.dart';
import 'package:ugao/constants.dart';

import '../../components/rounded_input_field.dart';
import 'package:ugao/Classes/Firebase_Functions.dart';

import 'my_products_screen.dart';

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
  List<String> pCategories = [
    "Machinery",
    "Tools & Equipment",
    "Pesticide",
    "Fertilizer",
    "Livestock",
    "Dairy",
    "Meat",
    "Crop",
  ]; //TODO: fetch from firebase
  List<String> sTypes = ["Pickup", "Delivery"]; //TODO: fetch from firebase
  List<String> wUnits = [
    "Kgs"
  ]; //TODO: decide weight units (firebase? hard coded?)

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarPageName(pageName: "Add a Product"),
      body: SafeArea(
        child: Container(
          margin: new EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView(
            children: [
              Column(
                children: [
                  RoundedInputField(
                    hintText: "Product Name",
                    icon: Icons.local_florist,
                    onChanged: (newVal) {
                      newVal = newVal.trim();
                      if (newVal.isEmpty) newVal = null;
                      setState(() {
                        product.prodName = newVal;
                      });
                    },
                  ),
                  RoundedInputField(
                    //keyboardType: TextInputType.multiline,
                    //TODO: add support for multiline text input
                    hintText: "Product Description",
                    icon: Icons.calendar_view_day,
                    onChanged: (newVal) {
                      newVal = newVal.trim();
                      if (newVal.isEmpty) newVal = null;
                      setState(() {
                        product.prodDesc = newVal;
                      });
                    },
                  ),
                  RoundedDropDown(
                    name: "Price Type",
                    size: size,
                    text: product.priceType,
                    value: product.priceType,
                    onChanged: (String value) {
                      setState(() {
                        product.priceType = value;
                      });
                    },
                    items: pTypes,
                    icon: Icons.monetization_on,
                  ),
                  RoundedInputField(
                    keyboardType: TextInputType.number,
                    hintText: "Price",
                    icon: Icons.monetization_on, //TODO: find appropriate icon
                    onChanged: (newVal) {
                      newVal = newVal.trim();
                      if (newVal.isEmpty) newVal = null;
                      setState(() {
                        product.price = (newVal == null)
                            ? null
                            : int.parse(
                                newVal //TODO: add onError for robustness
                                );
                      });
                    },
                  ),
                  RoundedInputField(
                    keyboardType: TextInputType.number,
                    hintText: "Quantity",
                    icon: Icons.shopping_cart,
                    onChanged: (newVal) {
                      newVal = newVal.trim();
                      if (newVal.isEmpty) newVal = null;
                      setState(() {
                        product.quantity = (newVal == null)
                            ? null
                            : int.parse(
                                newVal //TODO: add onError for robustness
                                );
                      });
                    },
                  ),
                  RoundedDropDown(
                    name: "Weight Unit",
                    size: size,
                    text: product.weightUnit,
                    value: product.weightUnit,
                    onChanged: (String value) {
                      setState(() {
                        product.weightUnit = value;
                      });
                    },
                    items: wUnits,
                    icon: Icons.call_to_action,
                  ),
                  RoundedInputField(
                    keyboardType: TextInputType.number,
                    //TODO: add option to select weight unit
                    hintText: "Weight",
                    icon: Icons.call_to_action, //TODO: find appropriate icon
                    onChanged: (newVal) {
                      newVal = newVal.trim();
                      if (newVal.isEmpty) newVal = null;
                      setState(() {
                        product.weight = (newVal == null)
                            ? null
                            : int.parse(
                                newVal //TODO: add onError for robustness
                                );
                      });
                    },
                  ),
                  RoundedDropDown(
                    name: "Product Category",
                    size: size,
                    text: product.prodCategory,
                    value: product.prodCategory,
                    onChanged: (String value) {
                      setState(() {
                        product.prodCategory = value;
                      });
                    },
                    items: pCategories,
                    icon: Icons.category,
                  ),
                  RoundedImagePicker(
                    hintText: "Product Image",
                    onPicked: (newImage) {
                      setState(() {
                        if (newImage != null) product.prodImage = newImage;
                      });
                    },
                  ),
                  RoundedDropDown(
                    name: "Service Type",
                    size: size,
                    text: product.serviceType,
                    value: product.serviceType,
                    onChanged: (String value) {
                      setState(() {
                        product.serviceType = value;
                      });
                    },
                    items: sTypes,
                    icon: Icons.departure_board,
                  ),
                  //product.prodImage == null ? Container() : Image.file(product.prodImage),
                  ButtonLoading(
                    labelText: "Add Product",
                    onTap: () async {
                      String nullField = product.get_null_field();
                      print("nullField");
                      print(nullField);
                      if (nullField == null) {
                        bool check = await add_a_product(
                            this.product,
                            Provider.of<General_Provider>(context,
                                    listen: false)
                                .get_user());
                        if (check == true) {
                          this.product.printf();
                          showDialog(
                            context: context,
                            builder: (context) => RoundedAlertDialog(
                              title: "Product added successfully",
                              buttonName: "OK",
                              onButtonPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return MyProductsSeller();
                                    },
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      } else {
                        final String content =
                            ('Please set all fields in order to proceed. ' +
                                    nullField +
                                    ' is not set.')
                                .toString();
                        showDialog(
                          context: context,
                          builder: (context) => RoundedAlertDialog(
                            title: content,
                            buttonName: "OK",
                            onButtonPressed: () {
                              Navigator.pop(context);
                            },
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
