import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class InspectorOrdersPicked extends StatefulWidget {
  const InspectorOrdersPicked({super.key});

  @override
  State<InspectorOrdersPicked> createState() => _InspectorOrdersPickedState();
}

class _InspectorOrdersPickedState extends State<InspectorOrdersPicked> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('My orders in Picked'),
      ),
    );
  }
}
