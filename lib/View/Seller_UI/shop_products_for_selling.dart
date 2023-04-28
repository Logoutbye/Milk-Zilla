import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:milk_zilla/res/Components/my_drawers/seller_drawer.dart';
import 'package:milk_zilla/res/Components/round_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopeProductsForSelling extends StatefulWidget {
  const ShopeProductsForSelling({super.key});

  @override
  State<ShopeProductsForSelling> createState() =>
      _ShopeProductsForSellingState();
}

class _ShopeProductsForSellingState extends State<ShopeProductsForSelling> {
  // varaibles for my checkboxes
  List<bool> myCheckBoxes = [false, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Products'),
        centerTitle: true,
      ),
      drawer: SellerDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CheckboxListTile(
              title: Text('Buffelo Milk'),
              value: myCheckBoxes[0],
              onChanged: (newValue) {
                myCheckBoxes[0] = newValue!;
                setState(() {});
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text('Cow Milk'),
              value: myCheckBoxes[1],
              onChanged: (newValue) {
                myCheckBoxes[1] = newValue!;
                setState(() {});
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text('Butter'),
              value: myCheckBoxes[2],
              onChanged: (newValue) {
                myCheckBoxes[2] = newValue!;
                setState(() {});
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text('Desi Ghee'),
              value: myCheckBoxes[3],
              onChanged: (newValue) {
                myCheckBoxes[3] = newValue!;
                setState(() {});
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text('Mix Milk'),
              value: myCheckBoxes[4],
              onChanged: (newValue) {
                myCheckBoxes[4] = newValue!;
                setState(() {});
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text('Yogurt'),
              value: myCheckBoxes[5],
              onChanged: (newValue) {
                myCheckBoxes[5] = newValue!;
                setState(() {});
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            SizedBox(
              height: 20,
            ),
            RoundButton(title: 'Save', onpress: () {}, width: 100)
          ],
        ),
      ),
    );
  }

  // shared preferences for storing the checkboxes
  void storeDataofCheckBoxesinSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
  }
}
