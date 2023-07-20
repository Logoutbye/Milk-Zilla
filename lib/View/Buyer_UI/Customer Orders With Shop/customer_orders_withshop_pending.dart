import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/controllers/Buyer_Controllers/get_orders_of_customer.dart';

import '../../../Model/order_model.dart';
import '../../../res/widgets/my_static_ui_widgets.dart';

class CustomerOrdersWithShopPending extends StatefulWidget {
  const CustomerOrdersWithShopPending({super.key});

  @override
  State<CustomerOrdersWithShopPending> createState() =>
      _CustomerOrdersWithShopPendingState();
}

class _CustomerOrdersWithShopPendingState
    extends State<CustomerOrdersWithShopPending> {
  getOrdersOfCustomerController  getOrdersForShop = getOrdersOfCustomerController();

  var CustomerId;
  @override
  void initState() {
    // this will get us orders placed against shop id
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final email = user.email;
      print('current users email::${email}');
      CustomerId = email;
      print('shop id::${CustomerId}');
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<OrderModel>>(
      future:getOrdersForShop.getOrdersOfCustomer(CustomerId, 'Pending'),
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
                  context, order, 'Pending', 'Buyer');
            },
          );
        } else {
          return Text('No orders found');
        }
      },
    ));
  }
}
