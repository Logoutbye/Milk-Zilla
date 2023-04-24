import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/Utils/utils.dart';
import 'package:milk_zilla/main.dart';
import 'package:milk_zilla/res/Components/error_screen.dart';
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
  var totalPrice;

  var totalItems;
  var generateOrderNumber = MyStaticComponents.generateOrderNumber();
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    print('init total price is $totalPrice && total items are $totalItems');
    calculatetotalPrices();
    getRealTimePricesFromDatabase();

    print('unique order number for order:: $generateOrderNumber');
    print('email of current user for order${user!.email}');
    // 1682363470245254
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoppingItemProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // title: Text('Order Id ${generateOrderNumber}',style: TextStyle(color: MyColors.kPrimary),),
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
                          unit: 'Litre',
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
                          unit: 'Litre',
                          quantity: provider.getCount('Cow Milk'),
                          price: snapshot.data.cow_milk,
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
                          unit: 'Litre',
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
                          unit: 'KG',
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
                          unit: 'KG',
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
                          unit: 'KG',
                          quantity: provider.getCount('Desi Ghee'),
                          price: snapshot.data.desi_ghee,
                          onPressedDecrement: () =>
                              provider.decrementCount('Desi Ghee'),
                          onPressedIncrement: () =>
                              provider.incrementCount('Desi Ghee'),
                        ),
                      ),
                    const SizedBox(height: 20.0),
                    totalItems == 0 ? SizedBox() : _buildDivider(),
                    const SizedBox(height: 20.0),
                    totalItems == 0
                        ? SizedBox()
                        : Row(
                            children: [
                              const SizedBox(width: 40.0),
                              Text(
                                totalItems == 1 ? 'Item' : "Items",
                                style: priceTextStyle,
                              ),
                              const Spacer(),
                              Text(
                                "${totalItems}",
                                style: priceTextStyle,
                              ),
                              const SizedBox(width: 20.0),
                            ],
                          ),
                    const SizedBox(height: 20.0),
                    _buildDivider(),
                    const SizedBox(height: 20.0),
                    totalPrice > snapshot.data.delivery_charges
                        ? Row(
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
                          )
                        : Center(
                            child: Text(
                            'Must Select atleast one Item',
                            style: priceTextStyle,
                          )),
                    const SizedBox(height: 20.0),
                    _buildDivider(),
                    const SizedBox(height: 10.0),
                    totalPrice > snapshot.data.delivery_charges
                        ? Row(
                            children: [
                              const SizedBox(width: 40.0),
                              Text(
                                "Total",
                                style: priceTextStyle.copyWith(
                                    color: Colors.black),
                              ),
                              const Spacer(),
                              Text(
                                "Rs $totalPrice",
                                style: priceTextStyle.copyWith(
                                    color: MyColors.kPrimary),
                              ),
                              const SizedBox(width: 20.0),
                            ],
                          )
                        : SizedBox(),
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
                        child: Text(
                          totalPrice > snapshot.data.delivery_charges
                              ? "Proceed Order"
                              : "Select Items",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        onPressed: () {
                          if (totalPrice > snapshot.data.delivery_charges) {
                            List<Map<dynamic, dynamic>> orderDetails = [
                              if (provider.getCount('Buffalo Milk') > 0)
                                {
                                  'item_name': 'Buffalo Milk',
                                  'item_quantity':
                                      provider.getCount('Buffalo Milk'),
                                  'item_price': 10,
                                },
                              if (provider.getCount('Cow Milk') > 0)
                                {
                                  'item_name': 'Cow Milk',
                                  'item_quantity':
                                      provider.getCount('Cow Milk'),
                                  'item_price': 5.0,
                                },
                              if (provider.getCount('Mix Milk') > 0)
                                {
                                  'item_name': 'Mix Milk',
                                  'item_quantity':
                                      provider.getCount('Mix Milk'),
                                  'item_price': 10,
                                },
                              if (provider.getCount('Mix Milk') > 0)
                                {
                                  'item_name': 'Yogurt',
                                  'item_quantity': provider.getCount('Yogurt'),
                                  'item_price': 10,
                                },
                              if (provider.getCount('Mix Milk') > 0)
                                {
                                  'item_name': 'Butter',
                                  'item_quantity': provider.getCount('Butter'),
                                  'item_price': 10,
                                },
                              if (provider.getCount('Mix Milk') > 0)
                                {
                                  'item_name': 'Desi Ghee',
                                  'item_quantity':
                                      provider.getCount('Desi Ghee'),
                                  'item_price': 10,
                                },
                            ];

                            // CreateAnOrderInFireBase(
                            //     context,
                            //     totalQuantity,
                            //     totalPrice,
                            //     generateOrderNumber,
                            //     '${user!.email}',
                            //     orderDetails);

                            ///////////////////////////////
                            //                               List<Map<String, dynamic>> items = [
                            // {'item_name': 'Item 1', 'item_price': 10.0, 'item_quantity': 2},
                            // {'item_name': 'Item 2', 'item_price': 5.0, 'item_quantity': 3},
// ];

                            CreateAnOrderInFireBase(
                                context,
                                totalItems,
                                totalPrice,
                                generateOrderNumber,
                                '${user!.email}',
                                orderDetails);
                          } else {
                            Navigator.pop(context);
                          }
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

  calculatetotalPrices() async {
    final provider = Provider.of<ShoppingItemProvider>(context, listen: false);

    var buffalo_milk_price;
    var cow_milk_price;
    var mix_milk_price;
    var yogurt_price;
    var butter_price;
    var desi_ghee_price;
    var delivery_charges;

    var newbuffalo_milk_price;
    var newcow_milk_price;
    var newmix_milk_price;
    var newyogurt_price;
    var newbutter_price;
    var newdesi_ghee_price;

    var buffalo_milk_quantity;
    var cow_milk_quantity;
    var mix_milk_quantity;
    var yogurt_quantity;
    var butter_quantity;
    var desi_ghee_quantity;

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // get document reference
    DocumentReference documentReference =
        firestore.collection('Price List').doc('items');
    // get document snapshot
    DocumentSnapshot documentSnapshot = await documentReference.get();
    // check if document exists
    if (documentSnapshot.exists) {
      // get document data
      Map<String, dynamic>? data =
          documentSnapshot.data() as Map<String, dynamic>?;

      // access specific fields
      buffalo_milk_price = data!['buffalo_milk'];
      cow_milk_price = data['cow_milk'];
      mix_milk_price = data['mix_milk'];
      yogurt_price = data['yogurt'];
      butter_price = data['butter'];
      desi_ghee_price = data['desi_ghee'];
      delivery_charges = data['delivery_charges'];

      print('buffalo_milk_price::${buffalo_milk_price}');
      print('cow_milk_price::${cow_milk_price}');
      print('mix_milk_price::${mix_milk_price}');
      print('yogurt_price::${yogurt_price}');
      print('butter_price::${butter_price}');
      print('desi_ghee_price::${desi_ghee_price}');
      print('delivery_charges::${delivery_charges}');

      if (provider.getCount('Buffalo Milk') > 0) {
        newbuffalo_milk_price =
            provider.getCount('Buffalo Milk') * buffalo_milk_price;
        print('New Price is::$newbuffalo_milk_price');

        buffalo_milk_quantity = 1;
      } else {
        print('Price is nulll');
        newbuffalo_milk_price = 0;
        buffalo_milk_quantity = 0;
      }
      if (provider.getCount('Cow Milk') > 0) {
        newcow_milk_price = provider.getCount('Cow Milk') * cow_milk_price;
        print('New Price is::$newcow_milk_price');
        cow_milk_quantity = 1;
      } else {
        print('Price is nulll');
        newcow_milk_price = 0;
        cow_milk_quantity = 0;
      }
      if (provider.getCount('Mix Milk') > 0) {
        newmix_milk_price = provider.getCount('Mix Milk') * mix_milk_price;
        print('New Price is::$newmix_milk_price');
        mix_milk_quantity = 1;
      } else {
        print('Price is nulll');
        newmix_milk_price = 0;
        mix_milk_quantity = 0;
      }
      if (provider.getCount('Yogurt') > 0) {
        newyogurt_price = provider.getCount('Yogurt') * yogurt_price;
        print('New Price is::$newyogurt_price');
        yogurt_quantity = 1;
      } else {
        print('Price is nulll');
        newyogurt_price = 0;
        yogurt_quantity = 0;
      }
      if (provider.getCount('Butter') > 0) {
        newbutter_price = provider.getCount('Butter') * butter_price;
        print('New Price is::$newbutter_price');
        butter_quantity = 1;
      } else {
        print('Price is nulll');
        newbutter_price = 0;
        butter_quantity = 0;
      }
      if (provider.getCount('Desi Ghee') > 0) {
        newdesi_ghee_price = provider.getCount('Desi Ghee') * desi_ghee_price;
        print('New Price is::$newdesi_ghee_price');
        desi_ghee_quantity = 1;
      } else {
        print('Price is nulll');
        newdesi_ghee_price = 0;
        desi_ghee_quantity = 0;
      }
      print('about to calculate');

      totalPrice = newbuffalo_milk_price +
          newcow_milk_price +
          newmix_milk_price +
          newyogurt_price +
          newbutter_price +
          newdesi_ghee_price +
          delivery_charges;
      print('Total Price is :$totalPrice');

      totalItems = buffalo_milk_quantity +
          cow_milk_quantity +
          mix_milk_quantity +
          yogurt_quantity +
          butter_quantity +
          desi_ghee_quantity;
      print('Total Quantity is :$totalItems');
    }
  }

  Future<void> CreateAnOrderInFireBase(
      BuildContext parentContext,
      var totalItemsPassed,
      var totalPricePassed,
      var orderIdPassed,
      String emailPassed,
      List<Map<dynamic, dynamic>> orderDetails) async {
    showDialog(
        context: parentContext,
        barrierDismissible: false,
        builder: (context) => Center(
              child: Lottie.asset('assets/animations/loading.json'),
            ));
    try {
      // await FirebaseFirestore.instance
      //     .collection('Orders')
      //     .doc('$orderIdPassed')
      //     .set({
      //   'orderMadeBy': emailPassed,
      //   'totalItems': totalItemsPassed,
      //   'totalPrice': totalPricePassed,

      await FirebaseFirestore.instance
          .collection('Orders')
          .doc('$orderIdPassed')
          .set({
        'Order Made By': emailPassed,
        'Total Ammount': totalPricePassed,
        'Total Items': totalItems,
        'order_details': orderDetails
            .map((item) => {
                  'item_name': item['item_name'],
                  'item_price': item['item_price'],
                  'item_quantity': item['item_quantity'],
                })
            .toList(),
      })

          // ;
          // for (var item in orderDetails) {
          //   await FirebaseFirestore.instance
          //       .collection('Orders')
          //       .doc('$orderIdPassed')
          //       .collection('orderDetails')
          //       .add({
          //     'itemName': item['item_name'],
          //     'itemQuantity': item['item_quantity'],
          //     'itemPrice': item['item_price'],
          //   })
          .then((value) {
        Provider.of<ShoppingItemProvider>(context, listen: false)
            .reset('Buffalo Milk');
        Provider.of<ShoppingItemProvider>(context, listen: false)
            .reset('Cow Milk');
        Provider.of<ShoppingItemProvider>(context, listen: false)
            .reset('Mix Milk');
        Provider.of<ShoppingItemProvider>(context, listen: false)
            .reset('Yogurt');
        Provider.of<ShoppingItemProvider>(context, listen: false)
            .reset('Butter');
        Provider.of<ShoppingItemProvider>(context, listen: false)
            .reset('Desi Ghee');

        Utils.toastMessage('Order Created SuccessFully');
        Navigator.of(parentContext).pop();
      });
      // }
    } catch (e) {
      print('Error adding order: $e');
      Utils.toastMessage('$e');
      Navigator.of(parentContext).pop();
    }

    Navigator.of(context).pop();
  }

  Future<PriceListModel?> getRealTimePricesFromDatabase() async {
    final docPrices =
        FirebaseFirestore.instance.collection('Price List').doc('items');
    final snapshot = await docPrices.get();

    if (snapshot.exists) {
      return PriceListModel.fromJson(snapshot.data()!);
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
