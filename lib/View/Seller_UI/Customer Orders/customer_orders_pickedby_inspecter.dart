import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:milk_zilla/res/Components/my_drawers/seller_drawer.dart';

class CustomerOrdersPickedbyInspecterFromShop extends StatefulWidget {
  const CustomerOrdersPickedbyInspecterFromShop({super.key});

  @override
  State<CustomerOrdersPickedbyInspecterFromShop> createState() =>
      _CustomerOrdersPickedbyInspecterFromShopState();
}

class _CustomerOrdersPickedbyInspecterFromShopState
    extends State<CustomerOrdersPickedbyInspecterFromShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Orders Picked by Inspector')],
          ),
        ),
      ),
    );
  }
}
