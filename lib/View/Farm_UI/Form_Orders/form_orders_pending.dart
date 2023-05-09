import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FarmOerdersPending extends StatefulWidget {
  const FarmOerdersPending({super.key});

  @override
  State<FarmOerdersPending> createState() => _FarmOerdersPendingState();
}

class _FarmOerdersPendingState extends State<FarmOerdersPending> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Farm Orders Pinding'),
      ),
    );
  }
}
