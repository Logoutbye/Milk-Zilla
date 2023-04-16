import 'package:flutter/material.dart';
import '../my_colors.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onpress;
  final double width;
  RoundButton(
      {super.key,
      required this.title,
      this.loading = false,
      required this.onpress,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        height: 45,
        width: width,
        decoration: BoxDecoration(
          color: MyColors.kPrimary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: loading
              ? CircularProgressIndicator(
                  color: MyColors.kWhite,
                )
              : Text(
                  title,
                  style: TextStyle(
                      color: MyColors.kWhite, fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }
}