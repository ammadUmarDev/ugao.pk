import 'package:ugao/Classes/User_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

bool checkUniquenessOfCNIC(String cnic) {
  //TODO: fetch CNICs from firebase and verify that the passed arguments are unique
  return true;
}

bool checkUniquenessOfPhone(String phone_no) {
  //TODO: fetch CNICs and PhoneNo from firebase and verify that the passed arguments are unique
  return true;
}

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

Future<bool> signup(User user) async {
  Firestore firestore = Firestore.instance;
  bool internetCheck_ = await internetCheck();
  if (internetCheck_ == false)
    return false;
  else {
    if (user.usertype == 'Farmer') {
      await firestore.collection('Users').document(user.cnic).setData({
        'Full_Name': user.fullName.toString(),
        'CNIC': user.cnic.toString(),
        'Password': user.pass.toString(),
        'PhoneNo': user.phone_no.toString(),
        'UserType': user.usertype.toString(),
        'fExperience': user.farmer.fExperience,
        'fAddress': user.farmer.fAddress,
        'fService': user.farmer.fService,
        'fCategory': user.farmer.fCategory,
        'fCrops': user.farmer.fCrops,
        'fAnimals': user.farmer.fAnimals,
        'fFreshProduce': user.farmer.fFreshProduce,
        'fDairy': user.farmer.fDairy,
      });
      //return true;
    }
    if (user.usertype == "Supplier") {
      await firestore.collection('Users').document(user.cnic).setData({
        'Full_Name': user.fullName.toString(),
        'CNIC': user.cnic.toString(),
        'Password': user.pass.toString(),
        'PhoneNo': user.phone_no.toString(),
        'UserType': user.usertype.toString(),
        'scExperience': user.supplier.scExperience.toString(),
        'sPhoneNumber': user.supplier.sPhoneNumber.toString(),
        'sType': user.supplier.sType.toString(),
        'sSelectedTypes': user.supplier.sSelectedTypes,
        'sAddress': user.supplier.sAddress.toString(),
      });
      //return true;
    }
    if (user.usertype == 'Customer') {
      await firestore.collection('Users').document(user.cnic).setData({
        'Full_Name': user.fullName.toString(),
        'CNIC': user.cnic.toString(),
        'Password': user.pass.toString(),
        'PhoneNo': user.phone_no.toString(),
        'UserType': user.usertype.toString(),
        'cAccountType': user.customer.cAccountType.toString(),
        'cPhoneNumber': user.customer.cPhoneNumber.toString(),
        'ccName': user.customer.ccName.toString(),
        'ccPhoneNumber': user.customer.ccPhoneNumber.toString(),
        'ccWebsite': user.customer.ccWebsite.toString()
      });
      //return true;
    }
  }
  return true;
}
