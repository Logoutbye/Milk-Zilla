import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:milk_zilla/View/Buyer_UI/Customer%20Orders%20With%20Shop/customer_orders_with_shop.dart';
import 'package:milk_zilla/View/Inspector_UI/Inspector_profile.dart';
import 'package:milk_zilla/View/Inspector_UI/insector_screen.dart';
import 'package:milk_zilla/View/my_home_page.dart';
import 'package:milk_zilla/main.dart';
import 'package:milk_zilla/res/Components/my_drawers/buyer_drawer.dart';
import 'package:milk_zilla/res/Components/my_shared_prefrences.dart';

class InspectorDrawer extends StatefulWidget {
  InspectorDrawer({super.key});

  @override
  State<InspectorDrawer> createState() => _InspectorDrawerState();
}

class _InspectorDrawerState extends State<InspectorDrawer> {
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
            title: const Text('My Profile'),
            onTap: () {
              // MySharedPrefencesSessionHandling
              //     .removeWhichUserLoggedInFromSharedPreferences();

              // FirebaseAuth.instance.signOut();
              Navigator.pop(context);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => InspectorProfile()));
              // navigatorKey.currentState!.popUntil((route) => route.isFirst);
            },
          ),
          // Customer Orders
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('My Orders'),
            onTap: () {
              // MySharedPrefencesSessionHandling
              //     .removeWhichUserLoggedInFromSharedPreferences();

              // FirebaseAuth.instance.signOut();
              Navigator.pop(context);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => InspectorScreen()));
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
