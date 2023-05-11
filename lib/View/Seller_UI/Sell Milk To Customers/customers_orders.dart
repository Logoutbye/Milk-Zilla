import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:milk_zilla/View/Seller_UI/Sell%20Milk%20To%20Customers/customer_orders_delivered.dart';
import 'package:milk_zilla/View/Seller_UI/Sell%20Milk%20To%20Customers/customer_orders_pending.dart';
import 'package:milk_zilla/View/Seller_UI/Sell%20Milk%20To%20Customers/customer_orders_pickedby_inspecter.dart';

import '../../../res/Components/my_drawers/seller_drawer.dart';
import '../../../res/my_colors.dart';

class MyAllCustomerOrders extends StatefulWidget {
  const MyAllCustomerOrders({super.key});

  @override
  State<MyAllCustomerOrders> createState() => _MyAllCustomerOrdersState();
}

class _MyAllCustomerOrdersState extends State<MyAllCustomerOrders> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.kWhite,
          foregroundColor: MyColors.kPrimary,
          title: const Text('Customer Orders'),
          centerTitle: true,
          automaticallyImplyLeading: false,
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
        ),
        endDrawer: SellerDrawer(),
        body: TabBarView(
          children: [
            CustomerOrdersInPedningByShop(),
            CustomerOrdersPickedbyInspecterFromShop(),
            CustomerOrdersDeliverdByShop(),
          ],
        ),
      ),
    );
  }
}
