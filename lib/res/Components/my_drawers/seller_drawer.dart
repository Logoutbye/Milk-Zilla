import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:milk_zilla/View/Seller_UI/Customer%20Orders/customers_orders.dart';
import 'package:milk_zilla/View/Seller_UI/shop_products_for_selling.dart';
import 'package:milk_zilla/View/my_home_page.dart';
import 'package:milk_zilla/main.dart';
import 'package:milk_zilla/res/Components/my_shared_prefrences.dart';

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

          ListTile(
            leading: const Icon(Icons.production_quantity_limits),
            title: const Text('My Products'),
            onTap: () {
              // MySharedPrefencesSessionHandling
              //     .removeWhichUserLoggedInFromSharedPreferences();

              // FirebaseAuth.instance.signOut();
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ShopeProductsForSelling()));
              navigatorKey.currentState!.popUntil((route) => route.isFirst);
            },
          ),
          // Customer Orders
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Customer Orders'),
            onTap: () {
              // MySharedPrefencesSessionHandling
              //     .removeWhichUserLoggedInFromSharedPreferences();

              // FirebaseAuth.instance.signOut();
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MyAllCustomerOrders()));
              navigatorKey.currentState!.popUntil((route) => route.isFirst);
            },
          ),

          // Customer

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
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
