
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:milk_zilla/Utils/utils.dart';

import '../../res/widgets/report_viewer_screen.dart'; // Add this import for JSON decoding

// ... Your other imports ...

class find_report_by_lot_number_Controller {
  Future<void> printOrderDetails(BuildContext context, String documentIdToAccessTheReport,String documentIdToAssignTheReport) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('Orders With Farm')
          .doc(documentIdToAccessTheReport)
          .get();
      if (documentSnapshot.exists) {
        String inspector_remarks = documentSnapshot['inspector_remarks'];
        String customerId = documentSnapshot['customer_id'];
        String milk_supplierId = documentSnapshot['shop_id'];
        String inspector_id = documentSnapshot['inspector_id'];
        String milk_status = documentSnapshot['milk_status'];
        List<Map<dynamic, dynamic>> order_report = [];

        // Get the raw order_report data from the documentSnapshot
        List<dynamic> rawOrderReport = documentSnapshot['order_report'];

        // Convert each raw item to a Map<dynamic, dynamic> and add it to the order_report list
        rawOrderReport.forEach((item) {
          Map<dynamic, dynamic> orderItem = Map<dynamic, dynamic>.from(item);
          order_report.add(orderItem);
        });

        print('Document ID: $documentIdToAccessTheReport');
        print('Customer ID: $customerId');

        // Now you can use the order_report list as needed.
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
            ViewMilkReport(
              milk_supplier: milk_supplierId,
              customer_id: customerId,
              inspector_id: inspector_id,
              inspector_remarks: inspector_remarks,
              order_report: order_report,
              milk_status: milk_status,
              viewOnly: false,
              orderId: documentIdToAssignTheReport,
            )));

        Utils.toastMessage('Success');
      } else {
        print('Document with ID $documentIdToAccessTheReport does not exist.');
        Utils.toastMessage('Document with ID $documentIdToAccessTheReport does not exist.');
      }
    } catch (e) {
      print('Error getting order by ID: $e');
      Utils.toastMessage('Error getting order by ID: $e');
    }
  }
}
