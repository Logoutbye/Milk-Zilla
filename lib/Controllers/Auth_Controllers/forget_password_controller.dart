


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/Utils/utils.dart';

class ForgetPasswordController {
    //to forget password we call this function
  firebaseForgetPassword(BuildContext parentContext,var emailTextController) async {
    showDialog(
        context: parentContext,
        barrierDismissible: true,
        builder: (context) => Center(
              child: Lottie.asset('assets/animations/loading.json',
                  height: MediaQuery.of(context).size.height / 5),
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