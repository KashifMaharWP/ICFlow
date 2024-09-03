import 'package:flutter/material.dart';

import '../../Utills/Global Class/ColorHelper.dart';
import '../../Utills/Global Class/ScreenSize.dart';

class containerShimmer extends StatelessWidget {
  final double widthSize;
  final double heightSize;
  final double borderRadius;

  containerShimmer({
    required this.widthSize,
    required this.heightSize,
    required this.borderRadius
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightSize,
      width: widthSize,
      decoration: BoxDecoration(
          color: blackColor,
          borderRadius: BorderRadius.circular(borderRadius)
      ),
    );
  }
}
