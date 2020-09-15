import 'package:ugao/Classes/Customer_Model.dart';
import 'package:ugao/Classes/Farmer_Model.dart';
import 'package:ugao/Classes/Supplier_Model.dart';
import 'package:ugao/constants.dart';

class User {
  String cnic;
  String fullName;
  String pass;
  String usertype;
  Farmer farmer;
  Customer customer;
  Supplier supplier;
  String phone_no;

  User({
    this.cnic,
    this.pass,
    this.fullName,
    this.usertype,
    this.farmer,
    this.customer,
    this.supplier,
    this.phone_no,
  });
  void farmer_set(Farmer fobject) {
    this.farmer.set_farmer(fobject);
  }

  void set_supplier(Supplier sobject) {
    this.supplier.set_Supplier(sobject);
  }

  void set_customer(Customer cobject) {
    this.customer.set_customer(cobject);
  }

  void print_user() {
    print(this.usertype);
    print(this.fullName);
    print(this.cnic);
    print(phone_no);
    if (this.usertype == FARMER) {
      this.farmer.printf();
    }
    if (this.usertype == CUSTOMER) {
      this.customer.printc();
    }
    if (this.usertype == SUPPLIER) {
      this.supplier.prints();
    }
  }
}
