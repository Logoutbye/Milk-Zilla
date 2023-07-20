import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../Controllers/Buyer_Controllers/get_real_time_prices_from_database_for_creating_an_order.dart';
import '../../../Model/order_item_model.dart';
import '../../../Model/price_list_model.dart';
import '../../../controllers/Buyer_Controllers/create_an_order_controller.dart';
import '../../../res/Components/custom_divider.dart';
import '../../../res/Components/order_list_item.dart';
import '../../../res/constanst.dart';
import '../../../res/my_colors.dart';

class CheckOutForFarm extends StatefulWidget {
  CheckOutForFarm({
    super.key,
    required this.quantity250ml,
    required this.quantity500ml,
    required this.quantity1L,
    required this.farmid,
  });

  int quantity250ml;
  int quantity500ml;
  int quantity1L;
  String farmid;

  @override
  State<CheckOutForFarm> createState() => _CheckOutForFarmState();
}

class _CheckOutForFarmState extends State<CheckOutForFarm> {
  var totalPrice;
  var totalItems;

  final user = FirebaseAuth.instance.currentUser;

  var getUserName;
  
  var getUserAdress;
  @override
  void initState() {
    calculatetotalPricesandTotalItems();
    getDataOfLoginedUser();
    print('init total price is $totalPrice && total items are $totalItems');

    //getting prices from database
    getRealTimePricesFromDatabaseforCreatingAnOrderController()
        .getRealTimePricesFromDatabaseforCreatingAnOrderFromFarm();
    print('email of current user for order${user!.email}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // title: Text('Order Id ${generateOrderNumber}',style: TextStyle(color: MyColors.kPrimary),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.cancel,
                  size: 40,
                  color: MyColors.kPrimary,
                )),
          )
        ],
      ),
      body: FutureBuilder(
        future: getRealTimePricesFromDatabaseforCreatingAnOrderController()
            .getRealTimePricesFromDatabaseforCreatingAnOrderFromFarm(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Lottie.asset('assets/animations/loading.json',
                    height: MediaQuery.of(context).size.height / 5));
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
                    if (widget.quantity250ml > 0)
                      OrderListItem(
                        item: OrderItemModel(
                          name: "Milk",
                          unit: '250 ML',
                          quantity: widget.quantity250ml,
                          price: snapshot.data.quantity250ML,
                          onPressedDecrement: () {},
                          onPressedIncrement: () {},
                        ),
                      ),
                    if (widget.quantity500ml > 0)
                      OrderListItem(
                        item: OrderItemModel(
                          name: "Milk",
                          unit: '500 ML',
                          quantity: widget.quantity500ml,
                          price: snapshot.data.quantity500ML,
                          onPressedDecrement: () {},
                          onPressedIncrement: () {},
                        ),
                      ),
                    if (widget.quantity1L > 0)
                      OrderListItem(
                        item: OrderItemModel(
                          name: "Milk",
                          unit: 'Liter',
                          quantity: widget.quantity1L,
                          price: snapshot.data.quantity1L,
                          onPressedDecrement: () {},
                          onPressedIncrement: () {},
                        ),
                      ),
                    const SizedBox(height: 20.0),
                    totalItems == 0 ? SizedBox() : CustomDivider(),
                    const SizedBox(height: 20.0),
                    totalItems == 0
                        ? SizedBox()
                        : Row(
                            children: [
                              const SizedBox(width: 40.0),
                              Text(
                                totalItems == 1 ? 'Item' : "Items",
                                style: kTextStyleBlack,
                              ),
                              const Spacer(),
                              Text(
                                "${totalItems}",
                                style: kTextStyleBlack,
                              ),
                              const SizedBox(width: 20.0),
                            ],
                          ),
                    const SizedBox(height: 20.0),
                    CustomDivider(),
                    const SizedBox(height: 20.0),
                    totalPrice > snapshot.data.delivery_charges
                        ? Row(
                            children: [
                              const SizedBox(width: 40.0),
                              Text(
                                "Delivery Charges",
                                style: kTextStyleBlack,
                              ),
                              const Spacer(),
                              Text(
                                "Rs ${snapshot.data.delivery_charges}",
                                style: kTextStyleBlack,
                              ),
                              const SizedBox(width: 20.0),
                            ],
                          )
                        : Center(
                            child: Text(
                            'Must Select atleast one Item',
                            style: kTextStyleBlack,
                          )),
                    const SizedBox(height: 20.0),
                    CustomDivider(),
                    const SizedBox(height: 10.0),
                    totalPrice > snapshot.data.delivery_charges
                        ? Row(
                            children: [
                              const SizedBox(width: 40.0),
                              Text(
                                "Total",
                                style: kTextStyleBlack.copyWith(
                                    color: Colors.black),
                              ),
                              const Spacer(),
                              Text(
                                "Rs $totalPrice",
                                style: kTextStyleBlack.copyWith(
                                    color: MyColors.kPrimary),
                              ),
                              const SizedBox(width: 20.0),
                            ],
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 15,
                    ),
                    totalPrice > snapshot.data.delivery_charges
                        ? CustomDivider()
                        : SizedBox(),
                    totalPrice > snapshot.data.delivery_charges
                        ? CustomDivider()
                        : SizedBox(),
                    totalPrice > snapshot.data.delivery_charges
                        ? SizedBox(
                            height: 15,
                          )
                        : SizedBox(),
                    totalPrice > snapshot.data.delivery_charges
                        ? SizedBox(
                            height: 15,
                          )
                        : SizedBox(),
                    totalPrice > snapshot.data.delivery_charges
                        ? SizedBox(height: 10.0)
                        : SizedBox(),
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
                                if (widget.quantity250ml > 0)
                                  {
                                    'item_name': '250 ML Container',
                                    'item_quantity': widget.quantity250ml,
                                    'item_price': snapshot.data.quantity250ML,
                                  },
                                if (widget.quantity500ml > 0)
                                  {
                                    'item_name': '500 ML Container',
                                    'item_quantity': widget.quantity500ml,
                                    'item_price': snapshot.data.quantity500ML,
                                  },
                                if (widget.quantity1L > 0)
                                  {
                                    'item_name': '1 L Container',
                                    'item_quantity': widget.quantity1L,
                                    'item_price': snapshot.data.quantity1L,
                                  },
                              ];

                              CreateAnOrderController().createOrder(
                                  context,
                                  user!.email,
                                  getUserName,
                                  getUserAdress,
                                  snapshot.data.delivery_charges,
                                  orderDetails,
                                  // generateOrderNumber,
                                  '${widget.farmid}',
                                  'Pending',
                                  totalItems,
                                  totalPrice,
                                  //initial inspector id is empty
                                  '',
                                  // giveme lat
                                  '',
                                  // give me long
                                  '',
                                  'Orders With Farm');
                            } else {
                              Navigator.pop(context);
                            }
                          }),
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

  calculatetotalPricesandTotalItems() async {
    //calculate total items
    var litre_quantity = widget.quantity1L != 0 ? 1 : 0;
    var half_quantity = widget.quantity500ml != 0 ? 1 : 0;
    var quarter_quantity = widget.quantity250ml != 0 ? 1 : 0;
    totalItems = litre_quantity + half_quantity + quarter_quantity;
    print('after calculations total items =${totalItems}');
    //calculate total price

    //store prices from database
    var one_Liter_price;
    var half_Liter_price;
    var quarter_Liter_price;
    var delivery_charges;

    var new_one_Liter_price;
    var new_half_Liter_price;
    var new_quarter_Liter_price;
    var new_delivery_charges;

    // access database
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // get document reference
    DocumentReference documentReference =
        firestore.collection('Price List').doc('containers');
    // get document snapshot
    DocumentSnapshot documentSnapshot = await documentReference.get();
    // check if document exists
    if (documentSnapshot.exists) {
      // get document data
      Map<String, dynamic>? data =
          documentSnapshot.data() as Map<String, dynamic>?;

      // access specific fields
      one_Liter_price = data!['1 liter'];
      half_Liter_price = data['500 ml'];
      quarter_Liter_price = data['250 ml'];
      delivery_charges = data['delivery_charges'];
    }

    var litre_price =
        widget.quantity1L != 0 ? one_Liter_price * widget.quantity1L : 0;
    var half_price =
        widget.quantity500ml != 0 ? half_Liter_price * widget.quantity500ml : 0;
    var quarter_price = widget.quantity250ml != 0
        ? quarter_Liter_price * widget.quantity250ml
        : 0;
    totalPrice = litre_price + half_price + quarter_price + delivery_charges;

    // if (widget.quantity1L > 0) {
    //   new_one_Liter_price = one_Liter_price * widget.quantity1L;
    // } else {
    //   new_one_Liter_price = 0;
    // }
    // if (widget.quantity500ml > 0) {
    //   new_half_Liter_price = half_Liter_price * widget.quantity500ml;
    // } else {
    //   new_half_Liter_price = 0;
    // }
    // if (widget.quantity250ml > 0) {
    //   new_quarter_Liter_price = quarter_Liter_price * widget.quantity250ml;
    // } else {
    //   new_quarter_Liter_price = 0;
    // }

    // //caluculated prices
    // totalPrice = new_one_Liter_price +
    //     new_half_Liter_price +
    //     new_quarter_Liter_price +
    //     new_delivery_charges;
    // print('after calculations total prices =${totalPrice}');
  }

  // to get current user name customer id
  Future<PriceListModel?> getDataOfLoginedUser() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // get document reference
    DocumentReference documentReference =
        firestore.collection('Sellers').doc('${user!.email}');
    // get document snapshot
    DocumentSnapshot documentSnapshot = await documentReference.get();
    // check if document exists
    if (documentSnapshot.exists) {
      // get document data
      Map<String, dynamic>? data =
          documentSnapshot.data() as Map<String, dynamic>?;
      // access specific fields
      String user_name = data!['name'];
      String user_address = data['shop_adress'];
      getUserAdress = user_address;

      print('user_name${user_name}');
      getUserName = user_name;
      print('getUserName:$getUserName');
    }
    return null;
  }
}
