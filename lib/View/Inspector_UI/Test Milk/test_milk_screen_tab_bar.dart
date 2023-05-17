import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:milk_zilla/View/Inspector_UI/Pick%20Orders/inspector_orders_delivered.dart';
import 'package:milk_zilla/View/Inspector_UI/Pick%20Orders/inspector_orders_pending.dart';
import 'package:milk_zilla/View/Inspector_UI/Pick%20Orders/inspector_orders_picked.dart';
import 'package:milk_zilla/View/Inspector_UI/Test%20Milk/test_milk_delivered.dart';
import 'package:milk_zilla/View/Inspector_UI/Test%20Milk/test_milk_pending.dart';
import 'package:milk_zilla/View/Inspector_UI/Test%20Milk/test_milk_picked.dart';
import 'package:milk_zilla/res/Components/my_drawer.dart';
import 'package:milk_zilla/res/Components/my_drawers/inspector_drawer.dart';

import '../../../res/my_colors.dart';

class TestMilkScreenTabbar extends StatefulWidget {
  const TestMilkScreenTabbar({super.key});

  @override
  State<TestMilkScreenTabbar> createState() => _TestMilkScreenTabbarState();
}

class _TestMilkScreenTabbarState extends State<TestMilkScreenTabbar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.kWhite,
          foregroundColor: MyColors.kPrimary,
          title: const Text('Test Milk For Farm'),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: MyColors.kPrimary,
            unselectedLabelColor: Color.fromARGB(255, 139, 211, 142),
            labelColor: MyColors.kPrimary,
            labelStyle: TextStyle(fontSize: 12),
            automaticIndicatorColorAdjustment: true,
            tabs: [
              Tab(
                text: 'Ready for testing',
              ),
              Tab(
                text: 'Deliver to Shop',
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
            TestMilkPending(),
            TestMilkPicked(),
            TestMilkDilevered(),
          ],
        ),
      ),
    );
  }
}
