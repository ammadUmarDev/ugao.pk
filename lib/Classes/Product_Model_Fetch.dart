class ProductFetch {
  String documentID;
  String prodName;
  String prodDesc;
  String priceType;
  int price;
  int quantity;
  int weight;
  String weightUnit;
  String prodCategory;
  String prodImage;
  String serviceType;
  String creator;
  DateTime creationTimestamp;

  ProductFetch({
    this.documentID,
    this.creationTimestamp,
    this.prodName,
    this.prodDesc,
    this.priceType,
    this.price,
    this.quantity,
    this.weight,
    this.weightUnit,
    this.prodCategory,
    this.prodImage,
    this.serviceType,
    this.creator,
  }) {}

  void set_product(ProductFetch pobject) {
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
    if (pobject.creator != null) {
      this.creator = pobject.creator;
    }
  }
}
