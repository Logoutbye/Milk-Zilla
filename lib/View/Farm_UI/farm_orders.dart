import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:milk_zilla/View/Farm_UI/Form_Orders/farm_orders_picked.dart';
import 'package:milk_zilla/View/Farm_UI/Form_Orders/form_orders_delivered.dart';
import 'package:milk_zilla/View/Farm_UI/Form_Orders/form_orders_pending.dart';
import 'package:milk_zilla/res/Components/my_drawers/farm_drawer.dart';

import '../../res/Components/my_drawers/buyer_drawer.dart';
import '../../res/my_colors.dart';

class FarmOrders extends StatefulWidget {
  const FarmOrders({super.key});

  @override
  State<FarmOrders> createState() => _FarmOrdersState();
}

class _FarmOrdersState extends State<FarmOrders> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Farm Orders'),
          backgroundColor: MyColors.kWhite,
          foregroundColor: MyColors.kPrimary,
          centerTitle: true,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            indicatorColor: MyColors.kPrimary,
            unselectedLabelColor: Color.fromARGB(255, 139, 211, 142),
            labelColor: MyColors.kPrimary,
            labelStyle: TextStyle(fontSize: 15),
            automaticIndicatorColorAdjustment: true,
            tabs: [
              Tab(
                text: 'Pending',
              ),
              Tab(
                text: 'Picked',
              ),
              Tab(
                text: 'Delivered',
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
        endDrawer: FarmDrawer(),
        body: TabBarView(
          children: [
            FarmOerdersPending(),
            FarmOrderPicked(),
            FarmOrderDelivered(),
          ],
        ),
      ),
    );
  }
}
