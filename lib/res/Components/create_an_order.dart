import 'package:flutter/material.dart';
import 'package:milk_zilla/res/my_colors.dart';

import '../../View/Buyer_UI/review_cart.dart';

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
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: IconButton(
                        iconSize: 18.0,
                        padding: const EdgeInsets.all(2.0),
                        icon: const Icon(
                          Icons.remove_circle,
                          size: 25,
                          color: MyColors.kPrimary,
                        ),
                        onPressed: onPressedDecrement),
                  ),
                  Spacer(),
                  MilkCounter(
                    productType: '$itemname',
                    unit: itemname == 'Buffalo Milk'
                        ? 'L'
                        : itemname == 'Cow Milk'
                            ? 'L'
                            : itemname == 'Mix Milk'
                                ? 'L'
                                : itemname == 'Yogurt'
                                    ? 'KG'
                                    : itemname == 'Butter'
                                        ? 'KG'
                                        : itemname == 'Desi Ghee'
                                            ? 'KG'
                                            : '',
                  ),
                  // Spacer(),
                  // IconButton(
                  //     iconSize: 18.0,
                  //     padding: const EdgeInsets.all(2.0),
                  //     icon: const Icon(Icons.remove),
                  //     onPressed: onPressedDecrement),
                  Spacer(),
                  IconButton(
                      iconSize: 18.0,
                      padding: const EdgeInsets.all(2.0),
                      // icon: const Icon(Icons.add),
                      icon: const Icon(
                        Icons.add_circle,
                        size: 25,
                        color: MyColors.kPrimary,
                      ),
                      onPressed: onPressedIncrement),
                ],
              ),
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
