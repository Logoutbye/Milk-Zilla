import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Model/seller_model.dart';

class RegistrationStatusController {
  Future<SellerOrInspectorModel?> readSellerDataFromDatabase(
      var whichUser, var user) async {
    if (whichUser == 'Seller') {
      final data = FirebaseFirestore.instance
          .collection('Sellers')
          .doc('${user!.email}');
      final snapshot = await data.get();

      if (snapshot.exists) {
        return SellerOrInspectorModel.fromJson(snapshot.data()!);
      }
    } else if (whichUser == 'Farmer') {
      final data = FirebaseFirestore.instance
          .collection('Farmers')
          .doc('${user!.email}');
      final snapshot = await data.get();

      if (snapshot.exists) {
        return SellerOrInspectorModel.fromJson(snapshot.data()!);
      }
    } else {
      final data = FirebaseFirestore.instance
          .collection('Inspectors')
          .doc('${user!.email}');
      final snapshot = await data.get();

      if (snapshot.exists) {
        return SellerOrInspectorModel.fromJson(snapshot.data()!);
      }
    }
    return null;
  }
}
