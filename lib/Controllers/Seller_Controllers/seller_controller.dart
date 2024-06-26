import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Model/order_model.dart';

class SellerContoller {
  // get order from shop container
  Future<List<OrderModel>> getOrdersForShop(
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

  // get order from farm
  Future<List<OrderModel>> getOrdersForShopWithFarm(
      String shopId, String status) async {
    try {
      print("shop id  " + shopId);
      print("status of order " + status);

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Orders With Farm')
          .where('customer_id', isEqualTo: shopId)
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
