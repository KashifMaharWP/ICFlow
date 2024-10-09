import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_application/Module/LeaveModule/Leave%20Management/Model/userLeaveModel.dart';
import '../../../AttendanceModule/Attendance History/Attendance History Shimmer/AttendanceHistoryShimmerScreen.dart';
import '../../../Utills/Global Class/ColorHelper.dart';
import '../../../Utills/Global Class/ScreenSize.dart';
import '../../../Widgets/Global Widgets/customNoBoldText.dart';
import '../../../Widgets/Global Widgets/customText.dart';
import '../../LeaveForm Screen/LeaveFormScreen.dart';
import '../Provider/leaveProvider.dart';
import '../Widget/customFilters.dart';
import '../Widget/customPopUp.dart';


class userLeaveManagement extends StatefulWidget {
  const userLeaveManagement({super.key});

  @override
  State<userLeaveManagement> createState() => _userLeaveManagementState();
}

class _userLeaveManagementState extends State<userLeaveManagement> {
  String selectedDate=DateFormat("dd MMMM yyyy").format(DateTime.now());
  String selectedFilter="All";
  Future<UserLeaveModel>? _leaveList;

  void applyForLeave(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LeaveFormScreen()));
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    setState(() {
      _leaveList =
          Provider.of<LeaveProvider>(context, listen: false)
              .getUserLeave(context, selectedDate, selectedFilter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LeaveFormScreen()));
        },
        child: Container(
          width: screenWidth/6,
          height: screenWidth/6,
          decoration: BoxDecoration(
            color: primary,
            borderRadius: BorderRadius.circular(screenWidth/6),
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.systemGrey2,
                offset: Offset(-2, -2),
                blurRadius: 4,
              )
            ]
          ),
          child: Icon(FontAwesomeIcons.plus,color: whiteColor,size: screenWidth/20,),
        ),
      ),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.redAccent.shade700,
        foregroundColor: Colors.white,
        centerTitle: true,
        shadowColor: Colors.black,
        title: const Text("Manage Leave"),
      ),
      body: Column(
        children: [
          Container(
            width: screenWidth,
            height: screenHeight/4,
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
                padding: EdgeInsets.symmetric(horizontal: screenWidth/25,vertical: screenWidth/18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Custom Cards for History
                    wrapCustomCard(),

                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customFiltersWidget(filter: selectedFilter,),
                        Image(image: AssetImage("assets/icons/calendar.png"),width: screenWidth/10,)
                      ],
                    ),
                  ],
                )
            ),
          ),
          SizedBox(height: screenHeight/60,),
          //Current Date
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: customText(
                text: selectedDate,
                fontSize: screenWidth/24,
                fontColor: CupertinoColors.systemGrey
            ),
          ),

          //ListView Widget
          listViewContainer()

        ],
      ),
    );
  }

  //Custom Card Container
Widget customCard(String text, IconData icon, Color iconColor,Color textColor, String Count){
    return Container(
      width: screenWidth/3.5,
      height: screenHeight/8,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: blackColor,width: 1),
          boxShadow: [
            BoxShadow(
                color: CupertinoColors.systemGrey4,
                offset: Offset(2, 2),
                blurRadius: 5
            )
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon,color: iconColor,),
          Center(child: customNoBoldText(text: text, fontSize: screenWidth/30, fontColor: textColor)),

          Center(
            child: customText(text: Count, fontSize: screenWidth/22, fontColor: blackColor),
          )

        ],
      ),
    );
}

//Wrap customCard
Widget wrapCustomCard(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        customCard("Leave", CupertinoIcons.doc_append, Colors.amber, primary, "4"),

        customCard("Approved", CupertinoIcons.check_mark_circled_solid, Colors.green, primary, "2"),

        customCard("Disapprove", CupertinoIcons.xmark_circle_fill, Colors.red, primary, "1"),
      ],
    );
}

//ListView Widget
  Widget listViewContainer(){
    return  Consumer<LeaveProvider>(
        builder: (context, provider, child) {
          return Expanded(
            child: FutureBuilder<UserLeaveModel>(
                future: _leaveList,
                builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return AttendanceHistoryShimmer();
            } else if (dataSnapshot.error != null) {
              return Center(child: Text('An error occurred! ${dataSnapshot.error}'));
            }
            else if(dataSnapshot.hasData) {
              final leaveDatasnap = dataSnapshot.data;
              final leaveRecord = leaveDatasnap?.myLeaves;
              if (leaveRecord == null) {
                return Center(
                  child: Text("No one Application", style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontSize: screenWidth / 20,
                          color: primary,
                          fontWeight: FontWeight.bold
                      )
                  ),),
                );
              }
              var leaveData =
                  dataSnapshot.data?.myLeaves?.toList() ?? [];
              return ListView.builder(
                  itemCount: leaveData.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                onTap: () {
                  customPopUp(context,leaveData[index].description??'',leaveData[index].intialDate??'',leaveData[index].endDate??'',leaveData[index].totalDays??'');
                },
                child: Container(
                    margin: EdgeInsets.all(screenWidth / 80),
                    padding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: 14),
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(
                            screenWidth / 20),
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
                              Text(
                                leaveData[index].user!.fullName??'',
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        color: blackColor,
                                        fontSize: screenWidth / 20,
                                        fontWeight: FontWeight.bold
                                    )
                                ),),
                              customNoBoldText(
                                  text: "Casual Leave Application",
                                  fontSize: screenWidth / 25,
                                  fontColor: blackColor),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment
                                    .center,
                                children: [
                                  customText(text: "Casual",
                                      fontSize: screenWidth / 22,
                                      fontColor: Colors.amber),
                                  Container(
                                    width: screenWidth / 4,
                                    height: screenHeight / 28,
                                    decoration: BoxDecoration(
                                        color: Colors.green.shade200,
                                        borderRadius: BorderRadius.circular(
                                            10)
                                    ),
                                    child: Center(child: customNoBoldText(
                                        text: "Active",
                                        fontSize: screenWidth / 24,
                                        fontColor: whiteColor)),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    )

                ),
              );
                  }
                  );
            }
            return Container();

                }),
          );
        }
        );
  }

}
