import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/Utils/utils.dart';
import 'package:milk_zilla/res/Components/round_button.dart';
import 'package:milk_zilla/res/my_colors.dart';

import '../../View/Inspector_UI/Pick Orders/inspector_screen.dart';
import '../constanst.dart';

class ViewMilkReport extends StatefulWidget {
  var milk_supplier;
  var inspector_id;
  var inspector_remarks;
  var customer_id;
  var orderId;

  var order_report;
  var milk_status;
  bool viewOnly;

  ViewMilkReport(
      {super.key,
      required this.orderId,
      required this.milk_supplier,
      required this.customer_id,
      required this.inspector_id,
      required this.inspector_remarks,
      required this.order_report,
      required this.milk_status,
      required this.viewOnly});

  @override
  State<ViewMilkReport> createState() => _ViewMilkReportState();
}

class _ViewMilkReportState extends State<ViewMilkReport> {
  bool _isLoading = true;
  String inspector_remarks = '';

  @override
  void initState() {
    inspector_remarks = widget.inspector_remarks;
    super.initState();
    _fetchImage();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController inspectorRemarksTextController =
        TextEditingController(text: inspector_remarks);

    return Scaffold(
      // backgroundColor: MyColors.kSecondary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.kSecondary,
        foregroundColor: MyColors.kPrimary,
        title: Text('Milk Report: ${widget.milk_status}'),
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Milk Supplier ID: ${widget.milk_supplier}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'Inspector ID: ${widget.inspector_id}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'Customer ID: ${widget.customer_id}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text(
                'Milk Quality Parameters:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              DataTable(
                columns: [
                  DataColumn(label: Text('Parameter')),
                  DataColumn(label: Text('Value')),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text('Temprature')),
                    DataCell(Text('${widget.order_report[0]['Temprature']}')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Odor')),
                    DataCell(Text('${widget.order_report[1]['Odor']}')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Acidity')),
                    DataCell(Text('${widget.order_report[2]['Acidity']}')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Clarity')),
                    DataCell(Text('${widget.order_report[3]['Clarity']}')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Fat Content')),
                    DataCell(Text('${widget.order_report[4]['Fat Content']}')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Protein Content')),
                    DataCell(
                        Text('${widget.order_report[5]['Protein Content']}')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Bacterial Count')),
                    DataCell(
                        Text('${widget.order_report[6]['Bacterial Count']}')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Antibiotic Residue')),
                    DataCell(Text(
                        '${widget.order_report[7]['Antibiotic Residue']}')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Freezing Point')),
                    DataCell(
                        Text('${widget.order_report[8]['Freezing Point']}')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Color')),
                    DataCell(Text('${widget.order_report[9]['Color']}')),
                  ]),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'Inspector Remarks:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              widget.viewOnly == true
                  ? Text('${inspector_remarks}')
                  : Container(
                      // color: Colors.red,
                      padding: EdgeInsets.all(8),
                      child: TextField(
                        controller: inspectorRemarksTextController,
                        maxLength: 30,
                        onTap: () {},
                        style: TextStyle(
                          color: MyColors.kBlack,
                          // fontSize: 18,
                        ),
                        decoration: InputDecoration(
                          // hintText: 'Vdu4EsetTY4',
                          labelText: 'Tell us about milk condition',
                          labelStyle: TextStyle(color: MyColors.kPrimary),
                          hintStyle: TextStyle(color: MyColors.kPrimary),
                          enabledBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 180, 180, 180)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: MyColors.kPrimary),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(
                            Icons.numbers,
                            color: MyColors.kPrimary,
                          ),
                        ),
                      ),
                    ),
              widget.viewOnly == false
                  ? Row(
                      children: [
                        Center(
                          child: ElevatedButton(
                              child: Text('Not-Approve and Dump'),
                              onPressed: () async {
                                try {
                                  final user =
                                      FirebaseAuth.instance.currentUser;
                                  final email = user!.email;
                                  print('current users email::${email}');

                                  final documentReference = FirebaseFirestore
                                      .instance
                                      .collection('Orders')
                                      .doc('${widget.orderId}');

                                  await documentReference.update({
                                    'order_report': widget.order_report,
                                    'inspector_remarks':
                                        inspectorRemarksTextController.text,
                                    'status': 'Canceled',
                                    'inspector_id': email,
                                    'milk_status': 'Not-Approved'
                                  });
                                  Navigator.pop(context);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => InspectorScreen()));
                                  Utils.toastMessage(
                                      'Order has been Canceled.');

                                  print('Selected values sent to Firestore');
                                } catch (error) {
                                  print(
                                      'Failed to send selected values to Firestore: $error');
                                }
                              }),
                        ),
                        Spacer(),
                        Center(
                          child: ElevatedButton(
                              child: Text('Approve and Pick Up'),
                              onPressed: () async {
                                try {
                                  final user =
                                      FirebaseAuth.instance.currentUser;
                                  final email = user!.email;
                                  print('current users email::${email}');

                                  final documentReference = FirebaseFirestore
                                      .instance
                                      .collection('Orders')
                                      .doc('${widget.orderId}');

                                  await documentReference.update({
                                    'order_report': widget.order_report,
                                    'inspector_remarks':
                                        inspectorRemarksTextController.text,
                                    'status': 'Shipped',
                                    'inspector_id': email,
                                    'milk_status': 'Approved'
                                  });
                                  Navigator.pop(context);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => InspectorScreen()));
                                  print('Selected values sent to Firestore');
                                  Utils.toastMessage(
                                      'Order has been Picked successfully');
                                } catch (error) {
                                  print(
                                      'Failed to send selected values to Firestore: $error');
                                }
                              }),
                        ),
                      ],
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),

      //  Center(
      //     child: _isLoading
      //         ? Center(
      //             child: LottieBuilder.asset('assets/animations/loading.json',
      //              height: MediaQuery.of(context).size.height / 5,),)
      //         : Center(
      //             child: Container(
      //               child: Image.network(ApprovedReportPhotoLink),
      //             ),
      //           )),
    );
  }

  void _fetchImage() {
    // Simulating image fetching delay with Future.delayed
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

}
