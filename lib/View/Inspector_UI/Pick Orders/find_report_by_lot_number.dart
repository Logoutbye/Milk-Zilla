import 'package:flutter/material.dart';
import 'package:milk_zilla/res/Components/round_button.dart';

import '../../../Controllers/Inspector_Controllers/find_report_by_lot_no_controller.dart';
import '../../../res/my_colors.dart';

class FindReportByLotNumber extends StatefulWidget {
  String documentIdToAccessTheReport;
  FindReportByLotNumber({super.key, required this.documentIdToAccessTheReport});

  @override
  State<FindReportByLotNumber> createState() => _FindReportByLotNumberState();
}

class _FindReportByLotNumberState extends State<FindReportByLotNumber> {
  TextEditingController lotNumberTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.kSecondary,
        foregroundColor: MyColors.kPrimary,
        title: Text('Please Enter Lot Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            color: MyColors.kSecondary,
            elevation: 4, // Add a slight shadow to the card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Add rounded corners to the card
            ),
            child: Container(
              padding: EdgeInsets.all(16), // Add padding inside the card
              width: MediaQuery.of(context).size.width * 0.8, // Set the card's width to 80% of the screen width
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'To ensure that the milk is safe for use, please enter the lot number from the container. This will allow you to review and verify the milk\'s condition.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: lotNumberTextController,
                    decoration: InputDecoration(
                      labelText: 'Enter Lot Number',
                    ),
                  ),
                  SizedBox(height: 20),
                 MyElevatedButton(
                title: 'Review Milk Condition',
                onpress: () {
                  find_report_by_lot_number_Controller().printOrderDetails(
                      context,
                      lotNumberTextController.text.toString(),
                      widget.documentIdToAccessTheReport);
                })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
