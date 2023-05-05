import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:milk_zilla/Model/seller_model.dart';

class GetAllApprovedShopeswithSpecifCityController {
  Future<List<SellerOrInspectorModel>>
      getAllApprovedShopeswithSpecifCity(var city) async {
    try {
      print('user is searching for shops in ${city}');
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Sellers')
          .where('city', isEqualTo:city )
          .where('status', isEqualTo: 'Approved')
          .get();
      List<SellerOrInspectorModel> shops = querySnapshot.docs
          .map((doc) => SellerOrInspectorModel.fromSnapshot(doc))
          .toList();
      return shops;
    } catch (e) {
      print('Error getting orders for shop: $e');
      return [];
    }
  }

  //insert funciton

}
