import 'package:firebase_storage/firebase_storage.dart';
import 'package:ugao/Classes/User_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import '../constants.dart';
import 'Customer_Model.dart';
import 'Farmer_Model.dart';
import 'Product_Model_Upload.dart';
import 'Supplier_Model.dart';

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

//Change UserType
Future<bool> update_User_Type(User user, var obj) async {
  var firestore = Firestore.instance;
  if (obj is Farmer) {
    print("It is a farmer");
    await firestore.collection('Users').document(user.cnic).delete();
    await firestore.collection('Users').document(user.cnic).setData({
      'Full_Name': user.fullName.toString(),
      'CNIC': user.cnic.toString(),
      'Password': user.pass.toString(),
      'PhoneNo': user.phone_no.toString(),
      'UserType': FARMER,
      'fExperience': obj.fExperience,
      'fAddress': obj.fAddress,
      'fService': obj.fService,
      'fCategory': obj.fCategory,
      'fCrops': obj.fCrops,
      'fAnimals': obj.fAnimals,
      'fFreshProduce': obj.fFreshProduce,
      'fDairy': obj.fDairy,
    });
    return true;
  }
  if (obj is Supplier) {
    print("It is a supplier");
    await firestore.collection('Users').document(user.cnic).delete();
    await firestore.collection('Users').document(user.cnic).setData({
      'Full_Name': user.fullName.toString(),
      'CNIC': user.cnic.toString(),
      'Password': user.pass.toString(),
      'PhoneNo': user.phone_no.toString(),
      'UserType': SUPPLIER,
      'scExperience': obj.scExperience.toString(),
      'sPhoneNumber': obj.sPhoneNumber.toString(),
      'sType': obj.sType.toString(),
      'sSelectedTypes': obj.sSelectedTypes,
      'sAddress': obj.sAddress.toString(),
    });
    return true;
  }
  if (obj is Customer) {
    print("It is a customer");
    await firestore.collection('Users').document(user.cnic).delete();
    await firestore.collection('Users').document(user.cnic).setData({
      'Full_Name': user.fullName.toString(),
      'CNIC': user.cnic.toString(),
      'Password': user.pass.toString(),
      'PhoneNo': user.phone_no.toString(),
      'UserType': CUSTOMER,
      'cAccountType': obj.cAccountType.toString(),
      'cPhoneNumber': obj.ccPhoneNumber.toString(),
      'ccName': obj.ccName.toString(),
      'ccPhoneNumber': obj.ccPhoneNumber.toString(),
      'ccWebsite': obj.ccWebsite.toString()
    });
    return true;
  }
}

//PhoneNo Change
Future<bool> change_Phone_No(User u, String new_Phone_No) async {
  var fire = Firestore.instance;
  var snapshot = fire.collection('Users').document(u.cnic);
  if (snapshot != null) {
    await snapshot.updateData({"PhoneNo": new_Phone_No.toString()});
    return true;
  } else {
    return false;
  }
}

//Password Change
Future<bool> changePassword(
    User u, String new_Pass, String entered_pass) async {
  if (u.pass == entered_pass) {
    // ignore: await_only_futures
    print("Entered");
    var fire = Firestore.instance;
    await fire.collection("Users").document(u.cnic).updateData({
      "Password": new_Pass.toString(),
    });
    return true;
  } else {
    return false;
  }
}

//User Name Change
Future<bool> change_User_Name(User u, String new_name) async {
  var fire = Firestore.instance;
  await fire
      .collection("Users")
      .document(u.cnic)
      .updateData({"Full_Name": new_name});
  return true;
}

Future<String> upload_file(File file /*, BuildContext context*/) async {
  //Path p = new Path();
  if (file == null) {
    print("File being uploaded in null");
  }
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  StorageReference storageReference = firebaseStorage.ref().child(file.path);
  StorageUploadTask uploadTask = storageReference.putFile(file);
  await uploadTask.onComplete;
  print('File Uploaded');
  String fileURL = await storageReference.getDownloadURL().then((fileUrl) {
    return fileUrl;
  });
  return fileURL;
}

