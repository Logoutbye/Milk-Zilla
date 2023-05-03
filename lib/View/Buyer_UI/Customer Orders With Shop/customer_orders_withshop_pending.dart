import 'package:flutter/material.dart';

class CustomerOrdersWithShopPending extends StatefulWidget {
  const CustomerOrdersWithShopPending({super.key});

  @override
  State<CustomerOrdersWithShopPending> createState() =>
      _CustomerOrdersWithShopPendingState();
}

class _CustomerOrdersWithShopPendingState
    extends State<CustomerOrdersWithShopPending> {
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
