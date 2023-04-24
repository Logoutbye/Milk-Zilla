import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:milk_zilla/res/Components/my_drawer.dart';

class SellerScreen extends StatefulWidget {
  const SellerScreen({super.key});

  @override
  State<SellerScreen> createState() => _BuyerScreenState();
}

class _BuyerScreenState extends State<SellerScreen> {
   @override
  void initState() {
     final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final email = user.email;
      print('email::${email}');
    }
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Seller screeen')),
      drawer: MyAppDrawer(),
    );
  }
}