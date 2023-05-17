import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:milk_zilla/res/my_colors.dart';

import '../constanst.dart';

class ViewMilkReport extends StatefulWidget {
  const ViewMilkReport({super.key});

  @override
  State<ViewMilkReport> createState() => _ViewMilkReportState();
}

class _ViewMilkReportState extends State<ViewMilkReport> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: MyColors.kSecondary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.kSecondary,
        foregroundColor: MyColors.kPrimary,
        title:_isLoading? Text('Status: Loading...'): Text('Status: Approved'),
      ),
      body: Center(
          child: _isLoading
              ? Center(
                  child: LottieBuilder.asset('assets/animations/loading.json',
                   height: MediaQuery.of(context).size.height / 5,),)
              : Center(
                  child: Container(
                    child: Image.network(ApprovedReportPhotoLink),
                  ),
                )),
    );
  }

  void _fetchImage() {
    // Simulating image fetching delay with Future.delayed
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }
}
