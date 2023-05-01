
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:milk_zilla/res/Components/my_drawer.dart';
import 'package:milk_zilla/res/Components/round_button.dart';

import '../../main.dart';
import '../constanst.dart';
import '../my_colors.dart';
import 'my_shared_prefrences.dart';

class ErrorScreen extends StatelessWidget {
  final String Message;
  final VoidCallback onpress;
  var butontitle;
  ErrorScreen({
    super.key,
    required this.Message,
    required this.onpress,
    required this.butontitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, actions: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Builder(
                builder: (context) => IconButton(
                      icon: Icon(Icons.settings),
                      iconSize: 40,
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                    )))
      ]),
      endDrawer: MyAppDrawer(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Message,
              style: kTextStyleBlack.copyWith(color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            MyElevatedButton(
                title: butontitle,
                onpress: () async {
                  onpress;
                  SignOut();
                })
          ],
        ),
      ),
    );
  }

  Future<void> SignOut() async {
    await FirebaseAuth.instance.signOut();
    await MySharedPrefencesSessionHandling
        .removeWhichUserLoggedInFromSharedPreferences();
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.remove('whichUserLoggedIn');
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

class MyStaticComponents {
  // static ErrorHandling(BuildContext context, String Message, String butontitle,
  //     VoidCallback onpress) {
  //   return Scaffold(
  //     body: Center(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Text(
  //             Message,
  //             style: priceTextStyle.copyWith(color: Colors.black),
  //           ),
  //           SizedBox(height: 20,),
  //           MyElevatedButton(
  //               title: butontitle,
  //               onpress: () {
  //                 onpress;
  //               })
  //         ],
  //       ),
  //     ),
  //   );
  // }

  static myAppDialogBox(BuildContext context, String title, String content) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: MyColors.kSecondary,
            title: Center(child: Text(title.toString())),
            content: SelectableText(
              content.toString(),
              showCursor: true,
              textAlign: TextAlign.center,
              //toolbarOptions:
              // ToolbarOptions(copy: true),
            ),
            //actionsAlignment: MainAxisAlignment.center,

            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Container(
                  child: Text(
                    'Cancel',
                    //style: TextStyle(color: MyColors.kSecondary),
                  ),
                ),
              ),
            ],
          );
        });
  }

//This code generates an order number by concatenating the current timestamp (in milliseconds) with a random 3-digit number. You can call this function each time an order is placed to generate a unique order number.
  static String generateOrderNumber() {
    // Get the current timestamp
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    // Generate a random number
    int randNum = Random().nextInt(900) + 100;
    // Combine the timestamp and random number to create a unique order number
    String orderNum = timestamp.toString() + randNum.toString();
    return orderNum;
  }
}
