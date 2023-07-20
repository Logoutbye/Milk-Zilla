import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/View/Seller_UI/Shop%20Orders/review_cart_for_farm.dart';
import 'package:milk_zilla/controllers/Farm_Controllers/farm_controller.dart';
import 'package:milk_zilla/res/Components/my_drawers/seller_drawer.dart';
import '../../../Model/seller_model.dart';
import '../../../res/Components/custom_divider.dart';
import '../../../res/my_colors.dart';
import '../Buy Milk From Farm/buy_milk_from_farm_tabar.dart';

class AllFarmsToOrderMilk extends StatefulWidget {
  const AllFarmsToOrderMilk({super.key});

  @override
  State<AllFarmsToOrderMilk> createState() => _AllFarmsToOrderMilkState();
}

class _AllFarmsToOrderMilkState extends State<AllFarmsToOrderMilk> {
  final user = FirebaseAuth.instance.currentUser;
  var getUserCity;

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
                      builder: (context) => BuyMilkFromFarmTabar()));
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
      endDrawer: SellerDrawer(),
      body: FutureBuilder<List<SellerOrInspectorModel>>(
        future: FarmController().getAllApprovedFarmswithSpecifCity(getUserCity),
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
                // TODO: Build UI for each order
                return buildShopsUI(context, shopes);
              },
            );
          } else {
            return Text('No Shopes found');
          }
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

  Widget buildShopsUI(BuildContext context, SellerOrInspectorModel farm) {
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
                                    Text('Name:'),
                                    SizedBox(height: 8.0),
                                    CustomDivider(),
                                    SizedBox(height: 8.0),

                                    Text('Owner Name:'),
                                    SizedBox(height: 8.0),
                                    CustomDivider(),
                                    SizedBox(height: 8.0),

                                    Text('Mobile No:'),
                                    SizedBox(height: 8.0),
                                    CustomDivider(),
                                    SizedBox(height: 8.0),

                                    Text('Address:'),
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
                                    Text('${farm.farm_name}'),
                                    SizedBox(height: 8.0),
                                    CustomDivider(),
                                    SizedBox(height: 8.0),

                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Column(
                                        children: [
                                          Text('${farm.name}'),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    CustomDivider(),
                                    SizedBox(height: 8.0),

                                    Text('${farm.mobile_no}'),
                                    SizedBox(height: 8.0),
                                    CustomDivider(),
                                    SizedBox(height: 8.0),

                                    Text('${farm.farm_adress}'),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Place An Order',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          Icon(
                            Icons.shopping_cart,
                            //size: 33,
                          )
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ReviewCartForFarm(getFormId: farm.email,getFormName: farm.farm_name,),
                          ),
                        );
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
