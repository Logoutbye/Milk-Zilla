import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/View/Auth%20UI/registration_status.dart';
import 'package:milk_zilla/res/Components/error_screen.dart';
import 'package:milk_zilla/res/Components/my_shared_prefrences.dart';

import '../../Utils/utils.dart';
import '../../main.dart';
import '../../res/Components/firebase_helper.dart';
import '../../res/Components/round_button.dart';
import '../../res/my_colors.dart';
import '../Buyer_UI/buyer_screen.dart';
import '../Inspector_UI/insector_screen.dart';
import '../Seller_UI/seller_screen.dart';

class RegistrationScreen extends StatefulWidget {
  String whichUser;
  RegistrationScreen({super.key, required this.whichUser});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController mobileNumberTextController = TextEditingController();
  TextEditingController PasswordTextController = TextEditingController();
  TextEditingController nameTextControl = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController cityTextControl = TextEditingController();
  TextEditingController shopNameTextControl = TextEditingController();
  TextEditingController buyerOrinspectorOrShopAdressTextControl =
      TextEditingController();
  bool _showSpinner = false;

  var whichUser;

  @override
  void initState() {
    whichUser = widget.whichUser;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: MyColors.kSecondary,
        foregroundColor: MyColors.kPrimary,
        centerTitle: true,
        title: Text(
          'Create ${widget.whichUser} Account',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  // Welcome Container
                  Container(
                    decoration: BoxDecoration(
                      color: MyColors.kPrimary,
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            MyColors.kBlack, BlendMode.softLight),
                        image: AssetImage("assets/images/icon.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [],
                    ),
                  ),
                  // Coplete Login Form
                  Positioned(
                    top: MediaQuery.of(context).size.height / 3.8,
                    left: MediaQuery.of(context).size.height / 24,

                    // Main form Container
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: MediaQuery.of(context).size.height / 1.55,
                        decoration: BoxDecoration(
                          color: MyColors.kSecondary,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: MyColors.kPrimary,
                              // blurRadius: 15,
                              // spreadRadius: 2,
                              // offset: Offset(
                              //   0,
                              //   5,
                              // ), // Shadow position
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Login Text
                                  Container(
                                    child: Text(
                                      'It\'s quick and easy !',
                                      style: TextStyle(
                                        color: MyColors.kPrimary,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  // Name  Textfield
                                  Container(
                                    // color: Colors.red,
                                    child: TextField(
                                      controller: nameTextControl,
                                      maxLength: 60,
                                      onTap: () {},
                                      keyboardType: TextInputType.name,
                                      // inputFormatters: [
                                      //   FilteringTextInputFormatter.digitsOnly,
                                      // ],
                                      style: TextStyle(
                                        color: MyColors.kBlack,
                                        // fontSize: 18,
                                      ),
                                      decoration: InputDecoration(
                                        // hintText: 'User',
                                        labelText: 'Name',
                                        labelStyle:
                                            TextStyle(color: MyColors.kPrimary),
                                        hintStyle:
                                            TextStyle(color: MyColors.kPrimary),
                                        enabledBorder: new OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 180, 180, 180)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyColors.kPrimary),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        prefixIcon: Icon(Icons.flag),
                                      ),
                                    ),
                                  ),
                                  // Mobile number text field
                                  Container(
                                    // color: Colors.red,
                                    child: TextField(
                                      controller: mobileNumberTextController,
                                      maxLength: 11,
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
                                        hintText: '03XXXXXXXXX',
                                        labelText: 'Mobile Number',
                                        labelStyle:
                                            TextStyle(color: MyColors.kPrimary),
                                        hintStyle:
                                            TextStyle(color: MyColors.kPrimary),
                                        enabledBorder: new OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 180, 180, 180)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyColors.kPrimary),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        prefixIcon: Icon(Icons.flag),
                                      ),
                                    ),
                                  ),
                                  // City
                                  Container(
                                    // color: Colors.red,
                                    child: TextField(
                                      controller: cityTextControl,
                                      maxLength: 60,
                                      onTap: () {},
                                      keyboardType: TextInputType.name,
                                      // inputFormatters: [
                                      //   FilteringTextInputFormatter.digitsOnly,
                                      // ],
                                      style: TextStyle(
                                        color: MyColors.kBlack,
                                        // fontSize: 18,
                                      ),
                                      decoration: InputDecoration(
                                        // hintText: 'User',
                                        labelText: 'City',
                                        labelStyle:
                                            TextStyle(color: MyColors.kPrimary),
                                        hintStyle:
                                            TextStyle(color: MyColors.kPrimary),
                                        enabledBorder: new OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 180, 180, 180)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyColors.kPrimary),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        prefixIcon: Icon(Icons.flag),
                                      ),
                                    ),
                                  ),
                                  // if user is seller
                                  // shop name
                                  widget.whichUser == 'Seller'
                                      ? Container(
                                          // color: Colors.red,
                                          child: TextField(
                                            controller: shopNameTextControl,
                                            maxLength: 60,
                                            onTap: () {},
                                            keyboardType: TextInputType.name,
                                            // inputFormatters: [
                                            //   FilteringTextInputFormatter.digitsOnly,
                                            // ],
                                            style: TextStyle(
                                              color: MyColors.kBlack,
                                              // fontSize: 18,
                                            ),
                                            decoration: InputDecoration(
                                              // hintText: 'User',
                                              labelText: 'Shop Name',
                                              labelStyle: TextStyle(
                                                  color: MyColors.kPrimary),
                                              hintStyle: TextStyle(
                                                  color: MyColors.kPrimary),
                                              enabledBorder:
                                                  new OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 180, 180, 180)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: MyColors.kPrimary),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              prefixIcon: Icon(Icons.flag),
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                  Container(
                                    // color: Colors.red,
                                    child: TextField(
                                      controller:
                                          buyerOrinspectorOrShopAdressTextControl,
                                      maxLength: 60,
                                      onTap: () {},
                                      keyboardType: TextInputType.name,
                                      // inputFormatters: [
                                      //   FilteringTextInputFormatter.digitsOnly,
                                      // ],
                                      style: TextStyle(
                                        color: MyColors.kBlack,
                                        // fontSize: 18,
                                      ),
                                      decoration: InputDecoration(
                                        // hintText: 'User',
                                        labelText:
                                            widget.whichUser == 'Inspector'
                                                ? 'Inspector Adress'
                                                : widget.whichUser == 'Buyer'
                                                    ? 'Your Adress'
                                                    : 'Shop Adress',
                                        labelStyle:
                                            TextStyle(color: MyColors.kPrimary),
                                        hintStyle:
                                            TextStyle(color: MyColors.kPrimary),
                                        enabledBorder: new OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 180, 180, 180)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyColors.kPrimary),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        prefixIcon: Icon(Icons.flag),
                                      ),
                                    ),
                                  ),

                                  // Email  Textfield
                                  Container(
                                    // color: Colors.red,
                                    child: TextField(
                                      controller: emailTextController,
                                      maxLength: 60,
                                      onTap: () {},
                                      keyboardType: TextInputType.name,
                                      // inputFormatters: [
                                      //   FilteringTextInputFormatter.digitsOnly,
                                      // ],
                                      style: TextStyle(
                                        color: MyColors.kBlack,
                                        // fontSize: 18,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'example@gmail.com',
                                        labelText: 'Email',
                                        labelStyle:
                                            TextStyle(color: MyColors.kPrimary),
                                        hintStyle:
                                            TextStyle(color: MyColors.kPrimary),
                                        enabledBorder: new OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 180, 180, 180)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyColors.kPrimary),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        prefixIcon: Icon(Icons.email_outlined),
                                      ),
                                    ),
                                  ),

                                  // Password TextField
                                  Container(
                                    // color: Colors.red,
                                    child: TextField(
                                      controller: PasswordTextController,
                                      obscureText: true,
                                      onTap: () {},
                                      style: TextStyle(
                                        color: MyColors.kBlack,
                                        // fontSize: 18,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Password',
                                        labelText: 'Password',
                                        labelStyle:
                                            TextStyle(color: MyColors.kPrimary),
                                        hintStyle:
                                            TextStyle(color: MyColors.kPrimary),
                                        enabledBorder: new OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 193, 198, 198),
                                            //Color.fromARGB(255, 115, 38, 38),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyColors.kPrimary),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          // color:
                                          //     MyColors.kPrimary,
                                          // size: 25,
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 30,
                                  ),
                                  // sig up
                                  MyElevatedButton(
                                    title: 'Sign Up',
                                    onpress: () {
                                      FirebaseRegistration(context);
                                    },
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        2.5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Main Form Container
          ],
        ),
      ),
    );
  }

  Future createUserInFirebase() async {
    //Refrence to document
    final buyer = FirebaseFirestore.instance
        .collection('Buyers')
        .doc('${emailTextController.text}');
    final seller = FirebaseFirestore.instance
        .collection('Sellers')
        .doc('${emailTextController.text}');
    final inpector = FirebaseFirestore.instance
        .collection('Inspectors')
        .doc('${emailTextController.text}');

    final jsonForBuyer = {
      'name': nameTextControl.text,
      'mobile_no': mobileNumberTextController.text,
      'city': cityTextControl.text,
      'email': emailTextController.text,
      'password': PasswordTextController.text,
      'inspector_adress': buyerOrinspectorOrShopAdressTextControl.text,
    };
    final jsonForSeller = {
      'name': nameTextControl.text,
      'mobile_no': mobileNumberTextController.text,
      'city': cityTextControl.text,
      'shop_name': shopNameTextControl.text,
      'shop_adress': buyerOrinspectorOrShopAdressTextControl.text,
      'email': emailTextController.text,
      'password': PasswordTextController.text,
      'status': 'Pending'
    };
    final jsonForInspector = {
      'name': nameTextControl.text,
      'mobile_no': mobileNumberTextController.text,
      'city': cityTextControl.text,
      'email': emailTextController.text,
      'password': PasswordTextController.text,
      'inspector_adress': buyerOrinspectorOrShopAdressTextControl.text,
      'status': 'Pending'
    };
    //create document and write data to firebase
    if (widget.whichUser == 'Buyer') {
      await buyer.set(jsonForBuyer);
    } else if (widget.whichUser == 'Seller') {
      await seller.set(jsonForSeller);
    } else {
      await inpector.set(jsonForInspector);
    }
  }

  Future FirebaseRegistration(BuildContext parentContext) async {
    showDialog(
        context: parentContext,
        barrierDismissible: false,
        builder: (context) => Center(
              child: Lottie.asset('assets/animations/loading.json'),
            ));
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailTextController.text.trim(),
              password: PasswordTextController.text.trim())
          .then((UserCredential user_credentials) async {
        Navigator.of(parentContext).pop();
        createUserInFirebase();
        if (widget.whichUser == 'Buyer') {
          MySharedPrefencesSessionHandling
              .setOrupdateWhichUserLoggedInSharedPreferences(
                  '${widget.whichUser}');
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => BuyerScreen()));
          emailTextController.clear();
          PasswordTextController.clear();
          mobileNumberTextController.clear();
          cityTextControl.clear();
          emailTextController.clear();
          nameTextControl.clear();
          buyerOrinspectorOrShopAdressTextControl.clear();
          shopNameTextControl.clear();
        } else if (widget.whichUser == 'Seller') {
          MySharedPrefencesSessionHandling
              .setOrupdateWhichUserLoggedInSharedPreferences(
                  '${widget.whichUser}');

          //get the approval status as soon as the user is created and navigate to relavent screen
          await FirestoreHelper.initializeToCheckStatus();
          await FirestoreHelper.initializeToCheckStatusForBuyers();

          var currentInspectorStatusInFirestore =
              await FirestoreHelper.currentInspectorStatusInFirestore;

          if (currentInspectorStatusInFirestore == 'Approved') {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => InspectorScreen()));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RegistrationStatusScreen(
                      whichUser: whichUser,
                    )));
          }
          emailTextController.clear();
          PasswordTextController.clear();
          mobileNumberTextController.clear();
          cityTextControl.clear();
          emailTextController.clear();
          nameTextControl.clear();
          buyerOrinspectorOrShopAdressTextControl.clear();
          shopNameTextControl.clear();
        } else {
          //update the value in shared prefrences so that next time it may navigate to relavent screen
          MySharedPrefencesSessionHandling
              .setOrupdateWhichUserLoggedInSharedPreferences(
                  '${widget.whichUser}');

          //get the approval status as soon as the user is created and navigate to relavent screen
          await FirestoreHelper.initializeToCheckStatus();
          await FirestoreHelper.initializeToCheckStatusForBuyers();
          var currentSellerStatusInFirestore =
              await FirestoreHelper.currentSellerStatusInFirestore;

          if (currentSellerStatusInFirestore == 'Approved') {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SellerScreen()));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RegistrationStatusScreen(
                      whichUser: whichUser,
                    )));
          }

          emailTextController.clear();
          PasswordTextController.clear();
          mobileNumberTextController.clear();
          cityTextControl.clear();
          emailTextController.clear();
          nameTextControl.clear();
          buyerOrinspectorOrShopAdressTextControl.clear();
          shopNameTextControl.clear();
        }
      }).onError((FirebaseAuthException error, stackTrace) {
        if (error.code == "email-already-in-use") {
          print("The email address is already in use by another account");
          Utils.toastMessage(
              "The email address is already in use by another account");
          Navigator.of(parentContext).pop();
        } else {
          Utils.toastMessage(error.toString());
          Navigator.of(parentContext).pop();
        }
      });
    } on FirebaseAuthException catch (e) {
      print('Khan${e.toString()}');
      Utils.toastMessage(e.toString());
      Navigator.of(parentContext).pop();
      emailTextController.clear();
      PasswordTextController.clear();
      mobileNumberTextController.clear();
      cityTextControl.clear();
      emailTextController.clear();
      nameTextControl.clear();
      buyerOrinspectorOrShopAdressTextControl.clear();
      shopNameTextControl.clear();
    }
  }
}
