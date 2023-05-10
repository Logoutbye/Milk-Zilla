import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:milk_zilla/Model/seller_model.dart';

import '../../Model/order_model.dart';

class FarmController {
  Future<List<SellerOrInspectorModel>> getAllApprovedFarmswithSpecifCity(
      var city) async {
    try {
      print('user is searching for shops in ${city}');
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Farmers')
          .where('city', isEqualTo: city)
          .where('status', isEqualTo: 'Approved')
          .get();
      List<SellerOrInspectorModel> farms = querySnapshot.docs
          .map((doc) => SellerOrInspectorModel.fromSnapshot(doc))
          .toList();
      return farms;
    } catch (e) {
      print('Error getting orders from Farm: $e');
      return [];
    }
  }
}
