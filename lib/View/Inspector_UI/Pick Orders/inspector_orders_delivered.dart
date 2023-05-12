import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/Model/order_model.dart';
import 'package:milk_zilla/controllers/Inspector_Controllers/get_orders_for_inpectors.dart';

import '../../../res/widgets/my_static_ui_widgets.dart';

class InspectorOrdersDelivered extends StatefulWidget {
  const InspectorOrdersDelivered({super.key});

  @override
  State<InspectorOrdersDelivered> createState() =>
      _InspectorOrdersDeliveredState();
}

class _InspectorOrdersDeliveredState extends State<InspectorOrdersDelivered> {
  getOrdersForInspectorController GetOrdersForInspectorController =
      getOrdersForInspectorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<OrderModel>>(
      future:
          GetOrdersForInspectorController.getOrdersForInspector('Delivered','Orders'),
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
                  context, order, 'Delivered', 'Inspector');
            },
          );
        } else {
          return Text('No orders found');
        }
      },
    ));
  }
}
