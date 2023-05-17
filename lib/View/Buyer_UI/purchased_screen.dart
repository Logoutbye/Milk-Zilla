import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/main.dart';

import '../../res/constanst.dart';
import '../../res/my_colors.dart';
import '../Seller_UI/Buy Milk From Farm/buy_milk_from_farm_tabar.dart';
import 'Customer Orders With Shop/customer_orders_with_shop_tabbar.dart';

class PurchasedScreen extends StatefulWidget {
  var result;
  var order_no;
  var orderCollectiontohelpfornavigation;
  PurchasedScreen(
      {required this.result,
      required this.order_no,
      super.key,
      required this.orderCollectiontohelpfornavigation});

  @override
  State<PurchasedScreen> createState() => _PurchasedScreenState();
}

class _PurchasedScreenState extends State<PurchasedScreen> {
  @override
  void initState() {
    print('${widget.result}');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 12),
          widget.result == 'successful'
              ? Lottie.asset('assets/animations/orderdone.json')
              : Lottie.asset('assets/animations/angry_cow.json',
                  height: MediaQuery.of(context).size.height / 2.5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    widget.result == 'successful'
                        ? 'Your Order has been \nConfrimed & Placed'
                        : 'Oops! Some thing went\nterribly wrong here',
                    style: kTextStyleBlack,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.result == 'successful' ? 'Your order number is' : '',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    widget.result == 'successful'
                        ? '${widget.order_no}'
                        : 'Please Try Again.',
                    style: kTextStyleBlack,
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 38.0),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      backgroundColor: MyColors.kPrimary,
                    ),
                    child: Text(
                      "My Dash Board",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    onPressed: () {
                      navigatorKey.currentState!
                          .popUntil((route) => route.isFirst);
                    },
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 38.0),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      backgroundColor: MyColors.kPrimary,
                    ),
                    child: Text(
                      widget.result == 'successful'
                          ? "My Order"
                          : "Order Again",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    onPressed: () {
                      if (widget.result == 'successful') {
                        navigatorKey.currentState!
                            .popUntil((route) => route.isFirst);
                        if (widget.orderCollectiontohelpfornavigation ==
                            'Orders') {
                              navigatorKey.currentState!
                            .popUntil((route) => route.isFirst);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CustomerOrdersWithShopTabBar()));
                        } else {
                            Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BuyMilkFromFarmTabar()));
                        }
                      } else {
                        Navigator.pop(context);
                      }
                      // navigatorKey.currentState!.popUntil((route) => route.isFirst);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
