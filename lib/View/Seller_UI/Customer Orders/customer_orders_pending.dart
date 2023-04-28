import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:milk_zilla/res/Components/my_drawers/seller_drawer.dart';

class CustomerOrdersInPedningByShop extends StatefulWidget {
  const CustomerOrdersInPedningByShop({super.key});

  @override
  State<CustomerOrdersInPedningByShop> createState() =>
      _CustomerOrdersInPedningByShopState();
}

class _CustomerOrdersInPedningByShopState
    extends State<CustomerOrdersInPedningByShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Orders Pending')],
          ),
        ),
      ),
    );
  }
}
