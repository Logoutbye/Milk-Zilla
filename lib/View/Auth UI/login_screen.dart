import 'package:flutter/material.dart';
import 'package:milk_zilla/Utils/utils.dart';
import 'package:milk_zilla/View/Auth%20UI/registration_screen.dart';
import 'package:milk_zilla/controllers/Auth_Controllers/forget_password_controller.dart';
import 'package:milk_zilla/controllers/Auth_Controllers/login_controller.dart';
import 'package:milk_zilla/res/Components/firebase_helper.dart';
import 'package:milk_zilla/res/Components/my_shared_prefrences.dart';

import '../../res/Components/round_button.dart';
import '../../res/my_colors.dart';

class LoginScreen extends StatefulWidget {
  String whichUser;
  LoginScreen({super.key, required this.whichUser});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController PasswordTextController = TextEditingController();
  bool islogedInbuttonPressed = false;


  LoginController loginController =LoginController();
  ForgetPasswordController forgetPasswordController =ForgetPasswordController();
  var whichUser;

  @override
  void initState() {
    getiingSatus();
    whichUser = widget.whichUser;
    var whichi = MySharedPrefencesSessionHandling.whichUserLoggedIn;
    print('$whichi');
    // TODO: implement initState
    super.initState();
  }

  getiingSatus() async {
    await FirestoreHelper.initializeToCheckStatusForSellers();
    await FirestoreHelper.initializeToCheckStatusForInspector();
    await FirestoreHelper.initializeToCheckStatusForFarmer();

    await FirestoreHelper.currentSellerStatusInFirestore;
    await FirestoreHelper.currentFarmerStatusInFirestore;
    await FirestoreHelper.currentInspectorStatusInFirestore;
  }

  @override
  void dispose() {
    emailTextController.dispose();
    PasswordTextController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: MyColors.KWhite,
      appBar: AppBar(
        backgroundColor: MyColors.kSecondary,
        foregroundColor: MyColors.kPrimary,
        centerTitle: true,
        title: Text(
          'Login as $whichUser',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                        height: MediaQuery.of(context).size.height / 1.9,
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
                                      'Login',
                                      style: TextStyle(
                                        color: MyColors.kPrimary,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  // Mobile Number Textfield
                                  Container(
                                    // color: Colors.red,
                                    child: TextField(
                                      controller: emailTextController,
                                      maxLength: 30,
                                      onTap: () {},
                                      keyboardType: TextInputType.emailAddress,
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
                                        prefixIcon: Icon(Icons.email,color: MyColors.kPrimary,),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
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
                                          color:
                                              MyColors.kPrimary,
                                          // size: 25,
                                        ),
                                      ),
                                    ),
                                  ),

                                  // forgot password
                                  Container(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: TextButton(
                                        onPressed: () {
                                          if (emailTextController
                                              .text.isEmpty) {
                                            Utils.flushBarErrorMessage(
                                                'Please Enter Email', context);
                                          } else if (emailTextController
                                                  .text.isNotEmpty &&
                                              PasswordTextController
                                                  .text.isEmpty) {
                                          forgetPasswordController.firebaseForgetPassword(context,emailTextController);
                                          } else {
                                            Utils.flushBarErrorMessage(
                                                'Please enter only email',
                                                context);
                                          }
                                        },
                                        child: Text('Forgot password!'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  MyElevatedButton(
                                    title: 'Login',
                                    onpress: () {
                                      loginController.FirebaseLogin(
                                        context,
                                        emailTextController,
                                        PasswordTextController,
                                        whichUser);
                                      // FirebaseLogin(context);
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegistrationScreen(
                                                    whichUser: widget.whichUser,
                                                  )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Dont have an account? "),
                                              Text(
                                                "Create Now",
                                                style: TextStyle(
                                                    color: MyColors.kPrimary,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
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
}
