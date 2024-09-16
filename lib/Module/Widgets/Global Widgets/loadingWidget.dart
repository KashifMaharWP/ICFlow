import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../Utills/Global Class/ColorHelper.dart';
import '../../Utills/Global Class/ScreenSize.dart';

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Container(
      width: screenWidth / 2,
      height: screenHeight / 6,
      child: Center(
        child: LoadingAnimationWidget.hexagonDots(
            color: primary, size: screenWidth / 5),
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