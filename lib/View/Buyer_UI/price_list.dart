import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/View/Buyer_UI/check_out_screen.dart';
import 'package:milk_zilla/res/constanst.dart';
import 'package:milk_zilla/res/my_colors.dart';

import '../../Model/price_list_model.dart';

class priceList extends StatefulWidget {
  const priceList({super.key});

  @override
  State<priceList> createState() => _priceListState();
}

class _priceListState extends State<priceList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.kWhite,
      appBar: AppBar(
        title: Text('Pricing Details'),
        elevation: 0,
        backgroundColor: MyColors.kWhite,
        foregroundColor: MyColors.kPrimary,
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: readPriceListFromDatabase(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Lottie.asset('assets/animations/loading.json'));
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return ListView(
                padding: const EdgeInsets.fromLTRB(
                  16.0,
                  kToolbarHeight,
                  16.0,
                  16.0,
                ),
                children: [
                  const Text(
                    "Milk Zilla Pricing",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  _buildDivider(),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      const SizedBox(width: 40.0),
                      Text(
                        "Buffalo Milk(1 Litre)",
                        style: priceTextStyle,
                      ),
                      const Spacer(),
                      Text(
                        "Rs ${snapshot.data!.buffalo_milk}",
                        style: priceTextStyle,
                      ),
                      const SizedBox(width: 20.0),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  _buildDivider(),
                  const SizedBox(height: 20.0),
                  _buildDivider(),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      const SizedBox(width: 40.0),
                      Text(
                        "Cow Milk(1 litre)",
                        style: priceTextStyle,
                      ),
                      const Spacer(),
                      Text(
                        "Rs ${snapshot.data!.cow_milk}",
                        style: priceTextStyle,
                      ),
                      const SizedBox(width: 20.0),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  _buildDivider(),
                  const SizedBox(height: 20.0),
                  _buildDivider(),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      const SizedBox(width: 40.0),
                      Text(
                        "Mix Milk(1 Litre)",
                        style: priceTextStyle,
                      ),
                      const Spacer(),
                      Text(
                        "Rs ${snapshot.data!.mix_milk}",
                        style: priceTextStyle,
                      ),
                      const SizedBox(width: 20.0),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  _buildDivider(),
                  const SizedBox(height: 20.0),
                  _buildDivider(),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      const SizedBox(width: 40.0),
                      Text(
                        "Yogurt(1 Kg) ",
                        style: priceTextStyle,
                      ),
                      const Spacer(),
                      Text(
                        "Rs ${snapshot.data!.yougurt}",
                        style: priceTextStyle,
                      ),
                      const SizedBox(width: 20.0),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  _buildDivider(),
                  const SizedBox(height: 20.0),
                  _buildDivider(),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      const SizedBox(width: 40.0),
                      Text(
                        "Butter",
                        style: priceTextStyle,
                      ),
                      const Spacer(),
                      Text(
                        "Rs ${snapshot.data!.butter}",
                        style: priceTextStyle,
                      ),
                      const SizedBox(width: 20.0),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  _buildDivider(),
                  const SizedBox(height: 20.0),
                  _buildDivider(),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      const SizedBox(width: 40.0),
                      Text(
                        "Desi Ghee",
                        style: priceTextStyle,
                      ),
                      const Spacer(),
                      Text(
                        "Rs ${snapshot.data!.desi_ghee}",
                        style: priceTextStyle,
                      ),
                      const SizedBox(width: 20.0),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  _buildDivider(),
                  const SizedBox(height: 20.0),
                  _buildDivider(),
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
                        "Rs ${snapshot.data!.delivery_charges}",
                        style: priceTextStyle,
                      ),
                      const SizedBox(width: 20.0),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  _buildDivider(),
                ],
              );
            } else {
              return Center(child: Text('Something went wrong!'));
            }
          }
          ),
    );
  }

  Future<PriceListModel?> readPriceListFromDatabase() async {
    final docPrices =
        FirebaseFirestore.instance.collection('Price List').doc('items');
    final snapshot = await docPrices.get();

    if (snapshot.exists) {
      return PriceListModel.fromJson(snapshot.data()!);
    }
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
}
