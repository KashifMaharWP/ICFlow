import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_application/AttendanceModule/Screens/Team%20Attendance%20Screen/Model/PresentUserModel.dart';
import 'package:taskflow_application/AttendanceModule/Utills/Global%20Class/ColorHelper.dart';
import '../../Attendance History/Attendance History Shimmer/AttendanceHistoryShimmerScreen.dart';
import '../../../Utills/Global Class/ScreenSize.dart';
import '../Model/AbsentUserModel.dart';
import '../Provider/TeamAttendanceProvider.dart';

class presentUsers extends StatefulWidget {
  presentUsers({super.key});

  @override
  State<presentUsers> createState() => _presentUsersState();
}

class _presentUsersState extends State<presentUsers> {
  String CurrentDate =
  DateFormat("EEEE MMMM yyyy").format(DateTime.now()).toString();

  Future<PresentUserModel>? _presentUser;

  @override
  void initState() {
    super.initState();
    _fetchPresentData();
  }

  void _fetchPresentData() {
    setState(() {
      _presentUser =
          Provider.of<TeamAttendanceProvider>(context, listen: false)
              .getPrsentUser(context);
    });
  }

  Future<void>Refresh()async{
    _fetchPresentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Present User"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.redAccent.shade700,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(screenWidth/20),
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
                      child: FutureBuilder<PresentUserModel>(
                        future:_presentUser,
                        builder: (context, dataSnapshot) {
                          if (dataSnapshot.connectionState == ConnectionState.waiting) {
                            return AttendanceHistoryShimmer();
                          } else if (dataSnapshot.error != null) {
                            return Center(child: Text('An error occurred! ${dataSnapshot.error}'));
                          }
                          else if(dataSnapshot.hasData){
                            final presentUserDatasnap = dataSnapshot.data;
                            final presentRecord = presentUserDatasnap?.presentUsers;
                            if(presentRecord==null){
                              return Center(
                                child: Text("No one is Present Today!",style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        fontSize: screenWidth/20,
                                        color: primary,
                                        fontWeight: FontWeight.bold
                                    )
                                ),),
                              );
                            }
                            var presentData =
                                dataSnapshot.data?.presentUsers?.toList() ?? [];
                            return RefreshIndicator(
                              color: whiteColor,
                              backgroundColor: lightgreyColor,
                              onRefresh: Refresh,
                              child: ListView.builder(
                                  itemCount: presentData.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(top: 5, bottom: 5),
                                      height: MediaQuery.of(context).size.height / 5.5,
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
                                        padding: const EdgeInsets.all(8.0),
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
                                                Expanded(
                                                  child: Text(
                                                    presentData[index].fullName??"",
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                        color: primary, // Use your primary color variable
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: MediaQuery.of(context).size.width / 20,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(
                                                            presentData[index].checkIn??"",
                                                            style: GoogleFonts.roboto(
                                                                textStyle: TextStyle(
                                                                    color:
                                                                    lightBlackColor,
                                                                    fontWeight: FontWeight.w400,
                                                                    fontSize: screenWidth / 26
                                                                )),
                                                          ),
                                                          Text("Check In",
                                                            style: GoogleFonts.roboto(
                                                                textStyle: TextStyle(
                                                                    color:
                                                                    Colors.black54,
                                                                    fontWeight: FontWeight.w400,
                                                                    fontSize: screenWidth / 30
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: screenWidth/15,),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            presentData[index].checkOut??"",
                                                            style: GoogleFonts.roboto(
                                                                textStyle: TextStyle(
                                                                    color:
                                                                    lightBlackColor,
                                                                    fontWeight: FontWeight.w400,
                                                                    fontSize: screenWidth / 26
                                                                )),
                                                          ),
                                                          Text("Check Out",
                                                            style: GoogleFonts.roboto(
                                                                textStyle: TextStyle(
                                                                    color:
                                                                    Colors.black54,
                                                                    fontWeight: FontWeight.w400,
                                                                    fontSize: screenWidth / 30
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Row(
                                                  children: [
                                                    Text("Duration: ",
                                                      style: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              color:
                                                              Colors.black54,
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: screenWidth / 34
                                                          )),
                                                    ),

                                                    Text(
                                                      "${presentData[index].duration!.hours??""} Hrs : ",
                                                      style: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              color:
                                                              lightBlackColor,
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: screenWidth / 28
                                                          )),
                                                    ),
                                                    Text(
                                                      "${presentData[index].duration!.minutes??""} Min",
                                                      style: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              color:
                                                              lightBlackColor,
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: screenWidth / 28
                                                          )),
                                                    ),

                                                  ],
                                                ))
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
