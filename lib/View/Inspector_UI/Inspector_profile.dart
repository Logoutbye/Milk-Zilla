import 'package:flutter/cupertino.dart';

class InspectorProfile extends StatefulWidget {
  const InspectorProfile({super.key});

  @override
  State<InspectorProfile> createState() => _InspectorProfileState();
}

class _InspectorProfileState extends State<InspectorProfile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('My Profile'),
      ),
    );
  }
}
