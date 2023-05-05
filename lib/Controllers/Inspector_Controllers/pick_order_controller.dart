import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:milk_zilla/Utils/utils.dart';

import '../../Model/order_model.dart';

class PickOderController {
  Future<void> PickOder(
      BuildContext context, OrderModel order, var inspector_id) async {
    // Get a reference to the document you want to update
    final documentReference =
        FirebaseFirestore.instance.collection('Orders').doc(order.order_id);
    // Update a field in the document
    documentReference.update({
      'inspector_id': '$inspector_id',
    }).then((value) {
      Utils.toastMessage('Order Picked successfully');
      print('Field updated successfully');
    }).catchError((error) {
      print('Failed to update field: $error');
      Utils.toastMessage('Failed to Pick Up Order ');
    });
  }
}