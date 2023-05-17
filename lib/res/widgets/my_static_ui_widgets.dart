import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:milk_zilla/Model/order_model.dart';
import 'package:milk_zilla/Utils/utils.dart';
import 'package:milk_zilla/View/Inspector_UI/customer_delivery_location.dart';
import 'package:milk_zilla/controllers/Inspector_Controllers/pick_order_controller.dart';
import 'package:milk_zilla/helper.dart';
import 'package:milk_zilla/res/constanst.dart';
import 'package:milk_zilla/res/widgets/report_viewer_screen.dart';
import '../../Controllers/Global_Controllers/update_status_global_controller.dart';
import '../../View/Buyer_UI/Customer Orders With Shop/customer_orders_with_shop_tabbar.dart';
import '../../View/Farm_UI/farm_orders.dart';
import '../../View/Inspector_UI/Pick Orders/inspector_screen.dart';
import '../../View/Inspector_UI/Test Milk/test_milk_screen_tab_bar.dart';
import '../../View/Seller_UI/Buy Milk From Farm/buy_milk_from_farm_tabar.dart';
import '../../View/Seller_UI/Sell Milk To Customers/customers_orders.dart';
import '../../controllers/Inspector_Controllers/test_orders_for_shop_controller.dart';
import '../my_colors.dart';

