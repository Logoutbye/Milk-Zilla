import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/controllers/Inspector_Controllers/get_orders_for_inpectors.dart';
import 'package:milk_zilla/res/widgets/my_static_ui_widgets.dart';

import '../../../Model/order_model.dart';

class InspectorOrdersPending extends StatefulWidget {
  const InspectorOrdersPending({super.key});

  @override
  State<InspectorOrdersPending> createState() => _InspectorOrdersPending();
}

class _InspectorOrdersPending extends State<InspectorOrdersPending> {
  getOrdersForInspectorController GetOrdersForInspectorController =
      getOrdersForInspectorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<OrderModel>>(
      future: GetOrdersForInspectorController.getOrdersForInspector('Prepared','Orders'),
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
                  context, order, 'Prepared', 'Inspector');
            },
          );
        } else {
          return Text('No orders found');
        }
      },
    ));
  }
}
