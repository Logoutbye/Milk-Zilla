import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:milk_zilla/Model/order_model.dart';
import 'package:milk_zilla/View/Inspector_UI/Test%20Milk/test_milk_screen_tab_bar.dart';

import '../../../Controllers/Inspector_Controllers/test_orders_for_shop_controller.dart';
import '../../../res/Components/round_button.dart';
import '../../../res/constanst.dart';
import '../../../res/my_colors.dart';

class CreateMilkReport extends StatefulWidget {
  var order;
  CreateMilkReport({super.key, required this.order});

  @override
  State<CreateMilkReport> createState() => _CreateMilkReportState();
}

class _CreateMilkReportState extends State<CreateMilkReport> {
  List<List<String>> dropdownValues = [
    [
      'Temprature',
      'Good: Cold (0-4°C)',
      'Bad: Room temperature or warm (above 4°C)'
    ],
    ['Odor', 'Good: Mild, pleasant, sweet', 'Bad: Unusual or unpleasant odor'],
    [
      'Acidity',
      'Good: Normal acidity (within the expected pH range)',
      'Bad: High acidity'
    ],
    [
      'Clarity',
      'Good: Clear, slight turbidity',
      'Bad: Cloudy, visible particles or sediment ',
    ],
    [
      'Fat Content',
      'Good: Standard percentage for the specific milk type',
      'Bad: Lower or higher than the standard percentage'
    ],
    [
      'Protein Content',
      'Good: Standard percentage for the specific milk type',
      'Bad: Lower or higher than the standard percentage'
    ],
    [
      'Bacterial Count',
      'Good: Below the acceptable limit',
      'Bad: Above the acceptable limit'
    ],
    [
      'Antibiotic Residue',
      'Good: No detectable residue',
      'Bad: Detectable residue',
    ],
    [
      'Freezing Point',
      'Good: Within the expected range for fresh milk',
      'Bad: Lower or higher than the expected range',
    ],
    [
      'Color',
      'Good: White, creamy, slightly off-white',
      'Bad: Abnormal color',
    ],
  ];

  List<int?> selectedValues = List.generate(10, (index) => 0);

  TextEditingController inspectorRemarksTextController =
      TextEditingController();

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
                        width: MediaQuery.of(context).size.width / 1,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(29)),
                            border: Border.all(color: MyColors.kPrimary)),
                        child: DropdownButton<int>(
                          isExpanded: true,
                          // icon: Text(''),
                          underline: SizedBox.shrink(),
                          value: selectedValues[i],
                          items: dropdownValues[i]
                              .asMap()
                              .entries
                              .map((entry) => DropdownMenuItem<int>(
                                    value: entry.key,
                                    child: entry.key == 0
                                        ? Text(
                                            entry.value,
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )
                                        : Text(entry.value),
                                  ))
                              .toList(),
                          onChanged: (int? newIndex) {
                            setState(() {
                              selectedValues[i] = newIndex;
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
                  controller: inspectorRemarksTextController,
                  obscureText: false,
                  onTap: () {},
                  style: TextStyle(
                    color: MyColors.kBlack,
                    // fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    // hintText: 'Password',
                    labelText: 'Inspector Remarks',
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
                      Icons.edit,
                      color: MyColors.kPrimary,
                      // size: 25,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                child: Row(
                  children: [
                    MyElevatedButton(
                      title: 'Not-Approve',
                      onpress: () {
                        handleButtonPress('Not-Approved');
                      },
                    ),
                    Spacer(),
                   MyElevatedButton(
                      title: 'Approve',
                      onpress: () {
                        handleButtonPress('Approved');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleButtonPress(var giveme_status) async {
    List<Map<String, dynamic>> selectedValuesList = [];

    for (int i = 0; i < 10; i++) {
      int selectedIndex = selectedValues[i] ?? 0;
      String selectedValue = dropdownValues[i][selectedIndex];
      String placeholder =
          dropdownValues[i][0]; // Assuming the placeholder is always at index 0

      Map<String, dynamic> valueMap = {
        // 'key': placeholder,
        placeholder: selectedValue,
      };

      selectedValuesList.add(valueMap);
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      final email = user!.email;
      print('current users email::${email}');

      final documentReference = FirebaseFirestore.instance
          .collection('Orders With Farm')
          .doc('${widget.order}');

      await documentReference.update({
        'order_report': selectedValuesList,
        'inspector_remarks': inspectorRemarksTextController.text.toString(),
        'status': 'Shipped',
        'inspector_id': email,
        'milk_status': giveme_status
      });
      Navigator.pop(context);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => TestMilkScreenTabbar()));
      print('Selected values sent to Firestore');
    } catch (error) {
      print('Failed to send selected values to Firestore: $error');
    }
  }
}





























// import 'package:flutter/material.dart';

// class TenDropdownButtons extends StatefulWidget {
//   @override
//   _TenDropdownButtonsState createState() => _TenDropdownButtonsState();
// }

// class _TenDropdownButtonsState extends State<TenDropdownButtons> {
//   List<List<String>> dropdownValues = [
//     ['Select an option1', 'Option 1-1', 'Option 1-2', 'Option 1-3'],
//     ['Select an option2', 'Option 2-1', 'Option 2-2', 'Option 2-3', 'Option 2-4'],
//     ['Select an option3', 'Option 3-1', 'Option 3-2', 'Option 3-3'],
//     ['Select an option4', 'Option 4-1', 'Option 4-2', 'Option 4-3', 'Option 4-4', 'Option 4-5'],
//     ['Select an option5', 'Option 5-1', 'Option 5-2', 'Option 5-3'],
//     ['Select an option6', 'Option 6-1', 'Option 6-2', 'Option 6-3', 'Option 6-4'],
//     ['Select an option7', 'Option 7-1', 'Option 7-2', 'Option 7-3'],
//     ['Select an option8', 'Option 8-1', 'Option 8-2', 'Option 8-3', 'Option 8-4'],
//     ['Select an option9', 'Option 9-1', 'Option 9-2', 'Option 9-3'],
//     ['Select an option10', 'Option 10-1', 'Option 10-2', 'Option 10-3', 'Option 10-4', 'Option 10-5'],
//   ];

//   List<int?> selectedValues = List.generate(10, (index) => 0);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Ten Dropdown Buttons'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             for (int i = 0; i < 10; i++)
//               DropdownButton<int>(
//                 value: selectedValues[i],
//                 items: dropdownValues[i]
//                     .asMap()
//                     .entries
//                     .map((entry) => DropdownMenuItem<int>(
//                           value: entry.key,
//                           child: entry.key == 0
//                               ? Text(
//                                   entry.value,
//                                   style: TextStyle(color: Colors.grey),
//                                 )
//                               : Text(entry.value),
//                         ))
//                     .toList(),
//                 onChanged: (int? newIndex) {
//                   setState(() {
//                     selectedValues[i] = newIndex;
//                   });
//                 },
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
