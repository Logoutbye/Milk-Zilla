class SellerOrInspectorModel {
  var name;
  var mobile_no;
  var city;
  var shop_name;
  var shop_adress;
  var inspector_adress;
  var email;
  var password;
  var status;

  SellerOrInspectorModel({
    required this.name,
    required this.mobile_no,
    required this.city,
    required this.shop_name,
    required this.shop_adress,
    required this.inspector_adress,
    required this.email,
    required this.password,
    required this.status,
  });

  SellerOrInspectorModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile_no = json['mobile_no'];
    city = json['city'];
    shop_name = json['shop_name'];
    shop_adress = json['shop_adress'];
    inspector_adress = json['inspector_adress'];
    email = json['email'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile_no'] = this.mobile_no;
    data['city'] = this.city;
    data['shop_name'] = this.shop_name;
    data['shop_adress'] = this.shop_adress;
    data['inspector_adress'] = this.inspector_adress;
    data['email'] = this.email;
    data['status'] = this.status;
    return data;
  }
}

// class InspectorModel {
//   var name;
//   var mobile_no;
//   var city;
//   var inspector_adress;
//   var email;
//   var password;
//   var status;

//   InspectorModel({
//     required this.name,
//     required this.mobile_no,
//     required this.city,
//     required this.inspector_adress,
//     required this.email,
//     required this.password,
//     required this.status,
//   });

//   InspectorModel.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     mobile_no = json['mobile_no'];
//     city = json['city'];
//     inspector_adress = json['inspector_adress'];
//     email = json['email'];
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['mobile_no'] = this.mobile_no;
//     data['city'] = this.city;
//     data['inspector_adress'] = this.inspector_adress;
//     data['email'] = this.email;
//     data['status'] = this.status;
//     return data;
//   }
// }
