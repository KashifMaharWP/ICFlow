import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Module/Utills/Global Class/ScreenSize.dart';

class Samplescreen extends StatelessWidget {
  const Samplescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade500,
      ),
      backgroundColor: Colors.red.shade500,
      body: Container(
        child: Center(
          child: Text("Comming Soon....",style:GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: screenWidth/12,
              fontWeight: FontWeight.bold,
            )
          )),
        ),
      ),
    );
  }
}
