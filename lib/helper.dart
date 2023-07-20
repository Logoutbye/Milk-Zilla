// The next step would be to implement the logic for the shop owner and delivery boy to access the orders.
// Here are the steps you can follow:

// Shop Owner Access: The shop owner should be able to view all the orders that have been placed from their shop.
//You can implement this by querying the "orders" collection in Firestore for all documents where the shop_id field matches
//the ID of the shop owner's shop. You can use the get method to retrieve the documents that match the query, and then display
//the orders to the shop owner in your app.

// Delivery Boy Access: The delivery boy should be able to view all the orders that they need to deliver. You can implement
//this by querying the "orders" collection in Firestore for all documents where the status field is "out_for_delivery".
// You can use the get method to retrieve the documents that match the query, and then display the orders to the delivery boy in your app.

// To implement these functionalities, you can create separate functions for querying the "orders" collection in Firestore and
//retrieving the orders based on the criteria. Here is some sample code to retrieve the orders for the shop owner and delivery boy:

// import 'package:cloud_firestore/cloud_firestore.dart';

// // This function retrieves all orders placed from a specific shop.
// Future<List<DocumentSnapshot>> getOrdersForShop(String shopId) async {
//   try {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection('orders')
//         .where('shop_id', isEqualTo: shopId)
//         .get();
//     List<DocumentSnapshot> documents = querySnapshot.docs;
//     return documents;
//   } catch (e) {
//     print('Error retrieving orders for shop: $e');
//     return null;
//   }
// }

// // This function retrieves all orders that are out for delivery.
// Future<List<DocumentSnapshot>> getOrdersForDelivery() async {
//   try {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection('orders')
//         .where('status', isEqualTo: 'out_for_delivery')
//         .get();
//     List<DocumentSnapshot> documents = querySnapshot.docs;
//     return documents;
//   } catch (e) {
//     print('Error retrieving orders for delivery: $e');
//     return null;
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:milk_zilla/res/constanst.dart';
// // import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// class reportScreen extends StatefulWidget {
//   const reportScreen({super.key});

//   @override
//   State<reportScreen> createState() => _reportScreenState();
// }

// class _reportScreenState extends State<reportScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Stataus: Approved'),
//         ),
//         body: Center(
//           child: Container(child: Image.network(ApprovedReportPhotoLink)),
//         ));
//   }
// }



import 'package:flutter/material.dart';
import 'package:milk_zilla/View/Auth%20UI/registration_screen.dart';

import '../../../res/Components/round_button.dart';
import '../../../res/my_colors.dart';

class CreateMilkReport extends StatefulWidget {
  const CreateMilkReport({super.key});

  @override
  State<CreateMilkReport> createState() => _CreateMilkReportState();
}

class _CreateMilkReportState extends State<CreateMilkReport> {
  TextEditingController tempratureTextController = TextEditingController();
  TextEditingController colorTextController = TextEditingController();
  TextEditingController odorTextController = TextEditingController();
  TextEditingController acidityTextController = TextEditingController();
  TextEditingController clarityTextController = TextEditingController();
  TextEditingController fatTextController = TextEditingController();
  TextEditingController protienContentTextController = TextEditingController();
  TextEditingController BacterialTextController = TextEditingController();
  TextEditingController AntibioticTextController = TextEditingController();
  TextEditingController freezingPointTextController = TextEditingController();
  List<List<String>> dropdownValues = [
    ['Option 1-1', 'Option 1-2', 'Option 1-3'],
    ['Option 2-1', 'Option 2-2', 'Option 2-3', 'Option 2-4'],
    ['Option 3-1', 'Option 3-2', 'Option 3-3'],
    ['Option 4-1', 'Option 4-2', 'Option 4-3', 'Option 4-4', 'Option 4-5'],
    ['Option 5-1', 'Option 5-2', 'Option 5-3'],
    ['Option 6-1', 'Option 6-2', 'Option 6-3', 'Option 6-4'],
    ['Option 7-1', 'Option 7-2', 'Option 7-3'],
    ['Option 8-1', 'Option 8-2', 'Option 8-3', 'Option 8-4'],
    ['Option 9-1', 'Option 9-2', 'Option 9-3'],
    ['Option 10-1', 'Option 10-2', 'Option 10-3', 'Option 10-4', 'Option 10-5'],
  ];

