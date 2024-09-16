import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CustomCard extends StatelessWidget {
  final String label;
  final int progressValue;
  final Color fontPrimaryColor;
  final Color fontSecondaryColor;
  final Color color;
  final double minValue;
  final double maxValue;
  final double screenWidth;
  final double screenHeight;

  CustomCard({
    required this.label,
    required this.progressValue,
    required this.fontPrimaryColor,
    required this.fontSecondaryColor,
    required this.color,
    required this.minValue,
    required this. maxValue,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight/5,
      width: screenWidth/2.4,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [fontSecondaryColor,Colors.white]
          ),
          boxShadow: [
            BoxShadow(
                blurRadius: 5,
                offset: Offset(2,4)
            )
          ],
          border:Border(top:BorderSide(
              color: color,
              width: 10,
              style: BorderStyle.solid
          )),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("${progressValue}",
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth/15
                )
            ),),
          Text("${label}",
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    color:color,
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidth/25
                )
            ),),
          Expanded(
            child: SfRadialGauge(axes: <RadialAxis>[
              RadialAxis(
                minimum: minValue,
                maximum: maxValue,
                showLabels: false,
                showTicks: false,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.2,
                  cornerStyle: CornerStyle.bothCurve,
                  color: Colors.black12,
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      positionFactor: 0.1,
                      angle: 90,
                      widget: Text(
                        '${progressValue}/ ${maxValue.toInt()}',
                        style:GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: screenWidth/25,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ))
                ],
                pointers: <GaugePointer>[
                  RangePointer(
                    value: progressValue.toDouble(),
                    cornerStyle: CornerStyle.bothCurve,
                    width: 0.2,
                    sizeUnit: GaugeSizeUnit.factor,
                    color: color,
                  )
                ],
              )
            ]),
          )

        ],
      ),
    );
  }
}



