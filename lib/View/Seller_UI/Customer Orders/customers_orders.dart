import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:milk_zilla/View/Seller_UI/Customer%20Orders/customer_orders_delivered.dart';
import 'package:milk_zilla/View/Seller_UI/Customer%20Orders/customer_orders_pending.dart';
import 'package:milk_zilla/View/Seller_UI/Customer%20Orders/customer_orders_pickedby_inspecter.dart';

import '../../../res/Components/my_drawers/seller_drawer.dart';

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
          title: const Text('Customer Orders'),
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
        drawer: SellerDrawer(),
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
