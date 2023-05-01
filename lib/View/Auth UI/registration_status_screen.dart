import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/View/Inspector_UI/insector_screen.dart';
import 'package:milk_zilla/View/my_home_page.dart';
import 'package:milk_zilla/controllers/registration_status_controller.dart';
import 'package:milk_zilla/res/Components/my_shared_prefrences.dart';
import 'package:milk_zilla/res/Components/round_button.dart';
import 'package:milk_zilla/res/my_colors.dart';

import '../../Model/seller_model.dart';
import '../Seller_UI/Customer Orders/customers_orders.dart';

class RegistrationStatusScreen extends StatefulWidget {
  String whichUser;

  RegistrationStatusScreen({required this.whichUser, super.key});

  @override
  State<RegistrationStatusScreen> createState() =>
      _RegistrationStatusScreenState();
}

class _RegistrationStatusScreenState extends State<RegistrationStatusScreen> {
  final user = FirebaseAuth.instance.currentUser;
  var whichUser;

  @override
  void initState() {
    whichUser = widget.whichUser;
    print('email::${user!.email}');
    // TODO: implement initState
    super.initState();
  }

  RegistrationStatusController registrationStatusController =RegistrationStatusController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        // extendBody: true,
        // extendBodyBehindAppBar: true,

        
        body: FutureBuilder(
            future:registrationStatusController.readSellerDataFromDatabase(whichUser,user),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Lottie.asset('assets/animations/loading.json',
                        height: MediaQuery.of(context).size.height / 5));
              } else if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      snapshot.data!.status != 'Pending'
                          ? Text(
                              "Application Approved",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Text(
                              "Application",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      const SizedBox(height: 30.0),
                      snapshot.data!.status != 'Pending'
                          ? Container(
                              child: Center(
                                child: Lottie.asset(
                                    'assets/animations/congo.json',
                                    height:
                                        MediaQuery.of(context).size.height / 5),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: MyColors.kSecondary,
                                border: Border.all(
                                  color: MyColors.kPrimary,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              // height: MediaQuery.of(context).size.height / 19,
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Padding(
                                  padding: const EdgeInsets.all(28.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                border: Border.all(
                                                  color: MyColors.kPrimary,
                                                  width: 1.0,
                                                ),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  bottomLeft:
                                                      Radius.circular(15),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Status',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                          const SizedBox(width: 10.0),
                                          Container(
                                              decoration: BoxDecoration(
                                                color: MyColors.kPrimary,
                                                border: Border.all(
                                                  color: MyColors.kSecondary,
                                                  width: 1.0,
                                                ),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(15),
                                                ),
                                              ),
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      '${snapshot.data!.status}',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold)))),
                                        ],
                                      ),
                                      const SizedBox(height: 10.0),
                                      _buildDivider(),
                                      _buildDivider(),
                                      const SizedBox(height: 10.0),
                                      Text('Details',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 10.0),
                                      _buildDivider(),
                                      _buildDivider(),
                                      const SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          Text('Name'),
                                          Spacer(),
                                          Text('${snapshot.data!.name}'),
                                        ],
                                      ),
                                      const SizedBox(height: 10.0),
                                      _buildDivider(),
                                      const SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          Text('Email'),
                                          Spacer(),
                                          Text('${snapshot.data!.email}'),
                                        ],
                                      ),
                                      const SizedBox(height: 10.0),
                                      _buildDivider(),
                                      const SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          Text('Mobile Number'),
                                          Spacer(),
                                          Text('${snapshot.data!.mobile_no}'),
                                        ],
                                      ),
                                      const SizedBox(height: 10.0),
                                      _buildDivider(),
                                      const SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          Text('City'),
                                          Spacer(),
                                          Text('${snapshot.data!.city}'),
                                        ],
                                      ),
                                      const SizedBox(height: 10.0),
                                      _buildDivider(),
                                      const SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          whichUser == 'Seller'
                                              ? Text('Shop Name')
                                              : Text('Your Adress'),
                                          Spacer(),
                                          whichUser == 'Seller'
                                              ? Text(
                                                  '${snapshot.data!.shop_name}')
                                              : Text(
                                                  '${snapshot.data!.inspector_adress}'),
                                        ],
                                      ),
                                      whichUser == 'Seller'
                                          ? const SizedBox(height: 10.0)
                                          : SizedBox(),
                                      whichUser == 'Seller'
                                          ? _buildDivider()
                                          : SizedBox(),
                                      whichUser == 'Seller'
                                          ? const SizedBox(height: 10.0)
                                          : SizedBox(),
                                      whichUser == 'Seller'
                                          ? Row(
                                              children: [
                                                Text('Shop Adress'),
                                                Spacer(),
                                                Text(
                                                    '${snapshot.data!.shop_adress}'),
                                              ],
                                            )
                                          : SizedBox(),
                                    ],
                                  ))),
                      SizedBox(height: 30.0),
                      snapshot.data!.status != 'Pending'
                          ? MyElevatedButton(
                              title: 'Continue',
                              onpress: () {
                                MySharedPrefencesSessionHandling
                                    .setOrupdateWhichUserLoggedInSharedPreferences(
                                        '${whichUser}');
                                if (whichUser == 'Seller') {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MyAllCustomerOrders()));
                                } else {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InspectorScreen()));
                                }
                              })
                          : MyElevatedButton(
                              title: 'Home',
                              onpress: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage()));
                              },
                            )
                    ],
                  ),
                );
              } else {
                return Center(
                    child: Text('Something went wrong! Try again later.'));
              }
            }));
  }

  Container _buildDivider() {
    return Container(
      height: 2.0,
      width: MediaQuery.of(context).size.width / 1,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }

  // Future<SellerOrInspectorModel?> readSellerDataFromDatabase() async {
  //   if (whichUser == 'Seller') {
  //     final docPrices = FirebaseFirestore.instance
  //         .collection('Sellers')
  //         .doc('${user!.email}');
  //     final snapshot = await docPrices.get();

  //     if (snapshot.exists) {
  //       return SellerOrInspectorModel.fromJson(snapshot.data()!);
  //     }
  //   } else {
  //     final docPrices = FirebaseFirestore.instance
  //         .collection('Inspectors')
  //         .doc('${user!.email}');
  //     final snapshot = await docPrices.get();

  //     if (snapshot.exists) {
  //       return SellerOrInspectorModel.fromJson(snapshot.data()!);
  //     }
  //   }
  // }


}
