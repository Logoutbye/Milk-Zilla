import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../Model/price_list_model.dart';

class priceList extends StatefulWidget {
  const priceList({super.key});

  @override
  State<priceList> createState() => _priceListState();
}

class _priceListState extends State<priceList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Price List')),
      body: FutureBuilder(
        future: readPriceListFromDatabase(),

        builder: (ctx, snapshot) {
          if(snapshot.hasData){
            print('www${snapshot.data!.cow_milk}');
          }
          // Displaying LoadingSpinner to indicate waiting state
          return Center(
            child: CircularProgressIndicator(),
          );
        },

// Future that needs to be resolved
// inorder to display something on the Canvas
      ),
    );
  }

  Future<PriceList?> readPriceListFromDatabase() async {
// get Price by id
    final docPrices =
        FirebaseFirestore.instance.collection('Price List').doc('items');
    final snapshot = await docPrices.get();

    if (snapshot.exists) {
      return PriceList.fromJson(snapshot.data()!);
    }
  }
}
