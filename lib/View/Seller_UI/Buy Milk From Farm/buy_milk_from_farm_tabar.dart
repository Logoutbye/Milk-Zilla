import 'package:flutter/material.dart';
import 'package:milk_zilla/View/Seller_UI/Buy%20Milk%20From%20Farm/buy_milk_from_farm_delivered.dart';
import 'package:milk_zilla/View/Seller_UI/Buy%20Milk%20From%20Farm/buy_milk_from_farm_pending.dart';
import 'package:milk_zilla/View/Seller_UI/Buy%20Milk%20From%20Farm/buy_milk_from_farm_picked.dart';

import '../../../res/Components/my_drawers/seller_drawer.dart';
import '../../../res/my_colors.dart';

class BuyMilkFromFarmTabar extends StatefulWidget {
  const BuyMilkFromFarmTabar({super.key});

  @override
  State<BuyMilkFromFarmTabar> createState() => _BuyMilkFromFarmTabarState();
}

class _BuyMilkFromFarmTabarState extends State<BuyMilkFromFarmTabar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.kWhite,
          foregroundColor: MyColors.kPrimary,
          title: const Text('Order Milk For Shop'),
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
            BuyMilkFromFarmPending(),
            BuyMilkFromFarmPicked(),
            BuyMilkFromFarmDelivered(),
          ],
        ),
      ),
    );
  }
}
