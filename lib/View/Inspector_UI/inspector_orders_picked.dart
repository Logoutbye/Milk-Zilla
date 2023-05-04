import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

import '../../Model/order_model.dart';
import '../../controllers/Inspector_Controllers/get_orders_for_inpectors.dart';
import '../../res/widgets/my_static_ui_widgets.dart';

class InspectorOrdersPicked extends StatefulWidget {
  const InspectorOrdersPicked({super.key});

  @override
  State<InspectorOrdersPicked> createState() => _InspectorOrdersPickedState();
}

class _InspectorOrdersPickedState extends State<InspectorOrdersPicked> {

      getOrdersForInspectorController GetOrdersForInspectorController = getOrdersForInspectorController();

  @override
  Widget build(BuildContext context) {
     return Scaffold(
        body: FutureBuilder<List<OrderModel>>(
      future: GetOrdersForInspectorController.getOrdersForInspector('Shipped'),
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
              return MyStaticUIWidgets.buildOrderUI2(context, order, 'Shipped','Inspector');
            },
          );
        } else {
          return Text('No orders found');
        }
      },
    ));
  
  }
}
