import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:milk_zilla/View/Buyer_UI/Customer%20Orders%20With%20Shop/customer_orders_with_shop.dart';
import 'package:milk_zilla/View/Inspector_UI/Pick%20Orders/inspector_screen.dart';
import 'package:milk_zilla/View/Inspector_UI/Test%20Milk/test_milk_screen.dart';
import 'package:milk_zilla/View/Seller_UI/Buy%20Milk%20From%20Farm/buy_milk_from_farm_tabar.dart';
import 'package:milk_zilla/View/Seller_UI/Sell%20Milk%20To%20Customers/customers_orders.dart';

import '../../res/my_colors.dart';

class SellerDashboard extends StatefulWidget {
  const SellerDashboard({super.key});

  @override
  State<SellerDashboard> createState() => _SellerDashboardState();
}

class _SellerDashboardState extends State<SellerDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // first two buttons for registration
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  // row for two buttons
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      //Seller orders with Customer
                      InkWell(
                        onTap: () {
                          //Navigator.pop(context);
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return MyAllCustomerOrders();
                          }));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.4,
                          height: MediaQuery.of(context).size.height / 5,
                          decoration: BoxDecoration(
                            color: MyColors.kSecondary,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: MyColors.kBlack,
                                blurRadius: 15,
                                spreadRadius: 2,
                                offset: Offset(
                                  0,
                                  5,
                                ), // Shadow position
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageIcon(
                                  AssetImage("assets/images/shopping-cart.png"),
                                  size: 72,
                                  color: MyColors.kPrimary,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 70,
                                ),
                                Text(
                                  'Sell Milk',
                                  style: TextStyle(
                                      color: MyColors.kPrimary,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),

                      // Seller orders with Farm
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return BuyMilkFromFarmTabar();
                          }));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.4,
                          height: MediaQuery.of(context).size.height / 5,
                          decoration: BoxDecoration(
                            color: MyColors.kSecondary,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: MyColors.kBlack,
                                blurRadius: 15,
                                spreadRadius: 2,
                                offset: Offset(
                                  0,
                                  5,
                                ), // Shadow position
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageIcon(
                                  AssetImage("assets/images/seller.png"),
                                  size: 72,
                                  color: MyColors.kPrimary,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 70,
                                ),
                                Text('Buy Milk',
                                    style: TextStyle(
                                        color: MyColors.kPrimary,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ), // container for chating Doctor will move to next screen

                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
