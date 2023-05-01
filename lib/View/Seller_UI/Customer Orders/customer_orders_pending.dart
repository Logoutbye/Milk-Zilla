import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/Model/order_model.dart';
import 'package:milk_zilla/controllers/Seller_Controllers/seller_controller.dart';
import 'package:milk_zilla/res/widgets/my_static_ui_widgets.dart';

class CustomerOrdersInPedningByShop extends StatefulWidget {
  const CustomerOrdersInPedningByShop({super.key});

  @override
  State<CustomerOrdersInPedningByShop> createState() =>
      _CustomerOrdersInPedningByShopState();
}

class _CustomerOrdersInPedningByShopState
    extends State<CustomerOrdersInPedningByShop> {
  String shopId = 'shop id';
  SellerContoller buyerContoller = SellerContoller();
  @override
  void initState() {
    // this will get us orders placed against shop id
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final email = user.email;
      print('current users email::${email}');
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<OrderModel>>(
      future: buyerContoller.getOrdersForShop(shopId),
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
              return MyStaticUIWidgets.buildOrderUI2(context, order);
            },
          );
        } else {
          return Text('No orders found');
        }
      },
    ));
  }
}
