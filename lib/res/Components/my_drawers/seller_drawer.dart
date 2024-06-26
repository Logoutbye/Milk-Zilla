import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:milk_zilla/View/Seller_UI/Shop%20Orders/all_farms_to_order_milk.dart';
import 'package:milk_zilla/View/Seller_UI/seller_dashboard.dart';
import 'package:milk_zilla/View/Seller_UI/shop_products_for_selling.dart';
import 'package:milk_zilla/View/my_home_page.dart';
import 'package:milk_zilla/res/Components/my_shared_prefrences.dart';
import 'package:milk_zilla/res/my_colors.dart';

import '../../../View/Seller_UI/Sell Milk To Customers/customers_orders.dart';

class SellerDrawer extends StatefulWidget {
  SellerDrawer({super.key});

  @override
  State<SellerDrawer> createState() => _SellerDrawerState();
}

class _SellerDrawerState extends State<SellerDrawer> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
            ), //BoxDecoration
            child: Image(image: AssetImage('assets/images/icon.png')),
          ), //DrawerHeader

          // seller dashboard
          ListTile(
            leading: const Icon(
              Icons.production_quantity_limits,
              size: 35,
              color: MyColors.kPrimary,
            ),
            title: const Text('Dashboard',
                style: TextStyle(
                  color: MyColors.kPrimary,
                )),
            onTap: () {
              //Navigator.pop(context);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SellerDashboard()));
            },
          ),

          // Customer Orders
          ListTile(
            leading: const Icon(
              Icons.people,
              color: MyColors.kPrimary,
            ),
            title: const Text('Sell Milk',
                style: TextStyle(color: MyColors.kPrimary)),
            onTap: () {
              // MySharedPrefencesSessionHandling
              //     .removeWhichUserLoggedInFromSharedPreferences();

              // FirebaseAuth.instance.signOut();
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MyAllCustomerOrders()));
              //navigatorKey.currentState!.popUntil((route) => route.isFirst);
            },
          ),

          // create an order from farm
          ListTile(
            leading: const Icon(
              Icons.production_quantity_limits,
              size: 35,
              color: MyColors.kPrimary,
            ),
            title: const Text('Create an Order',
                style: TextStyle(
                  color: MyColors.kPrimary,
                )),
            onTap: () {
              //Navigator.pop(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AllFarmsToOrderMilk()));
            },
          ),

          ListTile(
            leading: Image.asset(
              'assets/images/my_products.png',
              height: 40,
              color: MyColors.kPrimary,
            ),
            title: const Text(
              'My Products',
              style: TextStyle(color: MyColors.kPrimary),
            ),
            onTap: () {
              // MySharedPrefencesSessionHandling
              //     .removeWhichUserLoggedInFromSharedPreferences();

              // FirebaseAuth.instance.signOut();
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ShopeProductsForSelling()));
              //navigatorKey.currentState!.popUntil((route) => route.isFirst);
            },
          ),
          Divider(
            color: MyColors.kPrimary,
          ),

          // Customer

          ListTile(
            leading: const Icon(
              Icons.logout,
              color: MyColors.kPrimary,
            ),
            title: const Text('Logout',
                style: TextStyle(color: MyColors.kPrimary)),
            onTap: () {
              MySharedPrefencesSessionHandling
                  .removeWhichUserLoggedInFromSharedPreferences();

              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MyHomePage()));
              // navigatorKey.currentState!.popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }
}
