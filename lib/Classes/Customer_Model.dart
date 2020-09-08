class Customer {
  String cAccountType;
  //String cPhoneNumber;
  String ccName;
  String ccPhoneNumber;
  String ccWebsite;

  Customer({
    this.cAccountType,
    //this.cPhoneNumber,
    this.ccName,
    this.ccPhoneNumber,
    this.ccWebsite,
  });
  void set_customer(Customer cobject) {
    this.cAccountType = cobject.cAccountType;
    //this.cPhoneNumber = cobject.cPhoneNumber;
    this.ccName = cobject.ccName;
    this.ccPhoneNumber = cobject.ccPhoneNumber;
    this.ccWebsite = cobject.ccWebsite;
  }

  void printc() {
    print(this.cAccountType);
    //print(this.cPhoneNumber);
    print(this.ccName);
    print(this.ccPhoneNumber);
    print(this.ccWebsite);
  }
}
