import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:milk_zilla/Model/seller_model.dart';

import '../../Model/order_model.dart';

class FarmController {
  Future<List<OrderModel>> getOrderFromFarm(
      String shopId, String status) async {
    try {
      print("shop id for which getting orders from database " + shopId);
      print("status of order for which getting orders from database " + status);

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Orders')
          .where('shop_id', isEqualTo: shopId)
          .where('status', isEqualTo: status)
          .get();
      List<OrderModel> orders = querySnapshot.docs
          .map((doc) => OrderModel.fromSnapshot(doc))
          .cast<OrderModel>()
          .toList();
      return orders;
    } catch (e) {
      print('Error getting orders for shop: $e');
      return [];
    }
  }
}
