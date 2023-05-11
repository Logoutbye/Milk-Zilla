import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/Controllers/Buyer_Controllers/get_real_time_prices_from_database_for_creating_an_order.dart';
import 'package:milk_zilla/Utils/utils.dart';
import 'package:milk_zilla/res/Components/custom_divider.dart';
import 'package:milk_zilla/res/Components/error_screen.dart';
import 'package:milk_zilla/res/constanst.dart';
import 'package:milk_zilla/res/my_colors.dart';
import 'package:provider/provider.dart';

import '../../Model/order_item_model.dart';
import '../../Model/price_list_model.dart';
import '../../controllers/Buyer_Controllers/create_an_order_controller.dart';
import '../../provider/Sopping_item_provider.dart';
import '../../res/Components/order_list_item.dart';

class CheckOutScreen extends StatefulWidget {
  var getShopId;

  // static const String path = "lib/src/pages/food/food_checkout.dart";

  CheckOutScreen({required this.getShopId, super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  var totalPrice;
  var totalItems;
  var generateOrderNumber = MyStaticComponents.generateOrderNumber();
  final user = FirebaseAuth.instance.currentUser;
  TextEditingController deliveryAddressController =
      TextEditingController(text: '');
  TextEditingController InstructionTextController = TextEditingController();

  var getUserName;

  var getShopId;

  // latitude and longitude for storing in firebase
  double latitudeofuser = 0.0;
  double longitudeofuser = 0.0;

  @override
  void initState() {
    getShopId = widget.getShopId;
    getDataOfLoginedUser();
    print('init total price is $totalPrice && total items are $totalItems');
    calculatetotalPricesandTotalItems();

    //getting prices from database
    getRealTimePricesFromDatabaseforCreatingAnOrderController()
        .getRealTimePricesFromDatabaseforCreatingAnOrder();

    print('unique order number for order:: $generateOrderNumber');
    print('email of current user for order${user!.email}');
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
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: IconButton(
                onPressed: () {
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
                  totalItems = 0;
                  totalPrice = 0;
                  deliveryAddressController.clear();
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
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: getRealTimePricesFromDatabaseforCreatingAnOrderController()
            .getRealTimePricesFromDatabaseforCreatingAnOrder(),
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
                    // Pick Location
                    totalPrice > snapshot.data.delivery_charges
                        ? Container(
                            // color: Colors.red,
                            child: TextField(
                              controller: deliveryAddressController,
                              obscureText: false,
                              readOnly: true,
                              onTap: () {
                                Navigator.pushNamed(context,
                                        '/setCustomerAddressOnGoogleMap')
                                    .then((result) async {
                                  List<double> myLatLang =
                                      result as List<double>;
                                  latitudeofuser = myLatLang[0];
                                  longitudeofuser = myLatLang[1];

                                  // converting latlang to String address
                                  List<Placemark> placemarks =
                                      await placemarkFromCoordinates(
                                          latitudeofuser, longitudeofuser);
                                  var deliverFullAddress =
                                      "${placemarks.reversed.last.subLocality}  ${placemarks.reversed.last.locality}, ${placemarks.reversed.last.administrativeArea}";
                                  deliveryAddressController.text =
                                      deliverFullAddress;

                                  //===============================
                                  setState(() {});
                                  Utils.flushBarErrorMessage(
                                      'latidtude and longitude: ${myLatLang[0]} ${myLatLang[1]}',
                                      context);
                                });
                                // Navigator.pushNamed(context,
                                //         '/setCustomerAddressOnGoogleMap')
                                //     .then((result) {
                                //   List<double> myLatLang =
                                //       result as List<double>;
                                //   latitudeofuser = myLatLang[0];
                                //   longitudeofuser = myLatLang[1];
                                //   setState(() {});
                                //   Utils.flushBarErrorMessage(
                                //       'latidtude and longitude: ${myLatLang[0]} ${myLatLang[1]}',
                                //       context);
                                // });
                              },
                              style: TextStyle(
                                color: MyColors.kBlack,
                                // fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Street/Muhllah/city',
                                labelText: 'Enter Delivery Location',
                                labelStyle: TextStyle(color: MyColors.kPrimary),
                                hintStyle: TextStyle(color: MyColors.kPrimary),
                                enabledBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 193, 198, 198),
                                    //Color.fromARGB(255, 115, 38, 38),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.kPrimary),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: Icon(
                                  Icons.location_pin,
                                  // color:
                                  //     MyColors.kPrimary,
                                  // size: 25,
                                ),
                              ),
                            ),
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
                                if (provider.getCount('Buffalo Milk') > 0)
                                  {
                                    'item_name': 'Buffalo Milk',
                                    'item_quantity':
                                        provider.getCount('Buffalo Milk'),
                                    'item_price': snapshot.data.buffalo_milk *
                                        provider.getCount('Buffalo Milk'),
                                  },
                                if (provider.getCount('Cow Milk') > 0)
                                  {
                                    'item_name': 'Cow Milk',
                                    'item_quantity':
                                        provider.getCount('Cow Milk'),
                                    'item_price': snapshot.data.cow_milk *
                                        provider.getCount('Cow Milk'),
                                  },
                                if (provider.getCount('Mix Milk') > 0)
                                  {
                                    'item_name': 'Mix Milk',
                                    'item_quantity':
                                        provider.getCount('Mix Milk'),
                                    'item_price': snapshot.data.mix_milk *
                                        provider.getCount('Mix Milk'),
                                  },
                                if (provider.getCount('Yogurt') > 0)
                                  {
                                    'item_name': 'Yogurt',
                                    'item_quantity':
                                        provider.getCount('Yogurt'),
                                    'item_price': snapshot.data.yougurt *
                                        provider.getCount('Yogurt'),
                                  },
                                if (provider.getCount('Butter') > 0)
                                  {
                                    'item_name': 'Butter',
                                    'item_quantity':
                                        provider.getCount('Butter'),
                                    'item_price': snapshot.data.butter *
                                        provider.getCount('Butter'),
                                  },
                                if (provider.getCount('Desi Ghee') > 0)
                                  {
                                    'item_name': 'Desi Ghee',
                                    'item_quantity':
                                        provider.getCount('Desi Ghee'),
                                    'item_price': snapshot.data.desi_ghee *
                                        provider.getCount('Desi Ghee'),
                                  },
                              ];

                              if (totalPrice > snapshot.data.delivery_charges) {
                                List<Map<dynamic, dynamic>> orderDetails = [
                                  if (provider.getCount('Buffalo Milk') > 0)
                                    {
                                      'item_name': 'Buffalo Milk',
                                      'item_quantity':
                                          provider.getCount('Buffalo Milk'),
                                      'item_price': snapshot.data.buffalo_milk *
                                          provider.getCount('Buffalo Milk'),
                                    },
                                  if (provider.getCount('Cow Milk') > 0)
                                    {
                                      'item_name': 'Cow Milk',
                                      'item_quantity':
                                          provider.getCount('Cow Milk'),
                                      'item_price': snapshot.data.cow_milk *
                                          provider.getCount('Cow Milk'),
                                    },
                                  if (provider.getCount('Mix Milk') > 0)
                                    {
                                      'item_name': 'Mix Milk',
                                      'item_quantity':
                                          provider.getCount('Mix Milk'),
                                      'item_price': snapshot.data.mix_milk *
                                          provider.getCount('Mix Milk'),
                                    },
                                  if (provider.getCount('Yogurt') > 0)
                                    {
                                      'item_name': 'Yogurt',
                                      'item_quantity':
                                          provider.getCount('Yogurt'),
                                      'item_price': snapshot.data.yougurt *
                                          provider.getCount('Yogurt'),
                                    },
                                  if (provider.getCount('Butter') > 0)
                                    {
                                      'item_name': 'Butter',
                                      'item_quantity':
                                          provider.getCount('Butter'),
                                      'item_price': snapshot.data.butter *
                                          provider.getCount('Butter'),
                                    },
                                  if (provider.getCount('Desi Ghee') > 0)
                                    {
                                      'item_name': 'Desi Ghee',
                                      'item_quantity':
                                          provider.getCount('Desi Ghee'),
                                      'item_price': snapshot.data.desi_ghee *
                                          provider.getCount('Desi Ghee'),
                                    },
                                ];

                                if (latitudeofuser != 0.0 &&
                                    longitudeofuser != 0.0) {
                                  CreateAnOrderController().createOrder(
                                      context,
                                      user!.email,
                                      getUserName,
                                      deliveryAddressController.text,
                                      snapshot.data.delivery_charges,
                                      orderDetails,
                                      // generateOrderNumber,
                                      '${getShopId}',
                                      'Pending',
                                      totalItems,
                                      totalPrice,
                                      //initial inspector id is empty
                                      '',
                                      // giveme lat
                                      latitudeofuser,
                                      // give me long
                                      longitudeofuser,
                                      'Orders');
                                } else {
                                  Utils.flushBarErrorMessage(
                                      'Please Select Delivery Location',
                                      context);
                                }
                              } else {
                                Navigator.pop(context);
                              }
                            }
                            ;
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
    final provider = Provider.of<ShoppingItemProvider>(context, listen: false);
    //store prices from database
    var buffalo_milk_price;
    var cow_milk_price;
    var mix_milk_price;
    var yogurt_price;
    var butter_price;
    var desi_ghee_price;
    var delivery_charges;

    // calculate new prices by multiplying prices from database and quantity
    var newbuffalo_milk_price;
    var newcow_milk_price;
    var newmix_milk_price;
    var newyogurt_price;
    var newbutter_price;
    var newdesi_ghee_price;

    // store quantity in it
    var buffalo_milk_quantity;
    var cow_milk_quantity;
    var mix_milk_quantity;
    var yogurt_quantity;
    var butter_quantity;
    var desi_ghee_quantity;

    // access database
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

      //calculate prices as well as get total items
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

  // to get current user name customer id
  Future<PriceListModel?> getDataOfLoginedUser() async {
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
      String user_name = data!['name'];
      print('user_name${user_name}');
      getUserName = user_name;
      print('getUserName:$getUserName');
    }
  }
}
