import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/Model/price_list_model.dart';
import 'package:milk_zilla/res/constanst.dart';
import 'package:milk_zilla/res/my_colors.dart';

class PriceListForSeller extends StatefulWidget {
  const PriceListForSeller({super.key});

  @override
  State<PriceListForSeller> createState() => _PriceListForSellerState();
}

class _PriceListForSellerState extends State<PriceListForSeller> {
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
                  child: Lottie.asset('assets/animations/loading.json',
                      height: MediaQuery.of(context).size.height / 5));
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
                    "Milk Zilla Farm Pricing",
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
                        "1 Litre Container",
                        style: kTextStyleBlack,
                      ),
                      const Spacer(),
                      Text(
                        "Rs ${snapshot.data!.quantity1L}",
                        style: kTextStyleBlack,
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
                        "500 ml Container",
                        style: kTextStyleBlack,
                      ),
                      const Spacer(),
                      Text(
                        "Rs ${snapshot.data!.quantity500ML}",
                        style: kTextStyleBlack,
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
                        "250 ml Container",
                        style: kTextStyleBlack,
                      ),
                      const Spacer(),
                      Text(
                        "Rs ${snapshot.data!.quantity250ML}",
                        style: kTextStyleBlack,
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
                        "Delivery Charges",
                        style: kTextStyleBlack,
                      ),
                      const Spacer(),
                      Text(
                        "Rs ${snapshot.data!.delivery_charges}",
                        style: kTextStyleBlack,
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
          }),
    );
  }

  Future<ContainerPriceList?> readPriceListFromDatabase() async {
    final docPrices =
        FirebaseFirestore.instance.collection('Price List').doc('containers');
    final snapshot = await docPrices.get();

    if (snapshot.exists) {
      return ContainerPriceList.fromJson(snapshot.data()!);
    }
    return null;
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
