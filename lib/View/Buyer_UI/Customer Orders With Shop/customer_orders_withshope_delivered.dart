import 'package:flutter/material.dart';

class CustomerOrdersWithShopeDelivered extends StatefulWidget {
  const CustomerOrdersWithShopeDelivered({super.key});

  @override
  State<CustomerOrdersWithShopeDelivered> createState() =>
      _CustomerOrdersWithShopeDeliveredState();
}

class _CustomerOrdersWithShopeDeliveredState
    extends State<CustomerOrdersWithShopeDelivered> {
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
