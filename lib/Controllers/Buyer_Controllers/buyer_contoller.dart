import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:milk_zilla/Model/seller_model.dart';

class BuyerContoller {
  Future<List<SellerOrInspectorModel>>
      getAllApprovedShpeswithSpecifCity() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Sellers')
          .where('city', isEqualTo: 'Abbottabad')
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
