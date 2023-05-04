import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../Controllers/Seller_Controllers/seller_controller.dart';
import '../../../Model/order_model.dart';

import '../../../res/widgets/my_static_ui_widgets.dart';

class CustomerOrdersDeliverdByShop extends StatefulWidget {
  const CustomerOrdersDeliverdByShop({super.key});

  @override
  State<CustomerOrdersDeliverdByShop> createState() =>
      _CustomerOrdersDeliverdByShopState();
}

class _CustomerOrdersDeliverdByShopState
    extends State<CustomerOrdersDeliverdByShop> {
  SellerContoller sellerController = SellerContoller();
  var shopId;
  @override
  void initState() {
    // this will get us orders placed against shop id
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final email = user.email;
      print('current users email::${email}');
      shopId = email;
      print('shop id::${shopId}');
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<OrderModel>>(
      future: sellerController.getOrdersForShop(shopId, 'Delivered'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Lottie.asset('assets/animations/loading.json',
                  height: MediaQuery.of(context).size.height / 5));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<OrderModel> orders = snapshot.data!;
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              OrderModel order = orders[index];
              return MyStaticUIWidgets.buildOrderUI2(
                  context, order, 'Delivered','Seller');
            },
          );
        } else {
          return Text('No orders found');
        }
      },
    ));
  }
}
