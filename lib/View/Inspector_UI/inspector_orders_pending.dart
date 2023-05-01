import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class InspectorOrdersPending extends StatefulWidget {
  const InspectorOrdersPending({super.key});

  @override
  State<InspectorOrdersPending> createState() => _InspectorOrdersPending();
}

class _InspectorOrdersPending extends State<InspectorOrdersPending> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('My orders in pending'),
      ),
    );
  }
}
