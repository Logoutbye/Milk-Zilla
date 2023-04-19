import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/View/Buyer_UI/check_out_screen.dart';
import 'package:milk_zilla/View/Buyer_UI/price_list.dart';
import 'package:milk_zilla/provider/selected_item_provider.dart';
import 'package:milk_zilla/res/Components/my_drawer.dart';
import 'package:provider/provider.dart';

import '../../res/my_colors.dart';

class BuyerScreen extends StatefulWidget {
  const BuyerScreen({super.key});

  @override
  State<BuyerScreen> createState() => _BuyerScreenState();
}

class _BuyerScreenState extends State<BuyerScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedItemProvider = Provider.of<SelectedItemProvider>(context);
    print("build whole");
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
              padding: const EdgeInsets.only(left: 18.0),
              child: Container(
                  width: MediaQuery.of(context).size.width / 3.5,
                  height: MediaQuery.of(context).size.height / 20,
                  decoration: BoxDecoration(
                      color: MyColors.kPrimary,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                      child: Text(
                    'My Orders',
                    style: TextStyle(color: MyColors.kWhite),
                  ))),
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
      endDrawer: MyAppDrawer(),
      body: Column(
        children: [
          Container(
            child: Lottie.asset('assets/animations/loading.json'),
          ),
          Container(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: Theme.of(context).textTheme.labelSmall,
                  children: [
                    TextSpan(
                        text: 'Welcome to Milk Zilla\n',
                        style: TextStyle(
                            color: Color.fromARGB(255, 125, 199, 127),
                            fontSize: 16)),
                    TextSpan(
                        text: 'How can we serve you \ntoday?',
                        style: TextStyle(
                            color: MyColors.kPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                  ]),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Text('Select Item',
                    style: TextStyle(
                        color: MyColors.kBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Spacer(),
                InkWell(
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => priceList())),
                  child: Text('Price List',
                      style: TextStyle(
                          color: MyColors.kPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 6.5,
            decoration: BoxDecoration(color: Colors.transparent),
            child: ListView(
              padding: EdgeInsets.all(12),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width / 4,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.kshadow,
                            blurRadius: 9,
                            offset: Offset(2, 2), // Shadow position
                          ),
                        ],
                        color: MyColors.kWhite,
                        borderRadius: BorderRadius.circular(29)),
                    child: Center(
                        child: Text(
                      'Buffalo Milk',
                      // style: TextStyle(color: MyColors.kWhite),
                    ))),
                SizedBox(
                  width: 20,
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 4,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.kshadow,
                            blurRadius: 9,
                            offset: Offset(2, 2), // Shadow position
                          ),
                        ],
                        color: MyColors.kWhite,
                        borderRadius: BorderRadius.circular(29)),
                    child: Center(
                        child: Text(
                      'Cow Milk',
                      // style: TextStyle(color: MyColors.kWhite),
                    ))),
                SizedBox(
                  width: 20,
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 4,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.kshadow,
                            blurRadius: 9,
                            offset: Offset(2, 2), // Shadow position
                          ),
                        ],
                        color: MyColors.kWhite,
                        borderRadius: BorderRadius.circular(29)),
                    child: Center(
                        child: Text(
                      'Mix Milk',
                      // style: TextStyle(color: MyColors.kWhite),
                    ))),
                SizedBox(
                  width: 20,
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 4,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.kshadow,
                            blurRadius: 9,
                            offset: Offset(2, 2), // Shadow position
                          ),
                        ],
                        color: MyColors.kWhite,
                        borderRadius: BorderRadius.circular(29)),
                    child: Center(
                        child: Text(
                      'Yogurt',
                      // style: TextStyle(color: MyColors.kWhite),
                    ))),
                SizedBox(
                  width: 20,
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 4,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.kshadow,
                            blurRadius: 9,
                            offset: Offset(2, 2), // Shadow position
                          ),
                        ],
                        color: MyColors.kWhite,
                        borderRadius: BorderRadius.circular(29)),
                    child: Center(
                        child: Text(
                      'Butter',
                      // style: TextStyle(color: MyColors.kWhite),
                    ))),
                SizedBox(
                  width: 20,
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 4,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.kshadow,
                            blurRadius: 9,
                            offset: Offset(2, 2), // Shadow position
                          ),
                        ],
                        color: MyColors.kWhite,
                        borderRadius: BorderRadius.circular(29)),
                    child: Center(
                        child: Text(
                      'Desi Ghee',
                      // style: TextStyle(color: MyColors.kWhite),
                    ))),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Text('Quantity',
                    style: TextStyle(
                        color: MyColors.kBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Consumer<SelectedItemProvider>(
            builder: (BuildContext context, value, Widget? child) {
              return Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 10,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: MyColors.kshadow,
                        blurRadius: 9,
                        offset: Offset(2, 2), // Shadow position
                      ),
                    ],
                    color: MyColors.kWhite,
                    borderRadius: BorderRadius.circular(49)),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          value.decrementSelectedItem();
                        },
                        icon: Icon(
                          Icons.remove,
                          size: 33,
                        )),
                    Spacer(),
                    Text('${value.selectedItem}'),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          value.incrementSelectedItem();
                        },
                        icon: Icon(
                          Icons.add,
                          size: 33,
                        ))
                  ],
                ),
              );
            },
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CheckOutScreen()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.height / 10,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.kWhite,
                      blurRadius: 9,
                      offset: Offset(2, 2), // Shadow position
                    ),
                  ],
                  color: MyColors.kshadow,
                  borderRadius: BorderRadius.circular(29)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text('\$which Milk - \$how much Litre'),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: 33,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
