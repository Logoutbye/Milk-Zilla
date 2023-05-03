import 'package:flutter/material.dart';

class CustomerOrdersWithShopPickedByInspector extends StatefulWidget {
  const CustomerOrdersWithShopPickedByInspector({super.key});

  @override
  State<CustomerOrdersWithShopPickedByInspector> createState() =>
      _CustomerOrdersWithShopPickedByInspectorState();
}

class _CustomerOrdersWithShopPickedByInspectorState
    extends State<CustomerOrdersWithShopPickedByInspector> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Orders Picked by inspector'),
            ],
          ),
        ),
      ),
    );
  }
}
