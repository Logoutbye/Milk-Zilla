import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/Utils/utils.dart';
import 'package:milk_zilla/View/Auth%20UI/registration_screen.dart';
import '../../res/Components/round_button.dart';
import '../../res/my_colors.dart';
import '../Buyer_UI/buyer_screen.dart';
import '../Inspector_UI/insector_screen.dart';
import '../Seller_UI/seller_screen.dart';

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

  var whichUser;

  @override
  void initState() {
    whichUser = widget.whichUser;
    // TODO: implement initState
    super.initState();
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
                                        prefixIcon: Icon(Icons.flag),
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
                                          // color:
                                          //     MyColors.kPrimary,
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
                                          } else {
                                            firebaseForgetPassword(context);
                                          }
                                        },
                                        child: Text('Forgot password!'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  RoundButton(
                                    title: 'Login',
                                    onpress: () {
                                      FirebaseLogin(context);
                                    },
                                    width: 140,
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

  Future FirebaseLogin(BuildContext parentContext) async {
    showDialog(
        context: parentContext,
        barrierDismissible: true,
        builder: (context) => Center(
              child: Lottie.asset('assets/animations/loading.json'),
            ));
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailTextController.text.trim(),
              password: PasswordTextController.text.trim())
          .then((UserCredential user_credentials) {
        // print("object ${user_credentials.user.toString()}");
        // print("object ${user_credentials.credential!.signInMethod}");
        // print("object ${user_credentials.credential!.token}");
          emailTextController.clear();
          PasswordTextController.clear();
        Navigator.of(parentContext).pop();
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
        if (error.code == "wrong-password") {
          print("The password is invalid");
          Utils.toastMessage("The password is invalid");
          Navigator.of(parentContext).pop();
        }
      });
    } on FirebaseAuthException catch (e) {
      print('Khan${e.toString()}');
      Utils.toastMessage(e.toString());
      Navigator.of(parentContext).pop();
    }
  }

  //to forget password we call this function
  firebaseForgetPassword(BuildContext parentContext) async {
    showDialog(
        context: parentContext,
        barrierDismissible: true,
        builder: (context) => Center(
              child: Lottie.asset('assets/animations/loading.json'),
            ));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(
        email: emailTextController.text.trim(),
      )
          .then((g) {
        Utils.toastMessage('Please Check Email to Reset Password');

        Navigator.of(parentContext).pop();
      }).onError((FirebaseAuthException error, stackTrace) {
        Utils.toastMessage(error.toString());

        Navigator.of(parentContext).pop();
      });
    } on FirebaseAuthException catch (e) {
      Utils.toastMessage(e.toString());

      Navigator.of(parentContext).pop();
    }
  }
}
