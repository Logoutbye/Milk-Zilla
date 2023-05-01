import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/Utils/utils.dart';
import 'package:milk_zilla/View/Auth%20UI/login_screen.dart';
import 'package:milk_zilla/View/Auth%20UI/registration_screen.dart';
import 'package:milk_zilla/View/Auth%20UI/registration_status_screen.dart';
import 'package:milk_zilla/View/Buyer_UI/all_shops_to_order_from.dart';
import 'package:milk_zilla/View/Buyer_UI/buyer_screen.dart';
import 'package:milk_zilla/View/Inspector_UI/insector_screen.dart';
import 'package:milk_zilla/View/Seller_UI/seller_screen.dart';
import 'package:milk_zilla/main.dart';
import 'package:milk_zilla/res/Components/firebase_helper.dart';
import 'package:milk_zilla/res/Components/my_shared_prefrences.dart';
import 'package:milk_zilla/res/my_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../res/Components/error_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var whichUserLoggedIn;

  @override
  void initState() {
    FirestoreHelper.initializeToCheckStatusForSellers();
    FirestoreHelper.initializeToCheckStatusForInspector();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(),
      ),
      //  AppBar(
      //   title: Text('Milk Zilla'),
      // backgroundColor: MyColors.kSecondary,
      // foregroundColor: MyColors.kPrimary,
      // elevation: 0,
      // centerTitle: true ,
      // ),
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            return Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter:
                      ColorFilter.mode(MyColors.kBlack, BlendMode.softLight),
                  image: AssetImage("assets/images/bg.jpeg"),
                  fit: BoxFit.fill,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // some space
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 120,
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Center(
                      child: Container(
                        child: Column(
                          children: [
                            // first two buttons for registration
                            Container(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                // row for two buttons
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    //register as customer
                                    InkWell(
                                      onTap: () async {
                                        //to get current user type
                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        whichUserLoggedIn = prefs
                                            .getString('whichUserLoggedIn');

                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                              child: Lottie.asset(
                                                  'assets/animations/loading.json',
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      5),
                                            );
                                          } else if (snapshot.hasError) {
                                            print(snapshot);
                                            return Utils.flushBarErrorMessage(
                                                'Some thing went wrong',
                                                context);
                                          } else if (snapshot.hasData) {
                                            if (whichUserLoggedIn == 'Buyer') {
                                              return AllShopesToOrderFrom();
                                            } else {
                                              return ErrorScreen(
                                                  Message:
                                                      'Please Logout as ${whichUserLoggedIn} first',
                                                  onpress: () async {
                                                    // SignOut();
                                                  },
                                                  butontitle: 'Log Out');
                                            }
                                          } else {
                                            return LoginScreen(
                                              whichUser: 'Buyer',
                                            );
                                          }
                                        }));
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.4,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        decoration: BoxDecoration(
                                          color: MyColors.kSecondary,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: MyColors.kBlack,
                                              blurRadius: 15,
                                              spreadRadius: 2,
                                              offset: Offset(
                                                0,
                                                5,
                                              ), // Shadow position
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ImageIcon(
                                                AssetImage(
                                                    "assets/images/shopping-cart.png"),
                                                size: 72,
                                                color: MyColors.kPrimary,
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    70,
                                              ),
                                              Text(
                                                'Buy',
                                                style: TextStyle(
                                                    color: MyColors.kPrimary,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),

                                    // seller
                                    InkWell(
                                      onTap: () async {
                                        //to get current user type
                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        whichUserLoggedIn = prefs
                                            .getString('whichUserLoggedIn');

                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                              child: Lottie.asset(
                                                  'assets/animations/loading.json',
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      5),
                                            );
                                          } else if (snapshot.hasError) {
                                            return Utils.flushBarErrorMessage(
                                                'Some thing went wrong',
                                                context);
                                          } else if (snapshot.hasData) {
                                            if (whichUserLoggedIn == 'Seller') {
                                              if (FirestoreHelper
                                                      .currentSellerStatusInFirestore ==
                                                  'Approved') {
                                                return InspectorScreen();
                                              } else {
                                                return RegistrationStatusScreen(
                                                  whichUser: 'Seller',
                                                );
                                              }
                                            } else {
                                              return ErrorScreen(
                                                  Message:
                                                      'Please Logout as ${whichUserLoggedIn} first',
                                                  onpress: () async {
                                                    //  SignOut();
                                                  },
                                                  butontitle: 'Log Out');
                                            }
                                          } else {
                                            return LoginScreen(
                                              whichUser: 'Seller',
                                            );
                                          }
                                        }));
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.4,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        decoration: BoxDecoration(
                                          color: MyColors.kSecondary,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: MyColors.kBlack,
                                              blurRadius: 15,
                                              spreadRadius: 2,
                                              offset: Offset(
                                                0,
                                                5,
                                              ), // Shadow position
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ImageIcon(
                                                AssetImage(
                                                    "assets/images/seller.png"),
                                                size: 72,
                                                color: MyColors.kPrimary,
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    70,
                                              ),
                                              Text('Sell',
                                                  style: TextStyle(
                                                      color: MyColors.kPrimary,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ), // container for chating Doctor will move to next screen

                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    // Inpector
                    Center(
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),

                                    InkWell(
                                      onTap: () async {
                                        //to get current user type
                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        whichUserLoggedIn = prefs
                                            .getString('whichUserLoggedIn');

                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                              child: Lottie.asset(
                                                  'assets/animations/loading.json',
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      5),
                                            );
                                          } else if (snapshot.hasError) {
                                            return Utils.flushBarErrorMessage(
                                                'Some thing went wrong',
                                                context);
                                          } else if (snapshot.hasData) {
                                            if (whichUserLoggedIn ==
                                                'Inspector') {
                                              if (FirestoreHelper
                                                      .currentInspectorStatusInFirestore ==
                                                  'Approved') {
                                                return InspectorScreen();
                                              } else {
                                                return RegistrationStatusScreen(
                                                  whichUser: 'Inspector',
                                                );
                                              }
                                            } else {
                                              return ErrorScreen(
                                                  Message:
                                                      'Please Logout as ${whichUserLoggedIn} first',
                                                  onpress: () async {
                                                    // SignOut();
                                                  },
                                                  butontitle: 'Log Out');
                                            }
                                          } else {
                                            return LoginScreen(
                                              whichUser: 'Inspector',
                                            );
                                          }
                                        }));
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.4,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        decoration: BoxDecoration(
                                          color: MyColors.kSecondary,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 15,
                                              spreadRadius: 2,
                                              offset: Offset(
                                                0,
                                                5,
                                              ), // Shadow position
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ImageIcon(
                                                AssetImage(
                                                    "assets/images/inspector.png"),
                                                size: 72,
                                                color: MyColors.kPrimary,
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    70,
                                              ),
                                              Text('Inspect',
                                                  style: TextStyle(
                                                      color: MyColors.kPrimary,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ), // container for chating Doctor will move to next screen
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 50,
                    ),
                    // About US Area
                  ],
                ),
              ),
            );
          }),
    );
  }

  // Future<void> SignOut() async {
  //   await FirebaseAuth.instance.signOut();
  //   await MySharedPrefencesSessionHandling
  //       .removeWhichUserLoggedInFromSharedPreferences();
  //   // final prefs = await SharedPreferences.getInstance();
  //   // await prefs.remove('whichUserLoggedIn');
  //   navigatorKey.currentState!.popUntil((route) => route.isFirst);
  // }
}
