// The next step would be to implement the logic for the shop owner and delivery boy to access the orders.
// Here are the steps you can follow:

// Shop Owner Access: The shop owner should be able to view all the orders that have been placed from their shop.
//You can implement this by querying the "orders" collection in Firestore for all documents where the shop_id field matches
//the ID of the shop owner's shop. You can use the get method to retrieve the documents that match the query, and then display
//the orders to the shop owner in your app.

// Delivery Boy Access: The delivery boy should be able to view all the orders that they need to deliver. You can implement
//this by querying the "orders" collection in Firestore for all documents where the status field is "out_for_delivery".
// You can use the get method to retrieve the documents that match the query, and then display the orders to the delivery boy in your app.

// To implement these functionalities, you can create separate functions for querying the "orders" collection in Firestore and
//retrieving the orders based on the criteria. Here is some sample code to retrieve the orders for the shop owner and delivery boy:

// import 'package:cloud_firestore/cloud_firestore.dart';

// // This function retrieves all orders placed from a specific shop.
// Future<List<DocumentSnapshot>> getOrdersForShop(String shopId) async {
//   try {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection('orders')
//         .where('shop_id', isEqualTo: shopId)
//         .get();
//     List<DocumentSnapshot> documents = querySnapshot.docs;
//     return documents;
//   } catch (e) {
//     print('Error retrieving orders for shop: $e');
//     return null;
//   }
// }

// // This function retrieves all orders that are out for delivery.
// Future<List<DocumentSnapshot>> getOrdersForDelivery() async {
//   try {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection('orders')
//         .where('status', isEqualTo: 'out_for_delivery')
//         .get();
//     List<DocumentSnapshot> documents = querySnapshot.docs;
//     return documents;
//   } catch (e) {
//     print('Error retrieving orders for delivery: $e');
//     return null;
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:milk_zilla/res/constanst.dart';
// // import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// class reportScreen extends StatefulWidget {
//   const reportScreen({super.key});

//   @override
//   State<reportScreen> createState() => _reportScreenState();
// }

// class _reportScreenState extends State<reportScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Stataus: Approved'),
//         ),
//         body: Center(
//           child: Container(child: Image.network(ApprovedReportPhotoLink)),
//         ));
//   }
// }
