import 'package:cloud_firestore/cloud_firestore.dart';

class SellerOrInspectorModel {
  var name;
  var mobile_no;
  var city;
  var shop_name;
  var farm_name;
  var shop_adress;
  var farm_adress;
  var inspector_adress;
  var email;
  var password;
  var lat;
  var long;
  var status;

  SellerOrInspectorModel({
    required this.name,
    required this.mobile_no,
    required this.city,
    required this.shop_name,
    required this.farm_name,
    required this.shop_adress,
    required this.farm_adress,
    required this.inspector_adress,
    required this.email,
    required this.password,
    required this.lat,
    required this.long,
    required this.status,
  });

  factory SellerOrInspectorModel.fromSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return SellerOrInspectorModel(
        name: data['name'],
        mobile_no: data['mobile_no'],
        city: data['city'],
        shop_name: data['shop_name'],
        farm_name: data['farm_name'],
        shop_adress: data['shop_adress'],
        farm_adress: data['farm_adress'],
        inspector_adress: data['inspector_adress'],
        email: data['email'],
        password: data['password'],
        lat: data['lat'],
        long: data['long'],
        status: data['status']);
    // Order(
    //   id: doc.id,
    //   customerId: data['customer_id'],
    //   shopId: data['shop_id'],
    //   status: data['status'],
    //   items: List<Map<String, dynamic>>.from(data['items']),
    //   timestamp: (data['timestamp'] as Timestamp).toDate(),
    // );
  }

  SellerOrInspectorModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile_no = json['mobile_no'];
    city = json['city'];
    shop_name = json['shop_name'];
    farm_name = json['farm_name'];
    shop_adress = json['shop_adress'];
    farm_adress = json['farm_adress'];
    inspector_adress = json['inspector_adress'];
    email = json['email'];
    lat = json['lat'];
    long = json['long'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile_no'] = this.mobile_no;
    data['city'] = this.city;
    data['shop_name'] = this.shop_name;
    data['farm_name'] = this.farm_name;
    data['shop_adress'] = this.shop_adress;
    data['farm_adress'] = this.farm_adress;
    data['inspector_adress'] = this.inspector_adress;
    data['email'] = this.email;
    data['lat'] = this.lat;
    data['long'] = this.long;
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

