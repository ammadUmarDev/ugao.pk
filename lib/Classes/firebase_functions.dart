import 'package:firebase_storage/firebase_storage.dart';
import 'package:ugao/Classes/User_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'Customer_Model.dart';
import 'Farmer_Model.dart';
import 'Product_Model_Upload.dart';
import 'Supplier_Model.dart';

Future<bool> checkUniquenessOfCNIC(String cnic) async {
  Firestore firestore = Firestore.instance;
  var snapshot =
      await firestore.collection('Users').document(cnic).get();
  return snapshot.data==null;
}

Future<bool> checkUniquenessOfPhone(String phone_no) async{
  Firestore firestore = Firestore.instance;
  var snapshot = await firestore.collection('Users').getDocuments();
  if (snapshot.documents.length > 0) {
    for (var document in snapshot.documents) {
      if( document['PhoneNo']==phone_no)return false;
    }
  }
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
    //setState(() {
    return fileUrl;
    //});
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
      return User(
        cnic: snapshot.data["CNIC"].toString(),
        pass: snapshot.data["Password"].toString(),
        fullName: snapshot.data["Full_Name"].toString(),
        usertype: snapshot.data["UserType"].toString(),
        phone_no: snapshot.data['PhoneNo'].toString(),
        farmer: fobj,
      );
    } else if (snapshot.data["UserType"].toString() == "Supplier") {
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
    } else if (snapshot.data["UserType"].toString() == "Customer") {
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
        //'sPhoneNumber': user.supplier.sPhoneNumber.toString(),
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
