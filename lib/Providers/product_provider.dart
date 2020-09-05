import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ugao/Classes/Product_Model_Fetch.dart';

// ignore: camel_case_types
class Product_Provider extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  final productsRef = Firestore.instance.collection("Products");
  final usersRef = Firestore.instance.collection("Users");

  get_productsRef() {
    if (productsRef == null) {
      print("productsRef has not been set yet");
    }
    return productsRef;
  }

  getCreatorName(String cnic) async {
    if (productsRef == null && usersRef == null) {
      print("productsRef and usersRef has not been set yet");
    }
    final DocumentSnapshot creatorUser = await usersRef.document(cnic).get();
    return creatorUser;
  }

  from_firebase_document_to_fetch_object(DocumentSnapshot firebaseDocument) {
    return ProductFetch(
      prodName: firebaseDocument.data['Name'],
      prodDesc: firebaseDocument.data['Desc'],
      priceType: firebaseDocument.data['Price_Type'],
      price: firebaseDocument.data['Price'],
      quantity: firebaseDocument.data['Quantity'],
      weight: firebaseDocument.data['Weight'],
      weightUnit: firebaseDocument.data['WeightUnit'],
      prodCategory: firebaseDocument.data['Prod_Category'],
      prodImage: firebaseDocument.data['Prod_Image'][0],
      serviceType: firebaseDocument.data['Service_Type'],
      creator: firebaseDocument.data['Creator'],
    );
  }
}
