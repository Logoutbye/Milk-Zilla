import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:milk_zilla/View/Inspector_UI/Test%20Milk/test_milk_screen_tab_bar.dart';
import 'package:milk_zilla/View/Inspector_UI/inspector_dashboard.dart';
import 'package:milk_zilla/View/my_home_page.dart';
import 'package:milk_zilla/res/Components/my_shared_prefrences.dart';

import '../../../View/Inspector_UI/Pick Orders/inspector_screen.dart';

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

          // Test Milk
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => InspectorDashboard()));
              // navigatorKey.currentState!.popUntil((route) => route.isFirst);
            },
          ),
          // // Customer Orders
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Pick Orders'),
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

          // Test Milk
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Test Milk For Farm'),
            onTap: () {
              // MySharedPrefencesSessionHandling
              //     .removeWhichUserLoggedInFromSharedPreferences();

              // FirebaseAuth.instance.signOut();
              Navigator.pop(context);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TestMilkScreenTabbar()));
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
