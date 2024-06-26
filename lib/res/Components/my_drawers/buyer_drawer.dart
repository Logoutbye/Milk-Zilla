import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:milk_zilla/View/Buyer_UI/Customer%20Orders%20With%20Shop/customer_orders_with_shop_tabbar.dart';
import 'package:milk_zilla/View/my_home_page.dart';
import 'package:milk_zilla/res/Components/my_shared_prefrences.dart';


class BuyerDrawer extends StatefulWidget {
  BuyerDrawer({super.key});

  @override
  State<BuyerDrawer> createState() => _BuyerDrawerState();
}

class _BuyerDrawerState extends State<BuyerDrawer> {
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

          // ListTile(
          //   leading: const Icon(Icons.production_quantity_limits),
          //   title: const Text('Pdf testing'),
          //   onTap: () {
            

          //     Navigator.of(context).push(
          //         MaterialPageRoute(builder: (context) => reportScreen()));
          //   },
          // ),
          // // Customer Orders
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('My Orders'),
            onTap: () {
              // MySharedPrefencesSessionHandling
              //     .removeWhichUserLoggedInFromSharedPreferences();

              // FirebaseAuth.instance.signOut();
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CustomerOrdersWithShopTabBar()));
              // navigatorKey.currentState!.popUntil((route) => route.isFirst);
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
