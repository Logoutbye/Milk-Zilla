import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:milk_zilla/res/Components/my_drawer.dart';
import 'package:milk_zilla/res/Components/my_drawers/seller_drawer.dart';

class SellerScreen extends StatefulWidget {
  const SellerScreen({super.key});

  @override
  State<SellerScreen> createState() => _BuyerScreenState();
}

class _BuyerScreenState extends State<SellerScreen> {
  String shopId = 'shop id';

  @override
  void initState() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final email = user.email;
      print('email::${email}');
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Seller screeen')),
        drawer: SellerDrawer(),
        body: FutureBuilder<List<Order>>(
          future: getOrdersForShop(shopId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              List<Order> orders = snapshot.data!;
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  Order order = orders[index];
                  // TODO: Build UI for each order
                  return buildOrderUI(context, order);
                },
              );
            } else {
              return Text('No orders found');
            }
          },
        )
        /////////////////////////////////////////////////////////////////////////
        // this is where it worked just fine i might need it
        //     FutureBuilder<List<Map<String, dynamic>>>(
        //   future: getOrdersForShop(shopId),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //     if (snapshot.hasError) {
        //       return Center(
        //         child: Text('Error retrieving orders'),
        //       );
        //     }
        //     List<Map<String, dynamic>> orders = snapshot.data ?? [];
        //     return ListView.builder(
        //       itemCount: orders.length,
        //       itemBuilder: (context, index) {
        //         Map<String, dynamic> order = orders[index];
        //         return ListTile(
        //           title: Text('Status #${order['status']}'),
        //           subtitle: Text('Shop Id: ${order['shop_id']}'),
        //         );
        //       },
        //     );
        //   },
        // ),

        ////////////////////////////////////////////////////////////////////
        );
  }

  Widget buildOrderUI(BuildContext context, Order order) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${order.id}'),
            SizedBox(height: 8.0),
            Text('Customer ID: ${order.customerId}'),
            SizedBox(height: 8.0),
            Text('Shop ID: ${order.shopId}'),
            SizedBox(height: 8.0),
            Text('Status: ${order.status}'),
            SizedBox(height: 8.0),
            Text('Timestamp: ${order.timestamp.toString()}'),
            SizedBox(height: 8.0),
            Text('Items:'),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: order.items.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Item ${index + 1}:'),
                    Text('Name: ${order.items[index]['name']}'),
                    Text('Price: ${order.items[index]['price']}'),
                    Text('Quantity: ${order.items[index]['quantity']}'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Order>> getOrdersForShop(String shopId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Orders')
          .where('shop_id', isEqualTo: shopId)
          .get();
      List<Order> orders =
          querySnapshot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
      return orders;
    } catch (e) {
      print('Error getting orders for shop: $e');
      return [];
    }
  }

  // Future<List<Map<String, dynamic>>> getOrdersForShop(String shopId) async {
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //         await FirebaseFirestore.instance
  //             .collection('orders')
  //             .where('shop_id', isEqualTo: shopId)
  //             .get();
  //     List<Map<String, dynamic>> orderList = [];
  //     for (QueryDocumentSnapshot<Map<String, dynamic>> snapshot
  //         in querySnapshot.docs) {
  //       Map<String, dynamic> orderData = snapshot.data();
  //       orderList.add(orderData);
  //     }
  //     return orderList;
  //   } catch (e) {
  //     print('Error retrieving orders for shop: $e');
  //     return [];
  //   }
  // }
}

class Order {
  String id;
  String customerId;
  String shopId;
  String status;
  List<Map<String, dynamic>> items;
  DateTime timestamp;

  Order({
    required this.id,
    required this.customerId,
    required this.shopId,
    required this.status,
    required this.items,
    required this.timestamp,
  });

  factory Order.fromSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Order(
      id: doc.id,
      customerId: data['customer_id'],
      shopId: data['shop_id'],
      status: data['status'],
      items: List<Map<String, dynamic>>.from(data['items']),
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}
