import 'package:flutter/cupertino.dart';

// ignore: camel_case_types
class Login_Provider extends ChangeNotifier {
  String cnic;
  String password;
  Login_Provider({
    this.cnic,
    this.password,
  });
  void set_cnic(String cnic) {
    this.cnic = cnic;
  }

  void set_password(String pass) {
    this.password = pass;
  }

  String get_cnic() {
    return this.cnic;
  }

  String get_password() {
    return this.password;
  }
}
