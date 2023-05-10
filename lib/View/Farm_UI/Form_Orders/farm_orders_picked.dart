import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/controllers/Farm_Controllers/get_order_for_fram_controller.dart';

import '../../../Model/order_model.dart';
import '../../../res/widgets/my_static_ui_widgets.dart';

class FarmOrderPicked extends StatefulWidget {
  const FarmOrderPicked({super.key});

  @override
  State<FarmOrderPicked> createState() => _FarmOrderPickedState();
}

class _FarmOrderPickedState extends State<FarmOrderPicked> {
  var FarmId;
  @override
  void initState() {
    // this will get us orders placed against shop id
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final email = user.email;
      print('current users email::${email}');
      FarmId = email;
      print('FarmId::${FarmId}');
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
getOrderForFarmController farmController =getOrderForFarmController();
    return Scaffold(
        body: FutureBuilder<List<OrderModel>>(
      future: farmController.getOrdersForFarm(FarmId, 'Pending'),
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
                  context, order, 'Pending', 'Farmer');
            },
          );
        } else {
          return Text('No orders found');
        }
      },
    ));
  }
}
