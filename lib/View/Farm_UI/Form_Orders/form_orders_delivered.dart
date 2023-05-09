import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FarmOrderDelivered extends StatefulWidget {
  const FarmOrderDelivered({super.key});

  @override
  State<FarmOrderDelivered> createState() => _FarmOrderDeliveredState();
}

class _FarmOrderDeliveredState extends State<FarmOrderDelivered> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Farm Orders Delivered'),
      ),
    );
  }
}
