import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:milk_zilla/Model/order_model.dart';
import 'package:milk_zilla/Utils/utils.dart';

class UpdateStatusGlobalController {
  Future<void> updateStatus(
      BuildContext context, OrderModel order, var status,var collection) async {
    // Get a reference to the document you want to update
    final documentReference =
        FirebaseFirestore.instance.collection(collection).doc(order.order_id);
    // Update a field in the document
    documentReference.update({
      'status': '$status',
    }).then((value) {
      Utils.toastMessage('Order Picked successfully');
      print('Field updated successfully');
    }).catchError((error) {
      print('Failed to update field: $error');
      Utils.toastMessage('Failed to Pick Up Order ');
    });
  }
}
