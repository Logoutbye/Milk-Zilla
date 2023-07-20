import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:milk_zilla/View/Farm_UI/farm_orders.dart';
import 'package:milk_zilla/View/my_home_page.dart';
import 'package:milk_zilla/res/Components/my_shared_prefrences.dart';

class FarmDrawer extends StatefulWidget {
  FarmDrawer({super.key});

  @override
  State<FarmDrawer> createState() => _FarmDrawerState();
}

class _FarmDrawerState extends State<FarmDrawer> {
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
          //   title: const Text('My Profile'),
          //   onTap: () {
          //     // MySharedPrefencesSessionHandling
          //     //     .removeWhichUserLoggedInFromSharedPreferences();

          //     // FirebaseAuth.instance.signOut();
          //     Navigator.pop(context);
          //     Navigator.of(context).push(
          //         MaterialPageRoute(builder: (context) => BuyerProfile()));
          //     // navigatorKey.currentState!.popUntil((route) => route.isFirst);
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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => FarmOrders()));
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
