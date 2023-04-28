import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:milk_zilla/res/Components/my_drawers/seller_drawer.dart';

class CustomerOrdersDeliverdByShop extends StatefulWidget {
  const CustomerOrdersDeliverdByShop({super.key});

  @override
  State<CustomerOrdersDeliverdByShop> createState() =>
      _CustomerOrdersDeliverdByShopState();
}

class _CustomerOrdersDeliverdByShopState
    extends State<CustomerOrdersDeliverdByShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Orders Deliverd')],
          ),
        ),
      ),
    );
  }
}
