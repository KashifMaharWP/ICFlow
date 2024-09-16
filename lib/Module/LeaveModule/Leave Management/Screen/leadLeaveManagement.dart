
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../Utills/Global Class/ColorHelper.dart';
import '../../../Utills/Global Class/ScreenSize.dart';
import '../../../Widgets/Global Widgets/customNoBoldText.dart';
import '../../../Widgets/Global Widgets/customText.dart';
import '../Widget/customFilters.dart';
import '../Widget/customPopUp.dart';

class teamLeadLeaveManagement extends StatefulWidget {
  const teamLeadLeaveManagement({super.key});

  @override
  State<teamLeadLeaveManagement> createState() => _teamLeadLeaveManagementState();
}

class _teamLeadLeaveManagementState extends State<teamLeadLeaveManagement> {

  String selectedFilter = "All";
  String selectedDate=DateFormat("dd MMMM yyyy").format(DateTime.now());

//Screen Starts Here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.redAccent.shade700,
        foregroundColor: Colors.white,
        centerTitle: true,
        shadowColor: Colors.black,
        title: const Text("Manage Leave"),
      ),
      body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Container(
              width: screenWidth,
              height: screenHeight/10,
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(screenWidth/12),
                      bottomRight: Radius.circular(screenWidth/12)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemGrey4,
                      offset: Offset(0, 2),
                      blurRadius: 6,
                    )
                  ]
              ),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth/20,vertical: screenWidth/18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customFiltersWidget(),
                      Image(image: AssetImage("assets/icons/calendar.png"),width: screenWidth/10,)
                    ],
                  )
              ),
            ),
            SizedBox(height: screenHeight/60,),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: customText(
                  text: selectedDate,
                  fontSize: screenWidth/24,
                  fontColor: CupertinoColors.systemGrey
              ),
            ),
            listViewContainer()

        ],
      ),
    );
  }

//ListViewContainer
  Widget listViewContainer(){
    return Expanded(
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: (){
                customPopUp(context);
              },
              child: Container(
                  margin: EdgeInsets.all(screenWidth/80),
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 14),
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(screenWidth/20),
                      boxShadow: [
                        BoxShadow(
                            color: CupertinoColors.systemGrey2,
                            offset: Offset(2, 2),
                            blurRadius: 10
                        )
                      ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Kashif Mahar",style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: blackColor,
                                    fontSize: screenWidth/20,
                                    fontWeight: FontWeight.bold
                                )
                            ),),
                            customNoBoldText(text: "Casual Leave Application", fontSize: screenWidth/25, fontColor: blackColor),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                customText(text: "Casual", fontSize: screenWidth/22, fontColor: Colors.amber),
                                Container(
                                  width: screenWidth/4,
                                  height: screenHeight/28,
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade200,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Center(child: customNoBoldText(text: "Active", fontSize: screenWidth/24, fontColor: whiteColor)),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      PopupMenuButton(
                          initialValue: 0,
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                  onTap: () {
                                  },
                                  value: 1,
                                  child: const Text(
                                      "Approve")),
                              PopupMenuItem(
                                  onTap: () {},
                                  value: 2,
                                  child: const Text(
                                      "Disapprove"))
                            ];
                          },
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.grey,
                          ))
                    ],
                  )

              ),
            );
          }),
    );
  }

}
