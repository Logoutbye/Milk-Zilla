import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/View/Buyer_UI/check_out_screen.dart';
import 'package:milk_zilla/View/Buyer_UI/price_list.dart';
import 'package:milk_zilla/View/Seller_UI/Shop%20Orders/check_out_for_farm.dart';
import 'package:milk_zilla/provider/Sopping_item_provider.dart';
import 'package:milk_zilla/res/Components/my_drawers/buyer_drawer.dart';
import 'package:milk_zilla/res/Components/my_drawers/seller_drawer.dart';
import 'package:provider/provider.dart';

import '../../../res/Components/create_an_order.dart';
import '../../../res/my_colors.dart';
import '../../Buyer_UI/Customer Orders With Shop/customer_orders_with_shop.dart';

class ReviewCartForFarm extends StatefulWidget {
  var getFormId;

  ReviewCartForFarm({required this.getFormId, super.key});

  @override
  State<ReviewCartForFarm> createState() => _ReviewCartForFarmState();
}

class _ReviewCartForFarmState extends State<ReviewCartForFarm> {
  // textfield controller s

  TextEditingController _controller250 = TextEditingController();
  TextEditingController _controller500 = TextEditingController();
  TextEditingController _controller1L = TextEditingController();

  var getShopId;

  @override
  void initState() {
    getShopId = widget.getFormId;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final milkProvider = Provider.of<ShoppingItemProvider>(context);
    print("build whole");
    return Scaffold(
      backgroundColor: MyColors.kWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // backgroundColor: Color.fromARGB(255, 255, 255, 255),
        // foregroundColor: MyColors.kPrimary,
        elevation: 0,
        backgroundColor: MyColors.kWhite,
        foregroundColor: MyColors.kPrimary,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10.0),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  backgroundColor: MyColors.kPrimary,
                ),
                child: Text(
                  'My Orders',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => CustomerOrdersWithShop()));
                },
              ),
            ),
          ],
        ),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: IconButton(
          //     icon: Icon(Icons.shopping_cart_checkout),
          //     iconSize: 35,
          //     onPressed: () {},
          //   ),
          // ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Builder(
                  builder: (context) => IconButton(
                        icon: Icon(Icons.settings),
                        iconSize: 40,
                        onPressed: () => Scaffold.of(context).openEndDrawer(),
                      )))
        ],
      ),
      endDrawer: SellerDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 6,
              // width: MediaQuery.of(context).size.width/1.4,
              child: Lottie.asset('assets/animations/feader.json'),
            ),
            Container(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: Theme.of(context).textTheme.labelSmall,
                    children: [
                      TextSpan(
                          text: 'Welcome to Milk Zilla\n',
                          style: TextStyle(
                              color: Color.fromARGB(255, 125, 199, 127),
                              fontSize: 16)),
                      TextSpan(
                          text: 'How can we serve you \ntoday?',
                          style: TextStyle(
                              color: MyColors.kPrimary,
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                    ]),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 54,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Text('Create an Order',
                      style: TextStyle(
                          color: MyColors.kBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Spacer(),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => priceList())),
                    child: Text('See Price List',
                        style: TextStyle(
                            color: MyColors.kPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Consumer<ShoppingItemProvider>(
              builder: (BuildContext context, value, Widget? child) {
                return Column(
                  children: [
                    // 250 ML
                    Container(
                      child: SingleChildScrollView(
                        //scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Milk Container 250 ML"),
                            Container(
                              width: 80,
                              height: 60,
                              // color: Colors.red,
                              child: TextField(
                                controller: _controller250,

                                onTap: () {},
                                keyboardType: TextInputType.number,
                                // inputFormatters: [
                                //   FilteringTextInputFormatter.digitsOnly,
                                // ],
                                style: TextStyle(
                                  color: MyColors.kBlack,
                                  // fontSize: 18,
                                ),
                                decoration: InputDecoration(
                                  hintText: '0',
                                  //labelText: 'Alpha',
                                  labelStyle:
                                      TextStyle(color: MyColors.kPrimary),
                                  hintStyle:
                                      TextStyle(color: MyColors.kPrimary),
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: MyColors.kSecondary),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyColors.kPrimary),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // 500 ML
                    Container(
                      child: SingleChildScrollView(
                        //scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Milk Container 500 ML"),
                            Container(
                              width: 80,
                              height: 60,
                              // color: Colors.red,
                              child: TextField(
                                controller: _controller500,

                                onTap: () {},
                                keyboardType: TextInputType.number,
                                // inputFormatters: [
                                //   FilteringTextInputFormatter.digitsOnly,
                                // ],
                                style: TextStyle(
                                  color: MyColors.kBlack,
                                  // fontSize: 18,
                                ),
                                decoration: InputDecoration(
                                  hintText: '0',
                                  //labelText: 'Alpha',
                                  labelStyle:
                                      TextStyle(color: MyColors.kPrimary),
                                  hintStyle:
                                      TextStyle(color: MyColors.kPrimary),
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: MyColors.kSecondary),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyColors.kPrimary),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // 1 L
                    Container(
                      child: SingleChildScrollView(
                        //scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Milk Container 1 L     "),
                            Container(
                              width: 80,
                              height: 60,
                              // color: Colors.red,
                              child: TextField(
                                controller: _controller1L,

                                onTap: () {},
                                keyboardType: TextInputType.number,
                                // inputFormatters: [
                                //   FilteringTextInputFormatter.digitsOnly,
                                // ],
                                style: TextStyle(
                                  color: MyColors.kBlack,
                                  // fontSize: 18,
                                ),
                                decoration: InputDecoration(
                                  hintText: '0',
                                  //labelText: 'Alpha',
                                  labelStyle:
                                      TextStyle(color: MyColors.kPrimary),
                                  hintStyle:
                                      TextStyle(color: MyColors.kPrimary),
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: MyColors.kSecondary),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyColors.kPrimary),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  backgroundColor: MyColors.kPrimary,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Review Cart',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward,
                      size: 33,
                    )
                  ],
                ),
                onPressed: () {
                  // int q250 = int.parse(_controller250.text);
                  // int q500 = int.parse(_controller500.text);

                  // int q1L = int.parse(_controller1L.text);

                  // print("values : $q1L ");

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CheckOutForFarm(
                            // quantity1L: q1L,
                            // quantity250ml: q250,
                            // quantity500ml: q500,
                            // farmid: getShopId,

                            quantity1L: _controller1L.text.isNotEmpty
                                ? int.parse(_controller1L.text)
                                : 0,
                            quantity250ml: _controller250.text.isNotEmpty
                                ? int.parse(_controller250.text)
                                : 0,
                            quantity500ml: _controller500.text.isNotEmpty
                                ? int.parse(_controller500.text)
                                : 0,
                            farmid: getShopId,
                          )));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemButton extends StatelessWidget {
  final String productType;
  final VoidCallback onPressed;

  ItemButton({required this.productType, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          width: MediaQuery.of(context).size.width / 5,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: MyColors.kshadow,
              blurRadius: 9,
              offset: Offset(2, 2), // Shadow position
            ),
          ], color: MyColors.kWhite, borderRadius: BorderRadius.circular(29)),
          child: Center(
              child: Text(
            productType,
            // style: TextStyle(color: MyColors.kWhite),
          ))),
    );
  }
}

class MilkCounter extends StatelessWidget {
  final String productType;
  final String unit;

  const MilkCounter({required this.productType, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$productType : ',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${Provider.of<ShoppingItemProvider>(context).getCount(productType)} $unit',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            // fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
