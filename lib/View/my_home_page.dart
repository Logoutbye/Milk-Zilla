import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/Utils/utils.dart';
import 'package:milk_zilla/View/Auth%20UI/login.dart';
import 'package:milk_zilla/View/Auth%20UI/registration_screen.dart';
import 'package:milk_zilla/View/Buyer_UI/buyer_screen.dart';

import 'package:milk_zilla/res/my_colors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Lottie.asset(
                                                'assets/animations/loading.json');
                                          } else if (snapshot.hasError) {
                                            return Utils.flushBarErrorMessage(
                                                'Some thing went wrong',
                                                context);
                                          } else if (snapshot.hasData) {
                                            return BuyerScreen();
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
                                    ), // container for chating Doctor will move to next screen
                                    SizedBox(
                                      width: 15,
                                    ),

                                    // View Hospitals Container and Button
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return LoginScreen(
                                            whichUser: 'Seller',
                                          );
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

                    // Pets Market and Share App Buttons
                    Center(
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                // Row containing Pets Market and Share App Buttons
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),

                                    // Pets Market Button
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return LoginScreen(
                                            whichUser: 'Inspector',
                                          );
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
}
