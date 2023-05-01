import 'package:flutter/material.dart';
import 'package:milk_zilla/Model/order_model.dart';
import 'package:milk_zilla/res/constanst.dart';
import '../my_colors.dart';

class MyStaticUIWidgets {
  static Widget buildOrderUI2(
      BuildContext context, OrderModel order, var status) {
    var heightbetweenWidgetsInOrder = MediaQuery.of(context).size.height / 95;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 1.2,
          height: status == 'Pending'
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
                          Text('${order.order_id}'),
                          Divider(),
                          Text('${order.customerName}'),
                          Divider(),
                          Text('${order.delivery_address}'),
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
                      height: MediaQuery.of(context).size.height / 7,
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
                status == 'Pending'
                    ? SizedBox(
                        height: heightbetweenWidgetsInOrder,
                      )
                    : SizedBox(),
                //Pickup Button
                status == 'Pending'
                    ? Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.6,
                          height: MediaQuery.of(context).size.height / 30,
                          decoration: BoxDecoration(
                            color: MyColors.kPrimary,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: MyColors.kPrimary,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Pick UP ${order.status}',
                              style: kTextStyleWhite,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