  List<String?> selectedValues = List.filled(10, '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generating Milk Report'),
        backgroundColor: MyColors.kWhite,
        foregroundColor: MyColors.kPrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 10; i++)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width/1,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(29)),
                            border: Border.all(color: MyColors.kPrimary)),
                        child: DropdownButton<String>(
                    underline: SizedBox.shrink(),

                          value: selectedValues[i],
                          items: [
                            DropdownMenuItem<String>(
                              value: '',
                              child: Text('Select an option'),
                            ),
                            ...dropdownValues[i]
                                .map((String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    ))
                          ],
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValues[i] = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // color: Colors.red,
                child: TextField(
                  controller: colorTextController,
                  // obscureText: true,
                  onTap: () {},
                  style: TextStyle(
                    color: MyColors.kBlack,
                    // fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    // hintText: 'Password',
                    labelText: 'Color',
                    labelStyle: TextStyle(color: MyColors.kPrimary),
                    hintStyle: TextStyle(color: MyColors.kPrimary),
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 193, 198, 198),
                        //Color.fromARGB(255, 115, 38, 38),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.kPrimary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(
                      Icons.color_lens,
                      color: MyColors.kPrimary,
                      // size: 25,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // color: Colors.red,
                child: TextField(
                  controller: odorTextController,
                  // obscureText: true,
                  onTap: () {},
                  style: TextStyle(
                    color: MyColors.kBlack,
                    // fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    // hintText: 'Password',
                    labelText: 'Odor',
                    labelStyle: TextStyle(color: MyColors.kPrimary),
                    hintStyle: TextStyle(color: MyColors.kPrimary),
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 193, 198, 198),
                        //Color.fromARGB(255, 115, 38, 38),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.kPrimary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(
                      Icons.color_lens,
                      color: MyColors.kPrimary,
                      // size: 25,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // color: Colors.red,
                child: TextField(
                  controller: acidityTextController,
                  // obscureText: true,
                  onTap: () {},
                  style: TextStyle(
                    color: MyColors.kBlack,
                    // fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    // hintText: 'Password',
                    labelText: 'Acidity',
                    labelStyle: TextStyle(color: MyColors.kPrimary),
                    hintStyle: TextStyle(color: MyColors.kPrimary),
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 193, 198, 198),
                        //Color.fromARGB(255, 115, 38, 38),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.kPrimary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(
                      Icons.color_lens,
                      color: MyColors.kPrimary,
                      // size: 25,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // color: Colors.red,
                child: TextField(
                  controller: clarityTextController,
                  // obscureText: true,
                  onTap: () {},
                  style: TextStyle(
                    color: MyColors.kBlack,
                    // fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    // hintText: 'Password',
                    labelText: 'Clarity',
                    labelStyle: TextStyle(color: MyColors.kPrimary),
                    hintStyle: TextStyle(color: MyColors.kPrimary),
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 193, 198, 198),
                        //Color.fromARGB(255, 115, 38, 38),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.kPrimary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(
                      Icons.color_lens,
                      color: MyColors.kPrimary,
                      // size: 25,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // color: Colors.red,
                child: TextField(
                  controller: fatTextController,
                  // obscureText: true,
                  onTap: () {},
                  style: TextStyle(
                    color: MyColors.kBlack,
                    // fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    // hintText: 'Password',
                    labelText: 'Fat Content',
                    labelStyle: TextStyle(color: MyColors.kPrimary),
                    hintStyle: TextStyle(color: MyColors.kPrimary),
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 193, 198, 198),
                        //Color.fromARGB(255, 115, 38, 38),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.kPrimary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(
                      Icons.color_lens,
                      color: MyColors.kPrimary,
                      // size: 25,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // color: Colors.red,
                child: TextField(
                  controller: protienContentTextController,
                  // obscureText: true,
                  onTap: () {},
                  style: TextStyle(
                    color: MyColors.kBlack,
                    // fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    // hintText: 'Password',
                    labelText: 'Protein Content',
                    labelStyle: TextStyle(color: MyColors.kPrimary),
                    hintStyle: TextStyle(color: MyColors.kPrimary),
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 193, 198, 198),
                        //Color.fromARGB(255, 115, 38, 38),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.kPrimary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(
                      Icons.color_lens,
                      color: MyColors.kPrimary,
                      // size: 25,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // color: Colors.red,
                child: TextField(
                  controller: BacterialTextController,
                  // obscureText: true,
                  onTap: () {},
                  style: TextStyle(
                    color: MyColors.kBlack,
                    // fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    // hintText: 'Password',
                    labelText: 'Bacterial Count',
                    labelStyle: TextStyle(color: MyColors.kPrimary),
                    hintStyle: TextStyle(color: MyColors.kPrimary),
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 193, 198, 198),
                        //Color.fromARGB(255, 115, 38, 38),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.kPrimary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(
                      Icons.color_lens,
                      color: MyColors.kPrimary,
                      // size: 25,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // color: Colors.red,
                child: TextField(
                  controller: AntibioticTextController,
                  // obscureText: true,
                  onTap: () {},
                  style: TextStyle(
                    color: MyColors.kBlack,
                    // fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    // hintText: 'Password',
                    labelText: 'Antibiotic Residue',
                    labelStyle: TextStyle(color: MyColors.kPrimary),
                    hintStyle: TextStyle(color: MyColors.kPrimary),
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 193, 198, 198),
                        //Color.fromARGB(255, 115, 38, 38),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.kPrimary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(
                      Icons.color_lens,
                      color: MyColors.kPrimary,
                      // size: 25,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // color: Colors.red,
                child: TextField(
                  controller: freezingPointTextController,
                  obscureText: false,
                  onTap: () {},
                  style: TextStyle(
                    color: MyColors.kBlack,
                    // fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    // hintText: 'Password',
                    labelText: 'Freezing Point',
                    labelStyle: TextStyle(color: MyColors.kPrimary),
                    hintStyle: TextStyle(color: MyColors.kPrimary),
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 193, 198, 198),
                        //Color.fromARGB(255, 115, 38, 38),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.kPrimary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(
                      Icons.color_lens,
                      color: MyColors.kPrimary,
                      // size: 25,
                    ),
                  ),
                ),
              ),
            ),
            MyElevatedButton(
              title: 'Done',
              onpress: () {},
            ),
          ],
        ),
      ),
    );
  }
}
