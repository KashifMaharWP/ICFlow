import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../Utills/Global Class/ColorHelper.dart';
import '../../../Utills/Global Class/ScreenSize.dart';
import '../../../Widgets/Shimmer Widget/ContainerShimmer.dart';

class AttendanceHistoryShimmer extends StatelessWidget {
  const AttendanceHistoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, index) {
          return Container(
            child: Shimmer.fromColors(
              baseColor: darkgreyColor,
              highlightColor: lightgreyColor,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: screenHeight/40,horizontal: screenWidth/40),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black,width: 2)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              containerShimmer(
                                  widthSize: screenWidth*0.75,
                                  heightSize: screenHeight/30,
                                  borderRadius: screenWidth/50
                              ),
                              SizedBox(height: screenHeight/40,),
                              Row(
                                children: [
                                  containerShimmer(
                                      widthSize: screenWidth*0.25,
                                      heightSize: screenHeight/30,
                                      borderRadius: screenWidth/50
                                  ),
                                  SizedBox(width: screenWidth/25,),
                                  containerShimmer(
                                      widthSize: screenWidth*0.25,
                                      heightSize: screenHeight/30,
                                      borderRadius: screenWidth/50
                                  ),
                                ],
                              )

                            ],
                          ),
                        ),
                        SizedBox(width: screenWidth/20,),
                        Center(
                          child: containerShimmer(
                              widthSize: screenWidth*.16,
                              heightSize: screenHeight/13,
                              borderRadius: screenWidth/2
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight/25,)
                ],
              ),
            ),
          );
        },

      ),
    );
  }
}
