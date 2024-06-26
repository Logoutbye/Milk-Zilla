import 'package:flutter/material.dart';
import 'package:milk_zilla/View/Buyer_UI/Customer%20Orders%20With%20Shop/customer_orders_withshop_pending.dart';
import 'package:milk_zilla/View/Buyer_UI/Customer%20Orders%20With%20Shop/customer_orders_withshop_picked_by_inspecter.dart';
import 'package:milk_zilla/View/Buyer_UI/Customer%20Orders%20With%20Shop/customer_orders_withshope_delivered.dart';
import 'package:milk_zilla/res/Components/my_drawers/buyer_drawer.dart';
import 'package:milk_zilla/res/my_colors.dart';

import 'customer_orders_withshop_prepared_by_seller.dart';

class CustomerOrdersWithShopTabBar extends StatefulWidget {
  const CustomerOrdersWithShopTabBar({super.key});

  @override
  State<CustomerOrdersWithShopTabBar> createState() => _CustomerOrdersWithShopTabBarState();
}

class _CustomerOrdersWithShopTabBarState extends State<CustomerOrdersWithShopTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Orders'),
          backgroundColor: MyColors.kWhite,
          foregroundColor: MyColors.kPrimary,
          centerTitle: true,
          // automaticallyImplyLeading: false,
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
                text: 'Prepared',
              ),
              Tab(
                text: 'Shipped',
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
        endDrawer: BuyerDrawer(),
        body: TabBarView(
          children: [
            CustomerOrdersWithShopPending(),
            CustomerOrdersWithShopPreparedBySeller(),
            CustomerOrdersWithShopPickedByInspector(),
            CustomerOrdersWithShopeDelivered(),
          ],
        ),
      ),
    );
  }
}
