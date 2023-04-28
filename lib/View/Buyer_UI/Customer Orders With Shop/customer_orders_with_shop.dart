import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:milk_zilla/View/Buyer_UI/Customer%20Orders%20With%20Shop/customer_orders_withshop_pending.dart';
import 'package:milk_zilla/View/Buyer_UI/Customer%20Orders%20With%20Shop/customer_orders_withshop_pickedbyinspecter.dart';
import 'package:milk_zilla/View/Buyer_UI/Customer%20Orders%20With%20Shop/customer_orders_withshope_delivered.dart';
import 'package:milk_zilla/res/Components/my_drawers/buyer_drawer.dart';

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
          centerTitle: true,
          bottom: TabBar(
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
        drawer: BuyerDrawer(),
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
