import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/Utils/utils.dart';
import 'package:milk_zilla/View/Buyer_UI/purchased_screen.dart';
import 'package:milk_zilla/provider/Sopping_item_provider.dart';
import 'package:provider/provider.dart';

class CreateAnOrderController {
// This function creates a new order document in Firestore.
  Future<void> createOrder(
    BuildContext context,
    var giveme_customer_id,
    var giveme_customer_name,
    var giveme_delivery_adress,
    var giveme_delivery_charges,
    List<Map<dynamic, dynamic>> giveme_order_details,
    // var giveme_order_id,
    var giveme_shop_id,
    var giveme_status,
    var giveme_total_items,
    var giveme_total_price,
    var giveme_inspector_id,
    var giveme_lat,
    var giveme_long,
  ) async {
    //start animation
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: Lottie.asset('assets/animations/loading.json',
                  height: MediaQuery.of(context).size.height / 5),
            ));
    try {
      CollectionReference orders =
          FirebaseFirestore.instance.collection('Orders');
      DocumentReference orderRef = await orders.add({
        'customer_id': giveme_customer_id,
        'customer_name': giveme_customer_name,
        'delivery_address': giveme_delivery_adress,
        'delivery_charges': giveme_delivery_charges,
        'inspector_id': giveme_inspector_id,
        'items': giveme_order_details,
        // 'order_id': giveme_order_id,
        'shop_id': giveme_shop_id,
        'status': 'Pending',
        'timestamp': FieldValue.serverTimestamp(),
        'total_items': giveme_total_items,
        'total_price': giveme_total_price,
        'lat': giveme_lat,
        'long': giveme_long
      });

      // once data of an order is sent to firebase the provider then would be reset to zero so that
      // user can make a new order easily.
      Provider.of<ShoppingItemProvider>(context, listen: false)
          .reset('Buffalo Milk');
      Provider.of<ShoppingItemProvider>(context, listen: false)
          .reset('Cow Milk');
      Provider.of<ShoppingItemProvider>(context, listen: false)
          .reset('Mix Milk');
      Provider.of<ShoppingItemProvider>(context, listen: false).reset('Yogurt');
      Provider.of<ShoppingItemProvider>(context, listen: false).reset('Butter');
      Provider.of<ShoppingItemProvider>(context, listen: false)
          .reset('Desi Ghee');
      // totalItems = 0;
      // totalPrice = 0;
      // deliveryAddressController.clear();

      //show message to user
      Utils.toastMessage('Order Created SuccessFully');
      // go back
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PurchasedScreen(
                result: 'successful',
                order_no: '${orderRef.id}',
              )));

      print('Order created with ID: ${orderRef.id}');
    } catch (e) {
      print('Error creating order: $e');
      Utils.toastMessage('$e');
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PurchasedScreen(
                result: 'un-successful',
                order_no: null,
              )));
    }
  }
}
