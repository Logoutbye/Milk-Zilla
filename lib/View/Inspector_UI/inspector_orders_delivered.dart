import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class InspectorOrdersDelivered extends StatefulWidget {
  const InspectorOrdersDelivered({super.key});

  @override
  State<InspectorOrdersDelivered> createState() =>
      _InspectorOrdersDeliveredState();
}

class _InspectorOrdersDeliveredState extends State<InspectorOrdersDelivered> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('My orders Delivered'),
      ),
    );
  }
}
