import 'package:ugao/Classes/Customer_Model.dart';
import 'package:ugao/Classes/Farmer_Model.dart';
import 'package:ugao/Classes/Supplier_Model.dart';

class User {
  String cnic;
  String name;
  // ignore: non_constant_identifier_names
  String user_Type;
  Farmer farmer;
  Customer customer;
  Supplier supplier;
  String phone_no;

  User({
    cnic,
    name,
    user_Type,
    farmer,
    customer,
    supplier,
    phone_no,
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
    print(this.user_Type);
    print(this.name);
    print(this.cnic);
    print(phone_no);
    if (this.user_Type == "Farmer") {
      this.farmer.printf();
    }
    if (this.user_Type == "Customer") {
      this.customer.printc();
    }
    if (this.user_Type == "Supplier") {
      this.supplier.prints();
    }
  }
}
