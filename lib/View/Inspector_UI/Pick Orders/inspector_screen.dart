import 'package:flutter/material.dart';
import 'package:milk_zilla/View/Inspector_UI/Pick%20Orders/inspector_orders_delivered.dart';
import 'package:milk_zilla/View/Inspector_UI/Pick%20Orders/inspector_orders_pending.dart';
import 'package:milk_zilla/View/Inspector_UI/Pick%20Orders/inspector_orders_picked.dart';
import 'package:milk_zilla/res/Components/my_drawers/inspector_drawer.dart';

import '../../../res/my_colors.dart';

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
          backgroundColor: MyColors.kWhite,
          foregroundColor: MyColors.kPrimary,
          title: const Text('Pick Orders'),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: MyColors.kPrimary,
            unselectedLabelColor: Color.fromARGB(255, 139, 211, 142),
            labelColor: MyColors.kPrimary,
            // labelStyle: TextStyle(fontSize: 15),
            automaticIndicatorColorAdjustment: true,
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
          actions: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Builder(
                    builder: (context) => IconButton(
                          icon: Icon(Icons.settings),
                          // iconSize: 40,
                          onPressed: () => Scaffold.of(context).openEndDrawer(),
                        )))
          ],
        ),
        endDrawer: InspectorDrawer(),
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
