import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/Controllers/Buyer_Controllers/get_all_approved_shopes_with_specif_city_controller.dart';
import 'package:milk_zilla/Model/seller_model.dart';
import 'package:milk_zilla/View/Buyer_UI/Customer%20Orders%20With%20Shop/customer_orders_with_shop_tabbar.dart';
import 'package:milk_zilla/View/Buyer_UI/all_shops_addresses_on_google_map.dart';
import 'package:milk_zilla/View/Buyer_UI/review_cart.dart';

import 'package:milk_zilla/res/Components/my_drawers/buyer_drawer.dart';
import 'package:milk_zilla/res/my_colors.dart';

import '../../res/Components/custom_divider.dart';

class AllShopesToOrderFrom extends StatefulWidget {
  const AllShopesToOrderFrom({super.key});

  @override
  State<AllShopesToOrderFrom> createState() => _AllShopesToOrderFromState();
}

class _AllShopesToOrderFromState extends State<AllShopesToOrderFrom> {
  final user = FirebaseAuth.instance.currentUser;
  var getUserCity;

  List<LatLng> shopesLatLang = List.empty(growable: true);
  List<String> shopsNames = List.empty(growable: true);

  @override
  void initState() {
    getDataOfLoginedUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.kWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // backgroundColor: Color.fromARGB(255, 255, 255, 255),
        // foregroundColor: MyColors.kPrimary,
        elevation: 0,
        backgroundColor: MyColors.kWhite,
        foregroundColor: MyColors.kPrimary,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10.0),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  backgroundColor: MyColors.kPrimary,
                ),
                child: Text(
                  'My Orders',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CustomerOrdersWithShopTabBar()));
                },
              ),
            ),
          ],
        ),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: IconButton(
          //     icon: Icon(Icons.shopping_cart_checkout),
          //     iconSize: 35,
          //     onPressed: () {},
          //   ),
          // ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Builder(
                  builder: (context) => IconButton(
                        icon: Icon(Icons.settings),
                        iconSize: 40,
                        onPressed: () => Scaffold.of(context).openEndDrawer(),
                      )))
        ],
      ),
      endDrawer: BuyerDrawer(),
      body: FutureBuilder<List<SellerOrInspectorModel>>(
        future: GetAllApprovedShopeswithSpecifCityController()
            .getAllApprovedShopeswithSpecifCity(getUserCity),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Lottie.asset('assets/animations/loading.json',
                    height: MediaQuery.of(context).size.height / 5));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            List<SellerOrInspectorModel> shops = snapshot.data!;
            return ListView.builder(
              itemCount: shops.length,
              itemBuilder: (context, index) {
                print("Shopes Length: ${shops.length}");
                SellerOrInspectorModel shopes = shops[index];
                shopesLatLang.add(LatLng(shopes.lat, shopes.long));
                shopsNames.add(shopes.shop_name);
                // TODO: Build UI for each order
                return buildShopsUI(context, shopes);
              },
            );
          } else {
            return Text('No Shopes found');
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        //backgroundColor: MyColors.kSecondary,
        label: Text(
          'Shops near me',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AllShopsAddressesOnGoogleMap(
              shopesLatLang: shopesLatLang,
              shopNames: shopsNames,
            );
          }));
        },
      ),
    );
  }

  // to get current user name customer id
  Future getDataOfLoginedUser() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // get document reference
    DocumentReference documentReference =
        firestore.collection('Buyers').doc('${user!.email}');
    // get document snapshot
    DocumentSnapshot documentSnapshot = await documentReference.get();
    // check if document exists
    if (documentSnapshot.exists) {
      // get document data
      Map<String, dynamic>? data =
          documentSnapshot.data() as Map<String, dynamic>?;
      // access specific fields
      String user_city = data!['city'];
      print('user_city${user_city}');
      getUserCity = user_city;
      print('getUserCity:$getUserCity');
    }
  }

  Widget buildShopsUI(BuildContext context, SellerOrInspectorModel shops) {
    var heightbetweenWidgetsInOrder = MediaQuery.of(context).size.height / 90;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 1.2,
          height: MediaQuery.of(context).size.height / 2.55,
          decoration: BoxDecoration(
            color: MyColors.kSecondary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: MyColors.kPrimary,
              ),
            ],
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Status
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              border: Border.all(
                                color: MyColors.kPrimary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Shop',
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Detials',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)))),
                      ],
                    ),
                    SizedBox(height: heightbetweenWidgetsInOrder),
                    // all the seller shopes
                    Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Shop Name:'),
                                    SizedBox(height: 8.0),
                                    CustomDivider(),
                                    SizedBox(height: 8.0),

                                    Text('Shop Owner Name:'),
                                    SizedBox(height: 8.0),
                                    CustomDivider(),
                                    SizedBox(height: 8.0),

                                    Text('Mobile Number:'),
                                    SizedBox(height: 8.0),
                                    CustomDivider(),
                                    SizedBox(height: 8.0),

                                    Text('Shop Address:'),
                                    SizedBox(height: 8.0),
                                    CustomDivider(),
                                    SizedBox(height: 8.0),

                                    // Text('Shop Address:'),
                                    // SizedBox(height: 8.0),
                                    // CustomDivider(),
                                    // SizedBox(height: 8.0),

                                    // Text('Shope Name:'),
                                    // SizedBox(height: 8.0),
                                    // // Text('Status: ${shops.status}'),
                                    // SizedBox(height: 8.0),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('${shops.shop_name}'),
                                    SizedBox(height: 8.0),
                                    CustomDivider(),
                                    SizedBox(height: 8.0),

                                    Text('${shops.name}'),
                                    SizedBox(height: 8.0),
                                    CustomDivider(),
                                    SizedBox(height: 8.0),

                                    Text('${shops.mobile_no}'),
                                    SizedBox(height: 8.0),
                                    CustomDivider(),
                                    SizedBox(height: 8.0),

                                    Text('${shops.shop_adress}'),
                                    SizedBox(height: 8.0),
                                    CustomDivider(),
                                    SizedBox(height: 8.0),

                                    // Text('${shops.shop_adress}'),
                                    // SizedBox(height: 8.0),
                                    // CustomDivider(),
                                    // SizedBox(height: 8.0),

                                    // Text('${shops.shop_name}'),
                                    // SizedBox(height: 8.0),
                                    // Text('Status: ${shops.status}'),
                                    // SizedBox(height: 8.0),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //Pickup Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(
                          MediaQuery.of(context).size.width / 1.6,
                          MediaQuery.of(context).size.height / 20,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        backgroundColor: MyColors.kPrimary,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Place An Order',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.shopping_cart,
                            size: 33,
                          )
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ReviewCart(
                                  getShopName:shops.shop_name,
                                  getShopId: shops.email,
                                )));
                      },
                    ),

                    // //Pickup Button
                    // InkWell(
                    //   onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => ReviewCart(
                    //             getShopId: shops.email,
                    //           ))),
                    //   child: Center(
                    //     child: Container(
                    //       width: MediaQuery.of(context).size.width / 1.6,
                    //       height: MediaQuery.of(context).size.height / 20,
                    //       decoration: BoxDecoration(
                    //         color: MyColors.kPrimary,
                    //         borderRadius: BorderRadius.circular(10),
                    //         boxShadow: [
                    //           BoxShadow(
                    //             color: MyColors.kPrimary,
                    //           ),
                    //         ],
                    //       ),
                    //       child: Center(
                    //           child: Text(
                    //         "Place An Order",
                    //         style: kTextStyleWhite,
                    //       )),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
