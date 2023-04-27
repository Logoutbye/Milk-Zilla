import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/View/Buyer_UI/check_out_screen.dart';
import 'package:milk_zilla/View/Buyer_UI/price_list.dart';
import 'package:milk_zilla/provider/Sopping_item_provider.dart';
import 'package:milk_zilla/res/Components/my_drawer.dart';
import 'package:provider/provider.dart';

import '../../res/Components/create_an_order.dart';
import '../../res/my_colors.dart';

class BuyerScreen extends StatefulWidget {
  const BuyerScreen({super.key});

  @override
  State<BuyerScreen> createState() => _BuyerScreenState();
}

class _BuyerScreenState extends State<BuyerScreen> {
  @override
  Widget build(BuildContext context) {
    final milkProvider = Provider.of<ShoppingItemProvider>(context);
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
      endDrawer: MyAppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 6,
              // width: MediaQuery.of(context).size.width/1.4,
              child: Lottie.asset('assets/animations/feader.json'),
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

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12),
            //   child: Row(
            //     children: [
            //       Text('Select Item',
            //           style: TextStyle(
            //               color: MyColors.kBlack,
            //               fontSize: 16,
            //               fontWeight: FontWeight.bold)),
            //       Spacer(),
            //       InkWell(
            //         onTap: () => Navigator.of(context).push(
            //             MaterialPageRoute(builder: (context) => priceList())),
            //         child: Text('Price List',
            //             style: TextStyle(
            //                 color: MyColors.kPrimary,
            //                 fontSize: 16,
            //                 fontWeight: FontWeight.bold)),
            //       )
            //     ],
            //   ),
            // ),
            // Container(
            //   height: MediaQuery.of(context).size.height / 7.5,
            //   decoration: BoxDecoration(color: Colors.transparent),
            //   child: ListView(
            //     padding: EdgeInsets.all(12),
            //     physics: BouncingScrollPhysics(),
            //     scrollDirection: Axis.horizontal,
            //     children: [
            //       ItemButton(
            //           productType: 'Buffalo Milk',
            //           onPressed: () {
            //             Provider.of<MilkProvider>(context, listen: false)
            //                 .incrementCount('Buffalo Milk');
            //             print('buffalo pressed');
            //           }),
            //       SizedBox(
            //         width: 20,
            //       ),
            //       ItemButton(productType: 'Cow Milk', onPressed: () {}),
            //       SizedBox(
            //         width: 20,
            //       ),
            //       ItemButton(productType: 'Mix Milk', onPressed: () {}),
            //       SizedBox(
            //         width: 20,
            //       ),
            //       ItemButton(productType: 'Yogurt', onPressed: () {}),
            //       SizedBox(
            //         width: 20,
            //       ),
            //       ItemButton(productType: 'Butter', onPressed: () {}),
            //       SizedBox(
            //         width: 20,
            //       ),
            //       ItemButton(productType: 'Desi Ghee', onPressed: () {}),
            //       SizedBox(
            //         width: 20,
            //       ),
            //     ],
            //   ),
            // ),

            SizedBox(
              height: MediaQuery.of(context).size.height / 54,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Text('Create an Order',
                      style: TextStyle(
                          color: MyColors.kBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Spacer(),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => priceList())),
                    child: Text('See Price List',
                        style: TextStyle(
                            color: MyColors.kPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Consumer<ShoppingItemProvider>(
              builder: (BuildContext context, value, Widget? child) {
                return Column(
                  children: [
                    CreateAnOrder(
                      itemname: 'Buffalo Milk',
                      onPressedDecrement: () =>
                          Provider.of<ShoppingItemProvider>(context,
                                  listen: false)
                              .decrementCount('Buffalo Milk'),
                      onPressedIncrement: () =>
                          Provider.of<ShoppingItemProvider>(context,
                                  listen: false)
                              .incrementCount('Buffalo Milk'),
                    ),
                    CreateAnOrder(
                      itemname: 'Cow Milk',
                      onPressedDecrement: () =>
                          Provider.of<ShoppingItemProvider>(context,
                                  listen: false)
                              .decrementCount('Cow Milk'),
                      onPressedIncrement: () =>
                          Provider.of<ShoppingItemProvider>(context,
                                  listen: false)
                              .incrementCount('Cow Milk'),
                    ),
                    CreateAnOrder(
                      itemname: 'Mix Milk',
                      onPressedDecrement: () =>
                          Provider.of<ShoppingItemProvider>(context,
                                  listen: false)
                              .decrementCount('Mix Milk'),
                      onPressedIncrement: () =>
                          Provider.of<ShoppingItemProvider>(context,
                                  listen: false)
                              .incrementCount('Mix Milk'),
                    ),
                    CreateAnOrder(
                      itemname: 'Yogurt',
                      onPressedDecrement: () =>
                          Provider.of<ShoppingItemProvider>(context,
                                  listen: false)
                              .decrementCount('Yogurt'),
                      onPressedIncrement: () =>
                          Provider.of<ShoppingItemProvider>(context,
                                  listen: false)
                              .incrementCount('Yogurt'),
                    ),
                    CreateAnOrder(
                      itemname: 'Butter',
                      onPressedDecrement: () =>
                          Provider.of<ShoppingItemProvider>(context,
                                  listen: false)
                              .decrementCount('Butter'),
                      onPressedIncrement: () =>
                          Provider.of<ShoppingItemProvider>(context,
                                  listen: false)
                              .incrementCount('Butter'),
                    ),
                    CreateAnOrder(
                      itemname: 'Desi Ghee',
                      onPressedDecrement: () =>
                          Provider.of<ShoppingItemProvider>(context,
                                  listen: false)
                              .decrementCount('Desi Ghee'),
                      onPressedIncrement: () =>
                          Provider.of<ShoppingItemProvider>(context,
                                  listen: false)
                              .incrementCount('Desi Ghee'),
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
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
                      'Review Cart',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward,
                      size: 33,
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CheckOutScreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemButton extends StatelessWidget {
  final String productType;
  final VoidCallback onPressed;

  ItemButton({required this.productType, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          width: MediaQuery.of(context).size.width / 5,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: MyColors.kshadow,
              blurRadius: 9,
              offset: Offset(2, 2), // Shadow position
            ),
          ], color: MyColors.kWhite, borderRadius: BorderRadius.circular(29)),
          child: Center(
              child: Text(
            productType,
            // style: TextStyle(color: MyColors.kWhite),
          ))),
    );
  }
}

class MilkCounter extends StatelessWidget {
  final String productType;
  final String unit;

  const MilkCounter({required this.productType, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$productType : ${Provider.of<ShoppingItemProvider>(context).getCount(productType)} $unit',
      style: TextStyle(fontSize: 20),
    );
  }
}
