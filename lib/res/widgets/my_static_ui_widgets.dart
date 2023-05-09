import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:milk_zilla/Model/order_model.dart';
import 'package:milk_zilla/controllers/Global_Controllers/update_status_global_controller.dart';
import 'package:milk_zilla/controllers/Inspector_Controllers/pick_order_controller.dart';
import 'package:milk_zilla/res/constanst.dart';
import '../../View/Buyer_UI/Customer Orders With Shop/customer_orders_with_shop.dart';
import '../../View/Inspector_UI/insector_screen.dart';
import '../../View/Seller_UI/Customer Orders/customers_orders.dart';
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
                  ? MediaQuery.of(context).size.height / 1.9
                  : MediaQuery.of(context).size.height / 2,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                              Text('Item ${index + 1}:'),
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
                status == 'Pending' || status == 'Prepared' || status == 'Shipped' 
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
                            UpdateStatusGlobalController()
                                .updateStatus(context, order, 'Canceled');
                            Navigator.pop(context);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    CustomerOrdersWithShop()));
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
                                UpdateStatusGlobalController()
                                    .updateStatus(context, order, 'Prepared');
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
                                        context, order, 'Shipped');
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
                                            onPressed: () {},
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
                                                      'Delivered');
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
