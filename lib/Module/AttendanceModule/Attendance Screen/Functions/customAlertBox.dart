import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../Utills/Global Class/ScreenSize.dart';

showStatusLoader(BuildContext context,String iconName){
  AlertDialog alert = AlertDialog(
    content: Container(
      width: screenWidth / 2, // Set the desired width
      height: screenHeight / 6, // Set the desired height
      child: Center(
        child: Lottie.asset("${iconName}"),
      ),
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}