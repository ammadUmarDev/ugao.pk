class Supplier {
  String scExperience;
  //String sPhoneNumber;
  String sAddress;
  String sType;
  List<String> sSelectedTypes=new List();

  Supplier({
    scExperience,
    sPhoneNumber,
    sAddress,
    sType,
    sSelectedTypes,
  });
  void set_Supplier(Supplier sobject) {
    this.scExperience = sobject.scExperience;
    //this.sPhoneNumber = sobject.sPhoneNumber;
    this.sAddress = sobject.sAddress;
    this.sType = sobject.sType;
    this.sSelectedTypes = sobject.sSelectedTypes;
  }

  void prints() {
    print(this.scExperience);
    //print(this.sPhoneNumber);
    print(this.sAddress);
    print(this.sType);
    print(this.sSelectedTypes);
  }
}
