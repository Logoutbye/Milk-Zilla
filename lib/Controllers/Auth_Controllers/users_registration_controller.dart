import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../Utils/utils.dart';
import '../../View/Auth UI/registration_status_screen.dart';
import '../../View/Buyer_UI/all_shops_to_order_from.dart';
import '../../View/Inspector_UI/insector_screen.dart';
import '../../View/Seller_UI/Customer Orders/customers_orders.dart';
import '../../res/Components/firebase_helper.dart';
import '../../res/Components/my_shared_prefrences.dart';

class UserRegistrationController {
  Future FirebaseRegistration(
    BuildContext parentContext,
    var whichUser,
    var emailTextController,
    var PasswordTextController,
    var mobileNumberTextController,
    var cityTextControl,
    var nameTextControl,
    var buyerOrinspectorOrShopAdressTextControl,
    var shopNameTextControl,
  ) async {
    showDialog(
        context: parentContext,
        barrierDismissible: false,
        builder: (context) => Center(
              child: Lottie.asset('assets/animations/loading.json',
                  height: MediaQuery.of(context).size.height / 5),
            ));
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailTextController.text.trim(),
              password: PasswordTextController.text.trim())
          .then((UserCredential user_credentials) async {
        Navigator.of(parentContext).pop();
        createUserInFirebase(
            parentContext,
            whichUser,
            emailTextController,
            PasswordTextController,
            mobileNumberTextController,
            cityTextControl,
            nameTextControl,
            buyerOrinspectorOrShopAdressTextControl,
            shopNameTextControl);
        if (whichUser == 'Buyer') {
          MySharedPrefencesSessionHandling
              .setOrupdateWhichUserLoggedInSharedPreferences('${whichUser}');
          Navigator.of(parentContext).push(
              MaterialPageRoute(builder: (context) => AllShopesToOrderFrom()));
          emailTextController.clear();
          PasswordTextController.clear();
          mobileNumberTextController.clear();
          cityTextControl.clear();
          emailTextController.clear();
          nameTextControl.clear();
          buyerOrinspectorOrShopAdressTextControl.clear();
          shopNameTextControl.clear();
        } else if (whichUser == 'Seller') {
          MySharedPrefencesSessionHandling
              .setOrupdateWhichUserLoggedInSharedPreferences('${whichUser}');

          //get the approval status as soon as the user is created and navigate to relavent screen
          await FirestoreHelper.initializeToCheckStatusForSellers();
          await FirestoreHelper.initializeToCheckStatusForInspector();

          var currentInspectorStatusInFirestore =
              await FirestoreHelper.currentInspectorStatusInFirestore;

          if (currentInspectorStatusInFirestore == 'Approved') {
            Navigator.of(parentContext).push(
                MaterialPageRoute(builder: (context) => InspectorScreen()));
          } else {
            Navigator.of(parentContext).push(MaterialPageRoute(
                builder: (context) => RegistrationStatusScreen(
                      whichUser: whichUser,
                    )));
          }
          emailTextController.clear();
          PasswordTextController.clear();
          mobileNumberTextController.clear();
          cityTextControl.clear();
          emailTextController.clear();
          nameTextControl.clear();
          buyerOrinspectorOrShopAdressTextControl.clear();
          shopNameTextControl.clear();
        } else {
          //update the value in shared prefrences so that next time it may navigate to relavent screen
          MySharedPrefencesSessionHandling
              .setOrupdateWhichUserLoggedInSharedPreferences('${whichUser}');

          //get the approval status as soon as the user is created and navigate to relavent screen
          await FirestoreHelper.initializeToCheckStatusForSellers();
          await FirestoreHelper.initializeToCheckStatusForInspector();
          var currentSellerStatusInFirestore =
              await FirestoreHelper.currentSellerStatusInFirestore;

          if (currentSellerStatusInFirestore == 'Approved') {
            Navigator.of(parentContext).push(
                MaterialPageRoute(builder: (context) => MyAllCustomerOrders()));
          } else {
            Navigator.of(parentContext).push(MaterialPageRoute(
                builder: (context) => RegistrationStatusScreen(
                      whichUser: whichUser,
                    )));
          }

          emailTextController.clear();
          PasswordTextController.clear();
          mobileNumberTextController.clear();
          cityTextControl.clear();
          emailTextController.clear();
          nameTextControl.clear();
          buyerOrinspectorOrShopAdressTextControl.clear();
          shopNameTextControl.clear();
        }
      }).onError((FirebaseAuthException error, stackTrace) {
        if (error.code == "email-already-in-use") {
          print("The email address is already in use by another account");
          Utils.toastMessage(
              "The email address is already in use by another account");
          Navigator.of(parentContext).pop();
        } else {
          Utils.toastMessage(error.toString());
          Navigator.of(parentContext).pop();
        }
      });
    } on FirebaseAuthException catch (e) {
      print('Khan${e.toString()}');
      Utils.toastMessage(e.toString());
      Navigator.of(parentContext).pop();
      emailTextController.clear();
      PasswordTextController.clear();
      mobileNumberTextController.clear();
      cityTextControl.clear();
      emailTextController.clear();
      nameTextControl.clear();
      buyerOrinspectorOrShopAdressTextControl.clear();
      shopNameTextControl.clear();
    }
  }
}

Future createUserInFirebase(
  BuildContext parentContext,
  var whichUser,
  var emailTextController,
  var PasswordTextController,
  var mobileNumberTextController,
  var cityTextControl,
  var nameTextControl,
  var buyerOrinspectorOrShopAdressTextControl,
  var shopNameTextControl,
) async {
  //Refrence to document
  final buyer = FirebaseFirestore.instance
      .collection('Buyers')
      .doc('${emailTextController.text}');
  final seller = FirebaseFirestore.instance
      .collection('Sellers')
      .doc('${emailTextController.text}');
  final inpector = FirebaseFirestore.instance
      .collection('Inspectors')
      .doc('${emailTextController.text}');

  final jsonForBuyer = {
    'name': nameTextControl.text,
    'mobile_no': mobileNumberTextController.text,
    'city': cityTextControl.text,
    'email': emailTextController.text,
    'password': PasswordTextController.text,
    'inspector_adress': buyerOrinspectorOrShopAdressTextControl.text,
  };
  final jsonForSeller = {
    'name': nameTextControl.text,
    'mobile_no': mobileNumberTextController.text,
    'city': cityTextControl.text,
    'shop_name': shopNameTextControl.text,
    'shop_adress': buyerOrinspectorOrShopAdressTextControl.text,
    'email': emailTextController.text,
    'password': PasswordTextController.text,
    'status': 'Pending'
  };
  final jsonForInspector = {
    'name': nameTextControl.text,
    'mobile_no': mobileNumberTextController.text,
    'city': cityTextControl.text,
    'email': emailTextController.text,
    'password': PasswordTextController.text,
    'inspector_adress': buyerOrinspectorOrShopAdressTextControl.text,
    'status': 'Pending'
  };
  //create document and write data to firebase
  if (whichUser == 'Buyer') {
    await buyer.set(jsonForBuyer);
  } else if (whichUser == 'Seller') {
    await seller.set(jsonForSeller);
  } else {
    await inpector.set(jsonForInspector);
  }
}