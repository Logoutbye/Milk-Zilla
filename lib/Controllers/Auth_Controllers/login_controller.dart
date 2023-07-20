import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/View/Farm_UI/farm_orders.dart';
import 'package:milk_zilla/View/Inspector_UI/inspector_dashboard.dart';
import 'package:milk_zilla/main.dart';

import '../../Utils/utils.dart';
import '../../View/Auth UI/registration_status_screen.dart';
import '../../View/Buyer_UI/all_shops_to_order_from.dart';
import '../../View/Seller_UI/seller_dashboard.dart';
import '../../res/Components/firebase_helper.dart';
import '../../res/Components/my_shared_prefrences.dart';

class LoginController {
  Future FirebaseLogin(BuildContext parentContext, var email, var password,
      var whichUser) async {
    showDialog(
        context: parentContext,
        barrierDismissible: true,
        builder: (context) => Center(
              child: Lottie.asset('assets/animations/loading.json',
                  height: MediaQuery.of(context).size.height / 5),
            ));
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim()
              //  emailTextController.text.trim(),
              //  PasswordTextController.text.trim()
              )
          .then((UserCredential user_credentials) async {
        email.clear();
        password.clear();

        // emailTextController.clear();
        // PasswordTextController.clear();

        Navigator.of(parentContext).pop();

        //if login is successfull then store the user type for next time user opens app and navigation to relvant screen
        MySharedPrefencesSessionHandling
            .setOrupdateWhichUserLoggedInSharedPreferences('${whichUser}');
        print('trying to store in shared prefrences ${whichUser}');

        await FirestoreHelper.initializeToCheckStatusForSellers();
        await FirestoreHelper.initializeToCheckStatusForInspector();
        await FirestoreHelper.initializeToCheckStatusForFarmer();

        var currentSellerStatusInFirestore =
            await FirestoreHelper.currentSellerStatusInFirestore;
        print(
            'checking currentUserStatusInFirestore at login success::$currentSellerStatusInFirestore');

        var currentFarmerStatusInFirestore =
            await FirestoreHelper.currentFarmerStatusInFirestore;
        print(
            'checking currentFarmerStatusInFirestore at login success::$currentFarmerStatusInFirestore');

        var currentInspectorStatusInFirestore =
            await FirestoreHelper.currentInspectorStatusInFirestore;
        print(
            'checking currentUserStatusInFirestore at login success::$currentSellerStatusInFirestore');

        if (whichUser == 'Buyer') {
          navigatorKey.currentState!.popUntil((route) => route.isFirst);
          Navigator.of(parentContext).pushReplacement(
              MaterialPageRoute(builder: (context) => AllShopesToOrderFrom()));
        } else if (whichUser == 'Seller') {
          if (currentSellerStatusInFirestore == 'Approved') {
            navigatorKey.currentState!.popUntil((route) => route.isFirst);
            Navigator.of(parentContext).pushReplacement(
                MaterialPageRoute(builder: (context) => SellerDashboard()));
          } else {
            navigatorKey.currentState!.popUntil((route) => route.isFirst);
            print(
                'After successful login i am waiting to be approved as seller');
            Navigator.of(parentContext).pushReplacement(MaterialPageRoute(
                builder: (context) => RegistrationStatusScreen(
                      whichUser: whichUser,
                    )));
          }
        } else if (whichUser == 'Farmer') {
          if (currentFarmerStatusInFirestore == 'Approved') {
            navigatorKey.currentState!.popUntil((route) => route.isFirst);
            Navigator.of(parentContext).pushReplacement(
                MaterialPageRoute(builder: (context) => FarmOrders()));
          } else {
            navigatorKey.currentState!.popUntil((route) => route.isFirst);
            print(
                'After successful login i am waiting to be approved as seller');
            Navigator.of(parentContext).pushReplacement(MaterialPageRoute(
                builder: (context) => RegistrationStatusScreen(
                      whichUser: whichUser,
                    )));
          }
        } else {
          if (currentInspectorStatusInFirestore == 'Approved') {
            navigatorKey.currentState!.popUntil((route) => route.isFirst);
            Navigator.of(parentContext).pushReplacement(
                MaterialPageRoute(builder: (context) => InspectorDashboard()));
          } else {
            navigatorKey.currentState!.popUntil((route) => route.isFirst);
            print(
                'After successful login i am waiting to be approved as Inspector');
            Navigator.of(parentContext).pushReplacement(MaterialPageRoute(
                builder: (context) => RegistrationStatusScreen(
                      whichUser: whichUser,
                    )));
          }
        }
      }).onError((FirebaseAuthException error, stackTrace) {
        if (error.code == "wrong-password") {
          print("The password is invalid");
          Utils.toastMessage("The password is invalid");
          Navigator.of(parentContext).pop();
          email.clear();
          password.clear();

          // emailTextController.clear();
          // PasswordTextController.clear();
        } else {
          Utils.toastMessage(error.toString());
          Navigator.of(parentContext).pop();
          email.clear();
          password.clear();

          // emailTextController.clear();
          // PasswordTextController.clear();
        }
      });
    } on FirebaseAuthException catch (e) {
      print('Khan${e.toString()}');
      Utils.toastMessage(e.toString());
      Navigator.of(parentContext).pop();
      email.clear();
      password.clear();
      // emailTextController.clear();
      // PasswordTextController.clear();
    }
  }
}
