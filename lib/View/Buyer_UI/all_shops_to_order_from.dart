import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/Model/seller_model.dart';
import 'package:milk_zilla/View/Buyer_UI/review_cart.dart';
import 'package:milk_zilla/controllers/Buyer_Controllers/get_all_approved_shopes_with_specif_city_controller.dart';
import 'package:milk_zilla/res/Components/my_drawers/buyer_drawer.dart';
import 'package:milk_zilla/res/constanst.dart';
import 'package:milk_zilla/res/my_colors.dart';

class AllShopesToOrderFrom extends StatefulWidget {
  const AllShopesToOrderFrom({super.key});

  @override
  State<AllShopesToOrderFrom> createState() => _AllShopesToOrderFromState();
}

class _AllShopesToOrderFromState extends State<AllShopesToOrderFrom> {
  // creating object of buyerContolerr here to acces all the data fetched
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
                  onPressed: () {},
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: IconButton(
                icon: Icon(Icons.shopping_cart_checkout),
                iconSize: 35,
                onPressed: () {},
              ),
            ),
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
              .getAllApprovedShopeswithSpecifCity(),
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
        ));
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                              'Status',
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
                              child: Text('Pending',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)))),
                    ],
                  ),
                  SizedBox(height: heightbetweenWidgetsInOrder),
                  Text('Order Details'),
                  SizedBox(height: heightbetweenWidgetsInOrder),
                  // all the seller shopes
                  Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text('Shop Name: ${shops.name}'),
                          SizedBox(height: 8.0),
                          Text('Shop City: ${shops.city}'),
                          SizedBox(height: 8.0),
                          Text('Shop Email: ${shops.email}'),
                          SizedBox(height: 8.0),
                          Text('Moble Number: ${shops.mobile_no}'),
                          SizedBox(height: 8.0),
                          Text('Password: ${shops.password}'),
                          SizedBox(height: 8.0),
                          Text('Shop Address: ${shops.shop_adress}'),
                          SizedBox(height: 8.0),
                          Text('Shope Name: ${shops.shop_name}'),
                          SizedBox(height: 8.0),
                          Text('Status: ${shops.status}'),
                          SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  ),

                  //Pickup Button
                  InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ReviewCart(
                              getShopId: shops.email,
                            ))),
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.6,
                        height: MediaQuery.of(context).size.height / 20,
                        decoration: BoxDecoration(
                          color: MyColors.kPrimary,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: MyColors.kPrimary,
                            ),
                          ],
                        ),
                        child: Center(
                            child: Text(
                          "Place An Order",
                          style: kTextStyleWhite,
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
