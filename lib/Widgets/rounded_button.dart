import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:taskflow_application/Classes/Device_Info.dart';

import '../Module/Utills/Global Class/ColorHelper.dart';
import '../Module/Utills/Global Class/ScreenSize.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {super.key,
      required this.title,
      required this.loading,
      required this.on_Tap});
  bool loading = false;
  String title;
  VoidCallback on_Tap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: on_Tap,
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 17,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.redAccent.shade700,
            borderRadius: BorderRadius.circular(20),
          ),
          child: loading
              ? LoadingAnimationWidget.staggeredDotsWave(color: whiteColor, size: screenWidth/18)
              : Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: DeviceInfo.fontSize + 1,
                      fontWeight: FontWeight.w400),
                ),
        ),
      ),
    );
  }
}
