import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Model/order_model.dart';
import '../../Utils/utils.dart';

class TestOrderController {
  Future<void> TestOrder(
      BuildContext context, OrderModel order, var inspector_id) async {
    // Get a reference to the document you want to update
    final documentReference =
        FirebaseFirestore.instance.collection('Orders With Farm').doc(order.order_id);
    // Update a field in the document
    documentReference.update({
      'inspector_id': '$inspector_id',
      'test_report_id':''
    }).then((value) {
      Utils.toastMessage('Milk tested successfully');
      print('Field updated successfully');
    }).catchError((error) {
      print('Failed to update field: $error');
      Utils.toastMessage('Failed to test milk ');
    });
  }
}