class MyStaticUIWidgets {
  static Widget buildOrderUI2(
      BuildContext context, OrderModel order, var status, var role) {
    var heightbetweenWidgetsInOrder = MediaQuery.of(context).size.height / 95;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 1.2,
          height:
              status == 'Pending' || status == 'Prepared' || status == 'Shipped'
                  ? MediaQuery.of(context).size.height / 1.6
                  : MediaQuery.of(context).size.height / 1.7,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 status != 'ReadyForTesting'
                    ? Row(
                        children: [
                          SizedBox(),
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ViewMilkReport()));
                              },
                              icon: Icon(
                                Icons.report_gmailerrorred_rounded,
                                color: MyColors.kPrimary,
                              ))
                        ],
                      )
                    : SizedBox(),
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
                            child: Text('${order.status}',
                                style:
                                    TextStyle(fontWeight: FontWeight.bold)))),
                  ],
                ),
                SizedBox(
                  height: heightbetweenWidgetsInOrder,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Order ID:'),
                          Divider(),
                          Text('Customer Name:'),
                          Divider(),
                          Text('Delivery Address'),
                          Divider(),
                          Text('Total Price'),
                          Divider(),
                          Text('Order PlacementTime'),
                        ],
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: [
                                Text('${order.order_id}'),
                              ],
                            ),
                          ),
                          Divider(),
                          Text('${order.customerName}'),
                          Divider(),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: [
                                Text('${order.delivery_address}'),
                              ],
                            ),
                          ),
                          Divider(),
                          Text('${order.total_price}'),
                          Divider(),
                          Text(
                              '${order.timestamp.hour.toString()}:${order.timestamp.minute.toString()}'
                              ' ${order.timestamp.day.toString()}/${order.timestamp.month.toString()}/${order.timestamp.year.toString()}'),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: heightbetweenWidgetsInOrder,
                ),
                //Status

                ExpansionTile(
                  initiallyExpanded: true,
                  title: Text('View Order Details(${order.total_items})'),
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 8,
                      child: ListView.builder(
                        shrinkWrap: true,
                        // scrollDirection: Axis.vertical,
                        itemCount: order.items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Item : ${index + 1}'),
                              Text('Name: ${order.items[index]['item_name']}'),
                              Text(
                                  'Price: ${order.items[index]['item_price']}'),
                              Text(
                                  'Quantity: ${order.items[index]['item_quantity']}'),
                              // SizedBox(
                              //   height: heightbetweenWidgetsInOrder,
                              // ),
                              Divider()
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
                status == 'Pending' ||
                        status == 'Prepared' ||
                        status == 'Shipped'
                    ? SizedBox(
                        height: heightbetweenWidgetsInOrder,
                      )
                    : SizedBox(),
                //Pickup Button
                // if user is Customer he can cancel the order when its status is still pending
                role == 'Buyer' && status == 'Pending'
                    ? Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(10.0),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            backgroundColor: MyColors.kPrimary,
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          onPressed: () {
                            UpdateStatusGlobalController().updateStatus(
                                context, order, 'Canceled', 'Orders');
                            Navigator.pop(context);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    CustomerOrdersWithShopTabBar()));
                          },
                        ),
                      )
                    //  if the user us Seller and the status is pending he can prepare the order
                    //so that inspector can pick it up from shop and deliver to customer
                    : role == 'Seller' && status == 'Pending'
                        ? Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(10.0),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                backgroundColor: MyColors.kPrimary,
                              ),
                              child: Text(
                                'Pick Up',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                              onPressed: () {
                                UpdateStatusGlobalController().updateStatus(
                                    context, order, 'Prepared', 'Orders');
                                Navigator.pop(context);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        MyAllCustomerOrders()));
                              },
                            ),
                          )
                        : role == 'Inspector' && status == 'Prepared'
                            ? Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(10.0),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    backgroundColor: MyColors.kPrimary,
                                  ),
                                  child: Text(
                                    'Pick Up',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  onPressed: () {
                                    UpdateStatusGlobalController().updateStatus(
                                        context, order, 'Shipped', 'Orders');
                                    final user =
                                        FirebaseAuth.instance.currentUser;
                                    final email = user!.email;
                                    print('current users email::${email}');

                                    //order is picked by
                                    PickOderController()
                                        .PickOder(context, order, email);

                                    Navigator.pop(context);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                InspectorScreen()));
                                  },
                                ),
                              )
                            : role == 'Inspector' && status == 'Shipped'
                                ? Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Center(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0)),
                                              backgroundColor:
                                                  MyColors.kPrimary,
                                            ),
                                            child: Text(
                                              'Delivery Location',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return CustomerDeliveryLocation(
                                                    latitudeOfCustomer:
                                                        order.lat,
                                                    longitudeOfCustomer:
                                                        order.long,
                                                    customerName:
                                                        order.customerName);
                                              }));
                                            },
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Center(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0)),
                                              backgroundColor:
                                                  MyColors.kPrimary,
                                            ),
                                            child: Text(
                                              'Deliver',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            onPressed: () {
                                              UpdateStatusGlobalController()
                                                  .updateStatus(context, order,
                                                      'Delivered', 'Orders');
                                              Navigator.pop(context);
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          InspectorScreen()));
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : role == 'Farmer' && status == 'Pending'
                                    ? Center(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.all(10.0),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0)),
                                            backgroundColor: MyColors.kPrimary,
                                          ),
                                          child: Text(
                                            'Pick Up',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                          onPressed: () {
                                            UpdateStatusGlobalController()
                                                .updateStatus(
                                                    context,
                                                    order,
                                                    'Prepared',
                                                    'Orders With Farm');
                                            Navigator.pop(context);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FarmOrders()));
                                          },
                                        ),
                                      )
                                    : role == 'SellerBuyingMilkForShop' &&
                                            status == 'Pending'
                                        ? Center(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0)),
                                                backgroundColor:
                                                    MyColors.kPrimary,
                                              ),
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                              onPressed: () {
                                                UpdateStatusGlobalController()
                                                    .updateStatus(
                                                        context,
                                                        order,
                                                        'Canceled',
                                                        'Orders With Farm');
                                                Navigator.pop(context);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BuyMilkFromFarmTabar()));
                                              },
                                            ),
                                          )
                                        : role == 'MilkTestor' &&
                                                status == 'ReadyForTesting'
                                            ? Center(
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0)),
                                                    backgroundColor:
                                                        MyColors.kPrimary,
                                                  ),
                                                  child: Text(
                                                    'Test Milk',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.0,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    // when raised button is pressed
                                                    // we display showModalBottomSheet
                                                    showModalBottomSheet<void>(
                                                      // context and builder are
                                                      // required properties in this widget
                                                      context: context,
                                                      backgroundColor:
                                                          MyColors.kSecondary,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.vertical(
                                                                  top: Radius
                                                                      .circular(
                                                                          25))),
                                                      builder: (BuildContext
                                                          context) {
                                                        // we set up a container inside which
                                                        // we create center column and display text

                                                        // Returning SizedBox instead of a Container
                                                        return SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              6,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(18.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Center(
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: <Widget>[
                                                                      Text(
                                                                        'Not-Approved',
                                                                        style: TextStyle(
                                                                            color:
                                                                                MyColors.kPrimary,
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                      IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            final user =
                                                                                FirebaseAuth.instance.currentUser;
                                                                            final email =
                                                                                user!.email;
                                                                            print('current users email::${email}');

                                                                            TestOrderController().TestOrder(
                                                                                context,
                                                                                order,
                                                                                email,
                                                                                'Orders With Farm',
                                                                                'Canceled',
                                                                                'Not-Approved',
                                                                                '${NotApprovedReportPdfLink}');

                                                                            Navigator.pop(context);
                                                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestMilkScreenTabbar()));
                                                                          },
                                                                          icon:
                                                                              Icon(
                                                                            Icons.cancel_outlined,
                                                                            size:
                                                                                30,
                                                                            color:
                                                                                MyColors.kPrimary,
                                                                          ))
                                                                    ],
                                                                  ),
                                                                ),
                                                                Spacer(),
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: <Widget>[
                                                                    Text(
                                                                      'Approved',
                                                                      style: TextStyle(
                                                                          color: MyColors
                                                                              .kPrimary,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          final user = FirebaseAuth
                                                                              .instance
                                                                              .currentUser;
                                                                          final email =
                                                                              user!.email;
                                                                          print(
                                                                              'current users email::${email}');

                                                                          TestOrderController().TestOrder(
                                                                              context,
                                                                              order,
                                                                              email,
                                                                              'Orders With Farm',
                                                                              'Shipped',
                                                                              'Approved',
                                                                              '${ApprovedReportPdfLink}');

                                                                          Navigator.pop(
                                                                              context);
                                                                          Navigator.of(context)
                                                                              .push(MaterialPageRoute(builder: (context) => TestMilkScreenTabbar()));
                                                                        },
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .done,
                                                                          size:
                                                                              30,
                                                                          color:
                                                                              MyColors.kPrimary,
                                                                        ))
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              )
                                            : role == 'MilkTestor' &&
                                                    status == 'Shipped'
                                                ? Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: Center(
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          elevation: 0,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0)),
                                                          backgroundColor:
                                                              MyColors.kPrimary,
                                                        ),
                                                        child: Text(
                                                          'Deliver',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18.0,
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          UpdateStatusGlobalController()
                                                              .updateStatus(
                                                                  context,
                                                                  order,
                                                                  'Delivered',
                                                                  'Orders With Farm');
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          TestMilkScreenTabbar()));
                                                        },
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox(),

                // InkWell(
                //     onTap: () {
                //       print('hittig the button pickup');
                //
                //     },
                //     child: Center(
                //       child: Container(
                //         width: MediaQuery.of(context).size.width / 1.6,
                //         height: MediaQuery.of(context).size.height / 30,
                //         decoration: BoxDecoration(
                //           color: MyColors.kPrimary,
                //           borderRadius: BorderRadius.circular(10),
                //           boxShadow: [
                //             BoxShadow(
                //               color: MyColors.kPrimary,
                //             ),
                //           ],
                //         ),
                //         child: Center(
                //           child: Text(
                //             'Pick UP ${order.status}',
                //             style: kTextStyleWhite,
                //           ),
                //         ),
                //       ),
                //     ),
                //   )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> updateField(
  //     String docId, String fieldName, dynamic value) async {
  //   await FirebaseFirestore.instance
  //       .collection('Orders')
  //       .doc()
  //       .update({fieldName: value}).catchError(
  //           (error) => print('Failed to update field: $error'));
  // }
}
