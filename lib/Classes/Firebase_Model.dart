import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ugao/Classes/User_Model.dart';
import 'package:ugao/Providers/general_provider.dart';
import 'package:ugao/screens/dashboard/dashboard.dart';

import 'Customer_Model.dart';
import 'Farmer_Model.dart';
import 'Product_Model.dart';
import 'Supplier_Model.dart';

class Firebase {
  FirebaseAuth firebaseAuth;
  Firestore firestore;
  FirebaseStorage firebaseStorage;
  FirebaseUser user;

  firebase() {
    this.firebaseAuth = FirebaseAuth.instance;
    this.firestore = Firestore.instance;
    this.firebaseStorage = FirebaseStorage.instance;
  }

  FirebaseAuth get_Firebase_Auth() {
    return this.firebaseAuth;
  }

  Firestore get_Firestore() {
    return this.firestore;
  }

  FirebaseStorage get_Fire_Storage() {
    return this.firebaseStorage;
  }

  Future<bool> sign_up(
      String cnic,
      String fullname,
      String pass,
      String phone_no,
      String usertype,
      Farmer fobj,
      Supplier sobj,
      Customer cobj,
      BuildContext context) async {
    //TODO: reorder this such that phone no and cnic get verified on first page
    if (this.firestore == null) this.firestore = Firestore.instance;
    FirebaseUser user;
    if (verify_phone_no(phone_no, context) == true) {
      print("verify phone is true");
      print(usertype);
      print(fullname);
      print(cnic);
      print(phone_no);
      if (usertype == "Farmer") {
        fobj.printf();
      }
      if (usertype == "Customer") {
        cobj.printc();
      }
      if (usertype == "Supplier") {
        sobj.prints();
      }
      if (usertype == 'Farmer') {
        await this.firestore.collection('Users').document(cnic).setData({
          'Full_Name': fullname.toString(),
          'CNIC': cnic.toString(),
          'Password': pass.toString(),
          'PhoneNo': phone_no.toString(),
          'UserType': usertype.toString(),
          'fExperience': fobj.fExperience,
          'fAddress': fobj.fAddress,
          'fService': fobj.fService,
          'fCategory': fobj.fCategory,
          'fCrops': fobj.fCrops,
          'fAnimals': fobj.fAnimals,
          'fFreshProduce': fobj.fFreshProduce,
          'fDairy': fobj.fDairy,
        });
        //return true;
      }
      if (usertype == "Supplier") {
        await this.firestore.collection('Users').document(cnic).setData({
          'Full_Name': fullname.toString(),
          'CNIC': cnic.toString(),
          'Password': pass.toString(),
          'UserType': usertype.toString(),
          'PhoneNo': phone_no.toString(),
          'scExperience': sobj.scExperience.toString(),
          'sPhoneNumber': sobj.sPhoneNumber.toString(),
          'sType': sobj.sType.toString(),
          'sSelectedTypes': sobj.sSelectedTypes,
          'sAddress': sobj.sAddress.toString(),
        });
        //return true;
      }
      if (usertype == 'Customer') {
        await this.firestore.collection('Users').document(cnic).setData({
          'Full_Name': fullname.toString(),
          'CNIC': cnic.toString(),
          'Password': pass.toString(),
          'UserType': usertype.toString(),
          'PhoneNo': phone_no.toString(),
          'cAccountType': cobj.cAccountType.toString(),
          'cPhoneNumber': cobj.cPhoneNumber.toString(),
          'ccName': cobj.ccName.toString(),
          'ccPhoneNumber': cobj.ccPhoneNumber.toString(),
          'ccWebsite': cobj.ccWebsite.toString()
        });
        //return true;
      }
      return true;
    } else {
      print("result is false");
      return false;
    }
  }

