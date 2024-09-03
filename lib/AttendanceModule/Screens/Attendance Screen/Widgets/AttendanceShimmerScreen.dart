import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Utills/Global Class/ColorHelper.dart';
import '../../../Utills/Global Class/ScreenSize.dart';
import '../../../Widgets/Shimmer Widget/ContainerShimmer.dart';

class AttendanceShimmer extends StatelessWidget {
  const AttendanceShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Shimmer.fromColors(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  containerShimmer(
                      widthSize: screenWidth/2,
                      heightSize: screenHeight/30,
                      borderRadius: screenWidth/20
                  ),
                  SizedBox(
                    height: screenHeight/40,
                  ),
                  Center(
                    child: containerShimmer(
                        widthSize: screenWidth,
                        heightSize: screenHeight/4,
                        borderRadius: screenWidth/25
                    ),
                  ),

                  SizedBox(
                    height: screenHeight/20,
                  ),

                  containerShimmer(
                      widthSize: screenWidth/2,
                      heightSize: screenHeight/30,
                      borderRadius: screenWidth/20
                  ),

                  SizedBox(
                    height: screenHeight/50,
                  ),

                  containerShimmer(
                      widthSize: screenWidth/2.5,
                      heightSize: screenHeight/35,
                      borderRadius: screenWidth/20
                  ),

                  SizedBox(
                    height: screenHeight/20,
                  ),

                  Center(
                    child: containerShimmer(
                        widthSize: screenWidth,
                        heightSize: screenHeight/12,
                        borderRadius: screenWidth/15
                    ),
                  ),

                  SizedBox(height: screenHeight/20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      containerShimmer(
                          widthSize: screenWidth/2.3,
                          heightSize: screenHeight/4.5,
                          borderRadius: screenWidth/20
                      ),

                      SizedBox(
                        width: screenWidth/50,
                      ),

                      containerShimmer(
                          widthSize: screenWidth/2.3,
                          heightSize: screenHeight/4.5,
                          borderRadius: screenWidth/20
                      )


                    ],
                  )
                ],
              ),
              baseColor: darkgreyColor,
              highlightColor: lightgreyColor
          ),
        ),
      ),
    );
  }
}




