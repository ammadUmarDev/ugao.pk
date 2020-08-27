import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ugao/components/text_field_container.dart';

//TODO: add support to select multiple images

class RoundedImagePicker extends StatefulWidget {
  final String hintText;
  final ValueChanged<File> onPicked;
  RoundedImagePicker({this.hintText="Pick an Image",this.onPicked});
  @override
  _RoundedImagePickerState createState() => _RoundedImagePickerState();
}

class _RoundedImagePickerState extends State<RoundedImagePicker> {
  //File image;
  final picker = ImagePicker();
  ImageSource src = ImageSource.gallery;

  /*RoundedImagePicker({
    Key key,
    text,
    color = kPrimaryColor,
    textColor = Colors.white,
  }) : super(
    key: key,
    text: text,
    press: () async {
      print("Select product image function");
    },
    color: color,
    textColor: textColor,
  );*/

  Future getImage() async {
    final pickedFile = await picker.getImage(source: this.src);

    setState(() {
      widget.onPicked(File(pickedFile.path));
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: FlatButton(
        onPressed: getImage,
        child: Text(
          widget.hintText//==null?"Pick an Image":widget.hintText,
          //style: TextStyle(color: textColor, fontSize: h1Size),
        ),
      ),
      //child: Icon(Icons.add_a_photo),
    );
  }
}