  bool verify_phone_no(String phone_no, BuildContext context) {
    if (this.firebaseAuth == null) this.firebaseAuth = FirebaseAuth.instance;
    Future<bool> rn;
    print("create bool in verify_phone_no");
    firebaseAuth.verifyPhoneNumber(
      phoneNumber: phone_no,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential a) {
        print("verification completed");
      },
      verificationFailed: (AuthException a) {
        print("verification failed " + a.code.toString());
      },
      codeSent: (String verificationID, [int b]) async {
        print("code sent");

        String code;

        print("before calling showDialog");

        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text("Give the code?"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      onChanged: (enteredCode) {
                        code = enteredCode;
                      },
                      // controller: _codeController,
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Confirm"),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () async {
                      print("called onPressed of Flat Button");
                      code = code.trim();
                      AuthCredential credential =
                          PhoneAuthProvider.getCredential(
                              verificationId: verificationID, smsCode: code);

                      print("before async call in onPressed of Flat Button");

                      AuthResult result =
                          await firebaseAuth.signInWithCredential(credential);

                      print("after async call in onPressed of Flat Button");

                      user=result.user;
                      rn=(result.user!=null) as Future<bool>;

                      print(rn.toString()+" value of rn after async call");

                      /*if (result.user != null) {
                        print("Verification successful");
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DashBoard();
                            },
                          ),
                        );
                      }*/

                      print("finished onPressed of Flat Button");

                      //return result.user != null;
                    },
                  )
                ],
              );

            });
      },
      codeAutoRetrievalTimeout: (String a) {
        print("auto retrieval timeout");
      },
    );
    //print("return bool in verify_phone_no "+rn.toString());
    //return rn;
  }

  Future<String> upload_file(File file /*, BuildContext context*/) async {
    //Path p = new Path();
    if (file == null) {
      print("File being uploaded in null");
    }
    if (this.firebaseStorage == null)
      this.firebaseStorage = FirebaseStorage.instance;
    StorageReference storageReference = firebaseStorage.ref().child(file.path);
    StorageUploadTask uploadTask = storageReference.putFile(file);
    await uploadTask.onComplete;
    print('File Uploaded');
    String fileURL = await storageReference.getDownloadURL().then((fileUrl) {
      //setState(() {
      return fileUrl;
      //});
    });
    return fileURL;
  }

  Future<bool> add_a_product(Product product, BuildContext context) async {
    User currentUser =
        Provider.of<General_Provider>(context, listen: false).get_user();
    if (this.firestore == null) this.firestore = Firestore.instance;
    String imageURL;
    if (product.prodImage != null)
      imageURL = await upload_file(product.prodImage);
    else {
      imageURL = null;
      print("image url is null");
    }
    print(imageURL);
    await this
        .firestore
        .collection('Products')
        .document(currentUser.cnic.toString() +
            DateTime.now().millisecondsSinceEpoch.toString())
        .setData({
      'Name': product.prodName.toString(),
      'Desc': product.prodDesc.toString(),
      'Price_Type': product.priceType.toString(),
      'Price': product.price,
      'Quantity': product.quantity,
      'Weight': product.weight,
      'WeightUnit': product.weightUnit,
      'Prod_Category': product.prodCategory,
      'Prod_Image': [imageURL],
      'Service_Type': product.serviceType,
      'Creator': currentUser.cnic,
      'Created_Timestamp': DateTime.now(),
    });
    return true;
  }

  //Login Function
  // ignore: non_constant_identifier_names
  Future<bool> login_up(
      String entered_cnic, String pass, BuildContext context) async {
    if (this.firestore == null) firestore = Firestore.instance;
    String name;
    String cnicc;
    String user_Type;
    String phone_no;
    print("in login_up " + entered_cnic.toString());
    var snapshot =
        await firestore.collection('Users').document(entered_cnic).get();
    if (snapshot.data != null) {
      if (snapshot.data["Password"].toString() != pass) {
        print("Wrong password\n");
        return false;
      } else {
        if (snapshot.data["UserType"].toString() == "Farmer") {
          Farmer fobj = new Farmer();
          fobj.fAddress = snapshot.data["fAddress"].toString();
          fobj.fAnimals = snapshot.data["fAnimals"].toString();
          fobj.fCategory = snapshot.data["fCategory"].toString();
          fobj.fCrops = snapshot.data["fCrops"].toString();
          fobj.fDairy = snapshot.data["fDairy"].toString();
          fobj.fExperience = snapshot.data["fExperience"].toString();
          fobj.fFreshProduce = snapshot.data["fFreshProduce"].toString();
          fobj.fService = snapshot.data["fService"].toString();
          name = snapshot.data["Full_Name"].toString();
          user_Type = snapshot.data["UserType"].toString();
          phone_no = snapshot.data['PhoneNo'].toString();
          cnicc = snapshot.data["CNIC"].toString();
          Provider.of<General_Provider>(context, listen: false)
              .user_update(name, cnicc, user_Type, phone_no, fobj, null, null);
          //return true;
        } else if (snapshot.data["UserType"].toString() == "Supplier") {
          Supplier sobj = new Supplier();
          sobj.sAddress = snapshot.data["sAddress"].toString();
          sobj.sPhoneNumber = snapshot.data["sPhoneNumber"].toString();
          for (int i = 0; i < snapshot.data["sSelectedTypes"].length; i++) {
            sobj.sSelectedTypes.add(snapshot.data["sSelectedTypes"][i]);
          }
          sobj.scExperience = snapshot.data["scExperience"].toString();
          phone_no = snapshot.data['PhoneNo'].toString();
          name = snapshot.data["Full_Name"].toString();
          user_Type = snapshot.data["UserType"].toString();
          cnicc = snapshot.data["CNIC"].toString();
          Provider.of<General_Provider>(context, listen: false)
              .user_update(name, cnicc, user_Type, phone_no, null, null, sobj);
          //return true;
        } else if (snapshot.data["UserType"].toString() == "Customer") {
          Customer cobj = new Customer();
          cobj.cAccountType = snapshot.data["cAccountType"].toString();
          cobj.cPhoneNumber = snapshot.data["cPhoneNumber"].toString();
          cobj.ccName = snapshot.data["ccName"].toString();
          cobj.ccPhoneNumber = snapshot.data["ccPhoneNumber"].toString();
          cobj.ccWebsite = snapshot.data["ccWebsite"].toString();
          name = snapshot.data["Full_Name"].toString();
          user_Type = snapshot.data["UserType"].toString();
          phone_no = snapshot.data['PhoneNo'].toString();
          cnicc = snapshot.data["CNIC"].toString();
          Provider.of<General_Provider>(context, listen: false)
              .user_update(name, cnicc, user_Type, phone_no, null, cobj, null);
          //return true;
        }
        return await verify_phone_no(phone_no, context);
      }
    } else {
      print("Not Entered\n");
    }
    return false;
  }
}
