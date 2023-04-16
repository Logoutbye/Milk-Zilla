import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../res/my_colors.dart';

class Utils {
  
  static void fieldfocusChange(
      BuildContext context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  // flutter toast message
  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: MyColors.kSecondary,
        textColor: MyColors.kPrimary);
  }

  // flutter flushbar
  static flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          //positionOffset: 50,

          borderRadius: BorderRadius.circular(20),
          backgroundColor: MyColors.kSecondary,
          messageColor: MyColors.kPrimary,
          message: message,
          duration: Duration(seconds: 5),
          flushbarPosition: FlushbarPosition.BOTTOM,
        )..show(context));
  } // flutter flushbar

  static flushBarErrorMessageWithAction(String message,VoidCallback _onpress, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          positionOffset: 50,padding: EdgeInsets.all(26),
          borderRadius: BorderRadius.circular(20),
          backgroundColor: MyColors.kSecondary,
          messageColor: MyColors.kPrimary,
          message: message,
          duration: Duration(seconds: 5),
          flushbarPosition: FlushbarPosition.TOP,
          mainButton: IconButton(
            icon: Icon(Icons.login_outlined,),
            onPressed: _onpress,
          ),
        )..show(context));
  }
}