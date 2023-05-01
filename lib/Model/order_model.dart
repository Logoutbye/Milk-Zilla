import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String order_id;
  String customerId;
  String customerName;
  String delivery_address;
  int delivery_charges;
  String shopId;
  var status;
  int total_items;
  int total_price;
  List<Map<String, dynamic>> items;
  DateTime timestamp;

  OrderModel({
    required this.order_id,
    required this.customerId,
    required this.customerName,
    required this.shopId,
    required this.status,
    required this.delivery_address,
    required this.delivery_charges,
    required this.total_items,
    required this.total_price,
    required this.items,
    required this.timestamp,
  });

  factory OrderModel.fromSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return OrderModel(
      order_id: doc.id,
      customerId: data['customer_id'],
      customerName: data['customer_name'],
      shopId: data['shop_id'],
      status: data['status'],
      total_items: data['total_items'],
      delivery_address: data['delivery_address'],
      delivery_charges: data['delivery_charges'],
      total_price: data['total_price'],
      items: List<Map<String, dynamic>>.from(data['items']),
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
  // OrderModel.fromJson(Map<String, dynamic> json) {

  //   order_id =json['order_id'];
  //   customerId =json['customer_id'];
  //   shopId =json['shop_id'];
  //   status =json['status'];
  //   total_items =json['total_items'];
  //   delivery_address =json['delivery_address'];
  //   delivery_charges =json['delivery_charges'];
  //   total_price =json['total_price'];
  //   items =json['items'];
  //   timestamp=json['timestamp'];

    
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['order_id'] = this.order_id;
  //   data['customer_name'] = this.customerName;
  //   data['customer_id'] = this.customerId;
  //   data['status'] = this.status;
  //   data['total_items'] = this.total_items;
  //   data['delivery_address'] = this.delivery_address;
  //   data['delivery_charges'] = this.delivery_charges;
  //   data['total_price'] = this.total_price;
  //   data['items'] = this.items;
  //   data['timestamp'] = this.timestamp;
  //   return data;
  // }
}
