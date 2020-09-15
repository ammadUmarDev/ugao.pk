import 'package:flutter/cupertino.dart';
import 'package:ugao/Classes/User_Model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

// ignore: camel_case_types
class General_Provider extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  User user;
  FirebaseUser firebaseUser;

  User get_user() {
    if (user == null) {
      print("User has not been set yet");
    }
    return user;
  }

  void set_user(User u) {
    this.user = u;
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    this.user.pass = String.fromCharCodes(Iterable.generate(
        5, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }   

  FirebaseUser get_firebase_user() {
    if (firebaseUser == null) {
      print("Firebase user has not been set yet");
    }
    return firebaseUser;
  }

  void set_firebase_user(FirebaseUser u) {
    this.firebaseUser = u;
  }
}
