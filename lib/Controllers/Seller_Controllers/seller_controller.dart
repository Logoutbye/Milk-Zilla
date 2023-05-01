import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:milk_zilla/Model/seller_model.dart';

import '../../Model/order_model.dart';

class SellerContoller {
 Future<List<OrderModel>> getOrdersForShop(String shopId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Orders')
          .where('shop_id', isEqualTo: shopId)
          .get();
      List<OrderModel> orders =
          querySnapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).cast<OrderModel>().toList();
      return orders;
    } catch (e) {
      print('Error getting orders for shop: $e');
      return [];
    }
  }
}
