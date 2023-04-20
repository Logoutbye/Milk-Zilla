import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/res/constanst.dart';
import 'package:milk_zilla/res/my_colors.dart';
import 'package:provider/provider.dart';

import '../../Model/order_item_model.dart';
import '../../Model/price_list_model.dart';
import '../../provider/Sopping_item_provider.dart';
import '../../res/Components/order_list_item.dart';

class CheckOutScreen extends StatefulWidget {
  // static const String path = "lib/src/pages/food/food_checkout.dart";

  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  void initState() {
    getRealTimePricesFromDatabase();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoppingItemProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: getRealTimePricesFromDatabase(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Lottie.asset('assets/animations/loading.json'));
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.fromLTRB(
                    16.0,
                    kToolbarHeight + 40.0,
                    16.0,
                    16.0,
                  ),
                  children: [
                    const Text(
                      "My Order",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    if (provider.getCount('Buffalo Milk') > 0)
                      OrderListItem(
                        item: OrderItemModel(
                          name: "Buffalo Milk",
                          quantity: provider.getCount('Buffalo Milk'),
                          price: snapshot.data.buffalo_milk,
                          onPressedDecrement: () =>
                              provider.decrementCount('Buffalo Milk'),
                          onPressedIncrement: () =>
                              provider.incrementCount('Buffalo Milk'),
                        ),
                      ),
                    if (provider.getCount('Cow Milk') > 0)
                      OrderListItem(
                        item: OrderItemModel(
                          name: "Cow Milk",
                          quantity: provider.getCount('Cow Milk'),
                          price:  snapshot.data.cow_milk,
                          onPressedDecrement: () =>
                              provider.decrementCount('Cow Milk'),
                          onPressedIncrement: () =>
                              provider.incrementCount('Cow Milk'),
                        ),
                      ),
                    if (provider.getCount('Mix Milk') > 0)
                      OrderListItem(
                        item: OrderItemModel(
                          name: "Mix Milk",
                          quantity: provider.getCount('Mix Milk'),
                          price: snapshot.data.mix_milk,
                          onPressedDecrement: () =>
                              provider.decrementCount('Mix Milk'),
                          onPressedIncrement: () =>
                              provider.incrementCount('Mix Milk'),
                        ),
                      ),
                    if (provider.getCount('Yogurt') > 0)
                      OrderListItem(
                        item: OrderItemModel(
                          name: "Yogurt",
                          quantity: provider.getCount('Yogurt'),
                          price: snapshot.data.yougurt,
                          onPressedDecrement: () =>
                              provider.decrementCount('Yogurt'),
                          onPressedIncrement: () =>
                              provider.incrementCount('Yogurt'),
                        ),
                      ),
                    if (provider.getCount('Butter') > 0)
                      OrderListItem(
                        item: OrderItemModel(
                          name: "Butter",
                          quantity: provider.getCount('Butter'),
                          price: snapshot.data.butter,
                          onPressedDecrement: () =>
                              provider.decrementCount('Butter'),
                          onPressedIncrement: () =>
                              provider.incrementCount('Butter'),
                        ),
                      ),
                    if (provider.getCount('Desi Ghee') > 0)
                      OrderListItem(
                        item: OrderItemModel(
                          name: "Desi Ghee",
                          quantity: provider.getCount('Desi Ghee'),
                          price: snapshot.data.desi_ghee,
                          onPressedDecrement: () =>
                              provider.decrementCount('Desi Ghee'),
                          onPressedIncrement: () =>
                              provider.incrementCount('Desi Ghee'),
                        ),
                      ),
                    const SizedBox(height: 20.0),
                    _buildDivider(),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        const SizedBox(width: 40.0),
                        Text(
                          "Delivery Charges",
                          style: priceTextStyle,
                        ),
                        const Spacer(),
                        Text(
                          "Rs ${snapshot.data.delivery_charges}",
                          style: priceTextStyle,
                        ),
                        const SizedBox(width: 20.0),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    _buildDivider(),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        const SizedBox(width: 40.0),
                        Text(
                          "Total",
                          style: priceTextStyle.copyWith(color: Colors.black),
                        ),
                        const Spacer(),
                        Text(
                          "Rs 400",
                          style:
                              priceTextStyle.copyWith(color: MyColors.kPrimary),
                        ),
                        const SizedBox(width: 20.0),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16.0),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          backgroundColor: MyColors.kPrimary,
                        ),
                        child: const Text(
                          "Proceed Order",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        onPressed: () {
                          print('ss${provider.getCount('Buffalo Milk')}');
                          getRealTimePricesFromDatabase();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Center(child: Text('Something went wrong!'));
          }
        },
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      height: 2.0,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }

  Future<PriceList?> getRealTimePricesFromDatabase() async {
   final docPrices =
        FirebaseFirestore.instance.collection('Price List').doc('items');
    final snapshot = await docPrices.get();

    if (snapshot.exists) {
      return PriceList.fromJson(snapshot.data()!);
    } 
   
    // FirebaseFirestore firestore = FirebaseFirestore.instance;

    // // get document reference
    // DocumentReference documentReference =
    //     firestore.collection('Price List').doc('items');

    // // get document snapshot
    // DocumentSnapshot documentSnapshot = await documentReference.get();

    // // check if document exists
    // if (documentSnapshot.exists) {
    //   // get document data
    //   Map<String, dynamic>? data =
    //       documentSnapshot.data() as Map<String, dynamic>?;

    //   // access specific fields
    //   String buffalo_milk = data!['buffalo_milk'];
    //   print('prices::${buffalo_milk}');
    // }
  }
}