Future<bool> add_a_product(Product product, User currentUser) async {
  Firestore firestore = Firestore.instance;
  String imageURL;
  if (product.prodImage != null)
    imageURL = await upload_file(product.prodImage);
  else {
    imageURL = null;
    print("image url is null");
  }
  print(imageURL);
  await firestore
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

/*retrieves firebase User document*/
Future<User> getUser(String entered_cnic) async {
  Firestore firestore = Firestore.instance;
  print("in login_up " + entered_cnic.toString());
  var snapshot =
      await firestore.collection('Users').document(entered_cnic).get();
  if (snapshot.data != null) {
    if (snapshot.data["UserType"].toString() == FARMER) {
      Farmer fobj = new Farmer();
      fobj.fAddress = snapshot.data["fAddress"].toString();
      fobj.fAnimals = snapshot.data["fAnimals"].toString();
      fobj.fCategory = snapshot.data["fCategory"].toString();
      fobj.fCrops = snapshot.data["fCrops"].toString();
      fobj.fDairy = snapshot.data["fDairy"].toString();
      fobj.fExperience = snapshot.data["fExperience"].toString();
      fobj.fFreshProduce = snapshot.data["fFreshProduce"].toString();
      fobj.fService = snapshot.data["fService"].toString();
      return User(
        cnic: snapshot.data["CNIC"].toString(),
        pass: snapshot.data["Password"].toString(),
        fullName: snapshot.data["Full_Name"].toString(),
        usertype: snapshot.data["UserType"].toString(),
        phone_no: snapshot.data['PhoneNo'].toString(),
        farmer: fobj,
      );
    } else if (snapshot.data["UserType"].toString() == SUPPLIER) {
      Supplier sobj = new Supplier();
      sobj.sAddress = snapshot.data["sAddress"].toString();
      //sobj.sPhoneNumber = snapshot.data["sPhoneNumber"].toString();
      for (int i = 0; i < snapshot.data["sSelectedTypes"].length; i++) {
        sobj.sSelectedTypes.add(snapshot.data["sSelectedTypes"][i]);
      }
      sobj.scExperience = snapshot.data["scExperience"].toString();
      return User(
        cnic: snapshot.data["CNIC"].toString(),
        pass: snapshot.data["Password"].toString(),
        fullName: snapshot.data["Full_Name"].toString(),
        usertype: snapshot.data["UserType"].toString(),
        phone_no: snapshot.data['PhoneNo'].toString(),
        supplier: sobj,
      );
    } else if (snapshot.data["UserType"].toString() == CUSTOMER) {
      Customer cobj = new Customer();
      cobj.cAccountType = snapshot.data["cAccountType"].toString();
      //cobj.cPhoneNumber = snapshot.data["cPhoneNumber"].toString();
      cobj.ccName = snapshot.data["ccName"].toString();
      cobj.ccPhoneNumber = snapshot.data["ccPhoneNumber"].toString();
      cobj.ccWebsite = snapshot.data["ccWebsite"].toString();
      return User(
        cnic: snapshot.data["CNIC"].toString(),
        pass: snapshot.data["Password"].toString(),
        fullName: snapshot.data["Full_Name"].toString(),
        usertype: snapshot.data["UserType"].toString(),
        phone_no: snapshot.data['PhoneNo'].toString(),
        customer: cobj,
      );
    }
    return null;
  }
  return null;
}

Future<bool> signup(User user) async {
  Firestore firestore = Firestore.instance;
  bool internetCheck_ = await internetCheck();
  if (internetCheck_ == false)
    return false;
  else {
    if (user.usertype == FARMER) {
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
    if (user.usertype == SUPPLIER) {
      await firestore.collection('Users').document(user.cnic).setData({
        'Full_Name': user.fullName.toString(),
        'CNIC': user.cnic.toString(),
        'Password': user.pass.toString(),
        'PhoneNo': user.phone_no.toString(),
        'UserType': user.usertype.toString(),
        'scExperience': user.supplier.scExperience.toString(),
        //'sPhoneNumber': user.supplier.sPhoneNumber.toString(),
        'sType': user.supplier.sType.toString(),
        'sSelectedTypes': user.supplier.sSelectedTypes,
        'sAddress': user.supplier.sAddress.toString(),
      });
      //return true;
    }
    if (user.usertype == CUSTOMER) {
      await firestore.collection('Users').document(user.cnic).setData({
        'Full_Name': user.fullName.toString(),
        'CNIC': user.cnic.toString(),
        'Password': user.pass.toString(),
        'PhoneNo': user.phone_no.toString(),
        'UserType': user.usertype.toString(),
        'cAccountType': user.customer.cAccountType.toString(),
        //'cPhoneNumber': user.customer.cPhoneNumber.toString(),
        'ccName': user.customer.ccName.toString(),
        'ccPhoneNumber': user.customer.ccPhoneNumber.toString(),
        'ccWebsite': user.customer.ccWebsite.toString()
      });
      //return true;
    }
  }
  return true;
}
