import 'dart:io';

class Product {
  String prodName;
  String prodDesc;
  String priceType;
  int price;
  int quantity;
  int weight;
  String weightUnit;
  String prodCategory;
  File prodImage;
  String serviceType;

  Product(
      {this.prodName,
      this.prodDesc,
      this.priceType,
      this.price,
      this.quantity,
      this.weight,
      this.weightUnit,
      this.prodCategory,
      this.prodImage,
      this.serviceType});

  void set_farmer(Product pobject) {
    if (pobject.prodName != null) {
      this.prodName = pobject.prodName;
    }
    if (pobject.prodDesc != null) {
      this.prodDesc = pobject.prodDesc;
    }
    if (pobject.priceType != null) {
      this.priceType = pobject.priceType;
    }
    if (pobject.price != null) {
      this.price = pobject.price;
    }
    if (pobject.quantity != null) {
      this.quantity = pobject.quantity;
    }
    if (pobject.weight != null) {
      this.weight = pobject.weight;
    }
    if (pobject.weightUnit != null) {
      this.weightUnit = pobject.weightUnit;
    }
    if (pobject.prodCategory != null) {
      this.prodCategory = pobject.prodCategory;
    }
    if (pobject.prodImage != null) {
      this.prodImage = pobject.prodImage;
    }
    if (pobject.prodCategory != null) {
      this.serviceType = pobject.serviceType;
    }
  }

  // ignore: non_constant_identifier_names
  String get_null_field() {
    if (this.prodName == null) {
      return ("Product Name");
    }
    if (this.prodDesc == null) {
      return ("Product Description");
    }
    if (this.priceType == null) {
      return ("Price Type");
    }
    if (this.price == null) {
      return ("Price");
    }
    if (this.quantity == null) {
      return ("Quantity");
    }
    if (this.weight == null) {
      return ("Weight");
    }
    if (this.weightUnit == null) {
      return ("Weight Unit");
    }
    if (this.prodCategory == null) {
      return ("Product Category");
    }
    if (this.prodImage == null) {
      return ("Product Image");
    }
    if (this.serviceType == null) {
      return ("Service Type");
    }
    return null;
  }

  void printf() {
    print(this.prodName);
    print(this.prodDesc);
    print(this.priceType);
    print(this.price);
    print(this.quantity);
    print(this.weight);
    print(this.weightUnit);
    print(this.prodCategory);
    print(this.prodImage);
    print(this.serviceType);
  }
}
