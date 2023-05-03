import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../Model/price_list_model.dart';

class getRealTimePricesFromDatabaseforCreatingAnOrderController{
    Future<PriceListModel?> getRealTimePricesFromDatabaseforCreatingAnOrder() async {
    final docPrices =
        FirebaseFirestore.instance.collection('Price List').doc('items');
    final snapshot = await docPrices.get();

    if (snapshot.exists) {
      return PriceListModel.fromJson(snapshot.data()!);
    }
  }
}