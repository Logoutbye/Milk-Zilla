import 'package:firebase_auth/firebase_auth.dart';
// import 'package:dcdg/dcdg.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:milk_zilla/View/Auth%20UI/registration_status_screen.dart';
import 'package:milk_zilla/View/Buyer_UI/all_shops_to_order_from.dart';
import 'package:milk_zilla/View/Buyer_UI/set_customer_address_on_google_map.dart';
import 'package:milk_zilla/View/Farm_UI/farm_orders.dart';

import 'package:milk_zilla/provider/Sopping_item_provider.dart';
import 'package:milk_zilla/res/Components/firebase_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'View/Inspector_UI/inspector_dashboard.dart';
import 'View/Seller_UI/seller_dashboard.dart';
import 'View/Seller_UI/set_seller_location_on_google_map.dart';
import 'View/my_home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  //Shared Preferences to navigate to the module where last time user logged in
  final prefs = await SharedPreferences.getInstance();
  var whichUserLoggedIn = prefs.getString('whichUserLoggedIn');
  print('whichUserLoggedIn in sharedPrefrences:: $whichUserLoggedIn');

  //getting current login user if if there is no one it will not check
  // it so the delay beacuse of initilization  will be minimum
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final email = user.email;
    print('email::${email}');
    // and if user was seller or inspector it will check if the status is approved so he may navigate to their relative dashbord else they see application status
    if (whichUserLoggedIn == 'Seller') {
      await FirestoreHelper.initializeToCheckStatusForSellers();
      await FirestoreHelper.currentSellerStatusInFirestore;
    } else if (whichUserLoggedIn == 'Inspector') {
      await FirestoreHelper.initializeToCheckStatusForInspector();
      await FirestoreHelper.currentInspectorStatusInFirestore;
    } else if (whichUserLoggedIn == 'Farmer') {
      await FirestoreHelper.initializeToCheckStatusForFarmer();
      await FirestoreHelper.currentFarmerStatusInFirestore;
    }

    print(
        'in main currentFarmerStatusInFirestore :${FirestoreHelper.currentFarmerStatusInFirestore}');
    print(
        'in main currentSellerStatusInFirestore :${FirestoreHelper.currentSellerStatusInFirestore}');
    print(
        'in maincurrentInspectorStatusInFirestore :${FirestoreHelper.currentInspectorStatusInFirestore}');
  }

  runApp(MyApp(
    whichUserLoggedIn: whichUserLoggedIn,
  ));
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  var whichUserLoggedIn;

  MyApp({required this.whichUserLoggedIn, super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(
        'before navigation currentFarmerStatusInFirestore :${FirestoreHelper.currentFarmerStatusInFirestore}');
    print(
        'before navigation currentSellerStatusInFirestore :${FirestoreHelper.currentSellerStatusInFirestore}');
    print(
        'before navigation currentInspectorStatusInFirestore :${FirestoreHelper.currentInspectorStatusInFirestore}');
    return ChangeNotifierProvider(
      create: (_) => ShoppingItemProvider(),
      child: MaterialApp(
        routes: {
          '/setCustomerAddressOnGoogleMap': (context) =>
              SetCuctomerAddressOnGoogleMap(),
          '/setSellerAddressOnGoogleMap': (context) =>
              SetSellerLocationOnGoogleMap(),
        },
        navigatorKey: navigatorKey,
        title: 'Milk Zilla',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home:
            // if user is buyer and aboviously approved
            whichUserLoggedIn == 'Buyer'
                ? AllShopesToOrderFrom()

                //if user is seller and approved
                : whichUserLoggedIn == 'Seller' &&
                        FirestoreHelper.currentSellerStatusInFirestore ==
                            'Approved'
                    ? SellerDashboard()

                    //if user is Seller and is not approved
                    : whichUserLoggedIn == 'Seller' &&
                            FirestoreHelper.currentSellerStatusInFirestore ==
                                'Pending'
                        ? RegistrationStatusScreen(
                            whichUser: 'Seller',
                          )

                        //if user is Inspector and approved
                        : whichUserLoggedIn == 'Inspector' &&
                                FirestoreHelper
                                        .currentInspectorStatusInFirestore ==
                                    'Approved'
                            ? InspectorDashboard()

                            //if user is Inspector and is not approved
                            : whichUserLoggedIn == 'Inspector' &&
                                    FirestoreHelper
                                            .currentInspectorStatusInFirestore ==
                                        'Pending'
                                ? RegistrationStatusScreen(
                                    whichUser: 'Inspector',
                                  )

                                //if user is Farmer and is approved
                                : whichUserLoggedIn == 'Farmer' &&
                                        FirestoreHelper
                                                .currentFarmerStatusInFirestore ==
                                            'Approved'
                                    ? FarmOrders()

                                    //if user is Farmer and is not approved
                                    : whichUserLoggedIn == 'Farmer' &&
                                            FirestoreHelper
                                                    .currentFarmerStatusInFirestore ==
                                                'Pending'
                                        ? RegistrationStatusScreen(
                                            whichUser: 'Farmer',
                                          )
                                        : MyHomePage(),
      ),
    );
  }
}
