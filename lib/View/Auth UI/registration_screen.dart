import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../Utils/utils.dart';
import '../../main.dart';
import '../../res/Components/round_button.dart';
import '../../res/my_colors.dart';
import '../User_UI/buyer_screen.dart';
import '../User_UI/insector_screen.dart';
import '../User_UI/seller_screen.dart';

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
  TextEditingController shopAdressTextControl = TextEditingController();
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
        // physics: NeverScrollableScrollPhysics(),
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
                                  widget.whichUser == 'Seller'
                                      ? Container(
                                          // color: Colors.red,
                                          child: TextField(
                                            controller: shopAdressTextControl,
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
                                              labelText: 'Shop Adress',
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
                                  RoundButton(
                                    title: 'Sign Up',
                                    onpress: () {
                                      FirebaseRegistration();
                                    },
                                    width: 140,
                                  ),
                                  SizedBox(
                                    height: 50,
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

  Future FirebaseRegistration() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: Lottie.asset('assets/animations/loading.json'),
            ));
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailTextController.text.trim(),
              password: PasswordTextController.text.trim())
          .then((UserCredential user_credentials) {
        //  navigator of context not working
        navigatorKey.currentState!.popUntil((route) => route.isFirst);
        if (widget.whichUser == 'Buyer') {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => BuyerScreen()));
        } else if (widget.whichUser == 'Seller') {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SellerScreen()));
        } else {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => InspectorScreen()));
        }
      }).onError((FirebaseAuthException error, stackTrace) {
        if (error.code == "email-already-in-use") {
          print("The email address is already in use by another account");
          Utils.toastMessage(
              "The email address is already in use by another account");
              //  navigator of context not working
        navigatorKey.currentState!.popUntil((route) => route.isFirst);
        }
      });
    } on FirebaseAuthException catch (e) {
      print('Khan${e.toString()}');
      Utils.toastMessage(e.toString());
      //  navigator of context not working
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
  }
}
