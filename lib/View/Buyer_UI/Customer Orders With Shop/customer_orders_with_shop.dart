import 'package:flutter/material.dart';
import 'package:milk_zilla/View/Buyer_UI/Customer%20Orders%20With%20Shop/customer_orders_withshop_pending.dart';
import 'package:milk_zilla/View/Buyer_UI/Customer%20Orders%20With%20Shop/customer_orders_withshop_pickedbyinspecter.dart';
import 'package:milk_zilla/View/Buyer_UI/Customer%20Orders%20With%20Shop/customer_orders_withshope_delivered.dart';
import 'package:milk_zilla/res/Components/my_drawers/buyer_drawer.dart';
import 'package:milk_zilla/res/my_colors.dart';

class CustomerOrdersWithShop extends StatefulWidget {
  const CustomerOrdersWithShop({super.key});

  @override
  State<CustomerOrdersWithShop> createState() => _CustomerOrdersWithShopState();
}

class _CustomerOrdersWithShopState extends State<CustomerOrdersWithShop> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
        endDrawer: BuyerDrawer(),
        body: TabBarView(
          children: [
            CustomerOrdersWithShopPending(),
            CustomerOrdersWithShopPickedByInspector(),
            CustomerOrdersWithShopeDelivered(),
          ],
        ),
      ),
    );
  }
}
