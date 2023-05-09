import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FarmOrderPicked extends StatefulWidget {
  const FarmOrderPicked({super.key});

  @override
  State<FarmOrderPicked> createState() => _FarmOrderPickedState();
}

class _FarmOrderPickedState extends State<FarmOrderPicked> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Farm Orders Picked'),
      ),
    );
  }
}
