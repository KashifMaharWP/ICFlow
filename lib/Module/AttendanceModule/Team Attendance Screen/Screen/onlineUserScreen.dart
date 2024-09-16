import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../Utills/Global Class/ColorHelper.dart';
import '../../Attendance History/Attendance History Shimmer/AttendanceHistoryShimmerScreen.dart';
import '../../../Utills/Global Class/ScreenSize.dart';
import '../Model/ViewTodyAttendanceModel.dart';
import '../Provider/TeamAttendanceProvider.dart';

class ViewAttendance extends StatefulWidget {
  ViewAttendance({super.key});

  @override
  State<ViewAttendance> createState() => _ViewAttendanceState();
}

class _ViewAttendanceState extends State<ViewAttendance> {
  String CurrentDate =
      DateFormat("EEEE MMMM yyyy").format(DateTime.now()).toString();

  Future<ViewTodyAttendanceModel>? _TeamAttendance;

  @override
  void initState() {
    super.initState();
    _fetchAttendanceData();
  }

  void _fetchAttendanceData() {
    setState(() {
      _TeamAttendance =
          Provider.of<TeamAttendanceProvider>(context, listen: false)
              .GetTeamAttendance(context);
    });
  }

  Future<void>Refresh()async{
    _fetchAttendanceData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("View Attendance"),
          foregroundColor: Colors.white,
          backgroundColor: Colors.redAccent.shade700,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(screenWidth/18),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                CurrentDate,
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                  color: lightBlackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth / 18,
                )),
              ),
            ),
            Consumer<TeamAttendanceProvider>(
                builder: (context, historyProvider, child) {
              return Expanded(
                  child: FutureBuilder<ViewTodyAttendanceModel>(
                future:_TeamAttendance,
                builder: (context, dataSnapshot) {
                  if (dataSnapshot.connectionState == ConnectionState.waiting) {
                    return AttendanceHistoryShimmer();
                  } else if (dataSnapshot.error != null) {
                    return Center(child: Text('An error occurred!'));
                  }
                  else if(dataSnapshot.hasData){
                    final attendanceDatasnap = dataSnapshot.data;
                    final attendanceRecord = attendanceDatasnap?.onlineUserAttendanceRecord;
                    if(attendanceRecord==null){
                      return Center(
                        child: Text("No one is Present Yet!",style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: screenWidth/20,
                                color: primary,
                                fontWeight: FontWeight.bold
                            )
                        ),),
                      );
                    }
                    var attendanceData =
                        dataSnapshot.data?.onlineUserAttendanceRecord?.toList() ?? [];
                    return RefreshIndicator(
                      color: whiteColor,
                      backgroundColor: lightgreyColor,
                      onRefresh: Refresh,
                      child: ListView.builder(
                          itemCount: attendanceData.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              height: screenHeight / 8,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                          CircleAvatar(
                                            radius: screenWidth/12,
                                            backgroundImage:
                                            AssetImage('assets/images/usericon.png')
                                          ),
                                          SizedBox(
                                            width: screenWidth/30,
                                          ),
                                          Container(
                                            height: screenHeight/5,
                                            width: 2,
                                            color: CupertinoColors.systemGrey2,
                                          ),
                                        SizedBox(
                                            width: screenWidth/30,
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                attendanceData[index].user!.fullName??"",
                                                style: GoogleFonts.roboto(
                                                  textStyle: TextStyle(
                                                    color: primary, // Use your primary color variable
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: MediaQuery.of(context).size.width / 20,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                    crossAxisAlignment:CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        attendanceData[index].checkIn?.time??"",
                                                        style: GoogleFonts.roboto(
                                                            textStyle: TextStyle(
                                                                color:
                                                                lightBlackColor,
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: screenWidth / 24
                                                            )),
                                                      ),
                                                      Text(
                                                        "Online Time",
                                                        style: GoogleFonts.roboto(
                                                            textStyle: TextStyle(
                                                                color: Colors.black54,
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: screenWidth / 30
                                                            )),
                                                      ),
                                                    ]
                                                ),
                                              ),
                                            ],
                                          )
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  }
                  else{
                    return Center(
                      child: Text("No one is Present Yet!",style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: screenWidth/20,
                              color: primary,
                              fontWeight: FontWeight.bold
                          )
                      ),),
                    );;
                  }

                },

              ));
            })
          ],
        ),
      ),
    );
  }
}
