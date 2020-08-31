import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:ugao/Classes/Customer_Model.dart';
import 'package:ugao/Classes/Farmer_Model.dart';
import 'package:ugao/Classes/Firebase_Model.dart';
import 'package:ugao/Classes/Supplier_Model.dart';
import 'package:ugao/Classes/User_Model.dart';
import 'package:ugao/components/Login_Credentials.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

// ignore: camel_case_types
class General_Provider extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  Firebase firebase_object = new Firebase(); //For Firebase Function
  User user = new User(); //Consists of user information
  FirebaseAuth firebaseAuth;
  Firestore firestore;
  FirebaseStorage firebaseStorage;
  FirebaseUser firebaseUser;

  User get_user()
  {
    return user;
  }

  void set_user(User u)
  {
    this.user=u;
  }

  General_Provider({
    // ignore: non_constant_identifier_names
    firebase_object,
    user,
  });
  //For User Updation
  // ignore: non_constant_identifier_names
  void user_update(String name, String cnic, String user_Type, String phone_no, Farmer fobj,
      Customer cobj, Supplier sobj) {
    this.user = new User();
    this.user.farmer = new Farmer();
    this.user.supplier = new Supplier();
    this.user.customer = new Customer();
    this.user.fullName = name;
    this.user.cnic = cnic;
    this.user.phone_no=phone_no;
    this.user.usertype = user_Type;
    if (fobj != null) {
      this.user.farmer.set_farmer(fobj);
    }
    if (cobj != null) {
      this.user.customer.set_customer(cobj);
    }
    if (sobj != null) {
      this.user.supplier.set_Supplier(sobj);
      //this.user.supplier.prints();
    }
  }

  //For Internet Check
  Future<bool> internetCheck() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      return false;
    }
    return true;
  }

  //For Sign+Up
  Future<bool> sign_Up(String cnic, String fullname, String pass,
      String usertype, String phone_no, Farmer fobj, Supplier sobj, Customer cobj, BuildContext context) async {
    var check = await this
        .firebase_object
        .sign_up(cnic, fullname, pass, phone_no, usertype, fobj, sobj, cobj, context);
    if (check == true) {
      print("SignUp Successfull");
      return true;
    } else {
      return false;
    }
  }

  //For Login
  Future<bool> login(Login_Credentials lobj, BuildContext context) async {
    this.firebase_object = new Firebase();
    bool check =
        await this.firebase_object.login_up(lobj.cnic, lobj.password, context);
    if (check == true) {
      this.user.print_user();
      return true;
    }
    return false;
  }
}
