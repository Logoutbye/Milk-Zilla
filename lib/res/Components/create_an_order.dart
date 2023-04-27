import 'package:flutter/material.dart';

import '../../View/Buyer_UI/buyer_screen.dart';

class CreateAnOrder extends StatelessWidget {
  var itemname;
  final VoidCallback onPressedIncrement;
  final VoidCallback onPressedDecrement;
  CreateAnOrder(
      {required this.itemname,
      required this.onPressedIncrement,
      required this.onPressedDecrement,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: MediaQuery.of(context).size.height / 19,
          width: MediaQuery.of(context).size.width / 1.1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MilkCounter(
                  productType: '$itemname',
                  unit: itemname == 'Buffalo Milk'
                      ? 'Litre'
                      : itemname == 'Cow Milk'
                          ? 'Litre'
                          : itemname == 'Mix Milk'
                              ? 'Litre'
                              : itemname == 'Yogurt'
                                  ? 'KG'
                                  : itemname == 'Butter'
                                      ? 'KG'
                                      : itemname == 'Desi Ghee'
                                          ? 'KG'
                                          : '',
                ),
                Spacer(),
                IconButton(
                    iconSize: 18.0,
                    padding: const EdgeInsets.all(2.0),
                    icon: const Icon(Icons.remove),
                    onPressed: onPressedDecrement),
                Spacer(),
                IconButton(
                    iconSize: 18.0,
                    padding: const EdgeInsets.all(2.0),
                    icon: const Icon(Icons.add),
                    onPressed: onPressedIncrement),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
