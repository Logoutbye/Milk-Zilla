import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:milk_zilla/View/Auth%20UI/registration_status.dart';
import 'package:milk_zilla/View/Buyer_UI/buyer_screen.dart';
import 'package:milk_zilla/View/Inspector_UI/insector_screen.dart';
import 'package:milk_zilla/View/Seller_UI/seller_screen.dart';
import 'package:milk_zilla/provider/Sopping_item_provider.dart';
import 'package:milk_zilla/res/Components/firebase_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'View/my_home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  //Shared Preferences to navigate to the module where last time user logged in
  final prefs = await SharedPreferences.getInstance();
  var whichUserLoggedIn = prefs.getString('whichUserLoggedIn');
  print('whichUserLoggedIn in sharedPrefrences:: $whichUserLoggedIn');

  // and if user was seller or inspector it will check if the status is approved so he may navigate to their relative dashbord else they see application status
  await FirestoreHelper.initializeToCheckStatusForSellers();
  await FirestoreHelper.initializeToCheckStatusForInspector();

  await FirestoreHelper.currentSellerStatusInFirestore;
  await FirestoreHelper.currentInspectorStatusInFirestore;
  print(
      'in main currentSellerStatusInFirestore :${FirestoreHelper.currentSellerStatusInFirestore}');
  print(
      'in maincurrentInspectorStatusInFirestore :${FirestoreHelper.currentInspectorStatusInFirestore}');

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
        'before navigation currentSellerStatusInFirestore :${FirestoreHelper.currentSellerStatusInFirestore}');
    print(
        'before navigation currentInspectorStatusInFirestore :${FirestoreHelper.currentInspectorStatusInFirestore}');
    return ChangeNotifierProvider(
      create: (_) => ShoppingItemProvider(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Milk Zilla',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home:
            //if user is buyer and approved
            whichUserLoggedIn == 'Buyer'
                ? BuyerScreen()

                //if user is seller and approved
                : whichUserLoggedIn == 'Seller' &&
                        FirestoreHelper.currentSellerStatusInFirestore ==
                            'Approved'
                    ? SellerScreen()
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
                            ? InspectorScreen()

                            //if user is Seller and is not approved
                            : whichUserLoggedIn == 'Inspector' &&
                                    FirestoreHelper
                                            .currentInspectorStatusInFirestore ==
                                        'Pending'
                                ? RegistrationStatusScreen(
                                    whichUser: 'Inspector',
                                  )
                                : MyHomePage(),
      ),
    );
  }
}
