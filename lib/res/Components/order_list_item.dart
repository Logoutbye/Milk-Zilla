
import 'package:flutter/material.dart';
import 'package:milk_zilla/res/constanst.dart';

import '../../Model/order_item_model.dart';

class OrderListItem extends StatelessWidget {
  final OrderItemModel? item;

  const OrderListItem({Key? key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          const SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item!.name!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  height: 40.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // IconButton(
                        //   iconSize: 18.0,
                        //   padding: const EdgeInsets.all(2.0),
                        //   icon: const Icon(Icons.remove),
                        //   onPressed: item!.onPressedDecrement,
                        // ),
                        Text(
                          "${item!.quantity} ${item!.unit}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        // IconButton(
                        //   iconSize: 18.0,
                        //   padding: const EdgeInsets.all(2.0),
                        //   icon: const Icon(Icons.add),
                        //   onPressed: item!.onPressedIncrement,
                        // ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 10.0),
          Text(
            "Rs ${item!.price! * item!.quantity!}",
            style: priceTextStyle,
          ),
        ],
      ),
    );
  }
}
