import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:milk_zilla/View/Inspector_UI/inspector_orders_delivered.dart';
import 'package:milk_zilla/View/Inspector_UI/inspector_orders_pending.dart';
import 'package:milk_zilla/View/Inspector_UI/inspector_orders_picked.dart';
import 'package:milk_zilla/res/Components/my_drawer.dart';
import 'package:milk_zilla/res/Components/my_drawers/inspector_drawer.dart';

class InspectorScreen extends StatefulWidget {
  const InspectorScreen({super.key});

  @override
  State<InspectorScreen> createState() => _InspectorScreenState();
}

class _InspectorScreenState extends State<InspectorScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Orders'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Ready to pick',
              ),
              Tab(
                text: 'Picked',
              ),
              Tab(
                text: 'Deliverd',
              ),
            ],
          ),
        ),
        drawer: InspectorDrawer(),
        body: TabBarView(
          children: [
            InspectorOrdersPending(),
            InspectorOrdersPicked(),
            InspectorOrdersDelivered(),
          ],
        ),
      ),
    );
  }
}
