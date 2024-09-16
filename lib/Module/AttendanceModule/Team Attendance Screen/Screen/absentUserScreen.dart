import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../Utills/Global Class/ColorHelper.dart';
import '../../Attendance History/Attendance History Shimmer/AttendanceHistoryShimmerScreen.dart';
import '../../../Utills/Global Class/ScreenSize.dart';
import '../Model/AbsentUserModel.dart';
import '../Provider/TeamAttendanceProvider.dart';

class absentUsers extends StatefulWidget {
  absentUsers({super.key});

  @override
  State<absentUsers> createState() => _absentUsersState();
}

class _absentUsersState extends State<absentUsers> {
  String CurrentDate =
  DateFormat("EEEE MMMM yyyy").format(DateTime.now()).toString();

  Future<AbsentUserModel>? _absentUser;

  @override
  void initState() {
    super.initState();
    _fetchAbsentData();
  }

  void _fetchAbsentData() {
    setState(() {
      _absentUser =
          Provider.of<TeamAttendanceProvider>(context, listen: false)
              .getAbsentUser(context);
    });
  }

  Future<void>Refresh()async{
    _fetchAbsentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Absent User"),
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
                      child: FutureBuilder<AbsentUserModel>(
                        future:_absentUser,
                        builder: (context, dataSnapshot) {
                          if (dataSnapshot.connectionState == ConnectionState.waiting) {
                            return AttendanceHistoryShimmer();
                          } else if (dataSnapshot.error != null) {
                            return Center(child: Text('An error occurred! ${dataSnapshot.error}'));
                          }
                          else if(dataSnapshot.hasData){
                            final absentUserDatasnap = dataSnapshot.data;
                            final absentRecord = absentUserDatasnap?.absentUsers;
                            if(absentRecord==null){
                              return Center(
                                child: Text("No one is Absent!",style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        fontSize: screenWidth/20,
                                        color: primary,
                                        fontWeight: FontWeight.bold
                                    )
                                ),),
                              );
                            }
                            var absentData =
                                dataSnapshot.data?.absentUsers?.toList() ?? [];
                            return RefreshIndicator(
                              color: whiteColor,
                              backgroundColor: lightgreyColor,
                              onRefresh: Refresh,
                              child: ListView.builder(
                                  itemCount: absentData.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(top: 5, bottom: 5),
                                      height: MediaQuery.of(context).size.height / 8,
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
                                                radius: screenWidth/14,
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
                                                Flexible(
                                                  child: Text(
                                                    absentData[index].fullName??"",
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                        color: primary, // Use your primary color variable
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: MediaQuery.of(context).size.width / 18,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                      crossAxisAlignment:CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            absentData[index].designation??"",
                                                            style: GoogleFonts.roboto(
                                                                textStyle: TextStyle(
                                                                    color:
                                                                    lightBlackColor,
                                                                    fontWeight: FontWeight.w400,
                                                                    fontSize: screenWidth / 26
                                                                )),
                                                          ),
                                                        ),
                                                      ]
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                      crossAxisAlignment:CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            absentData[index].jobType??"",
                                                            style: GoogleFonts.roboto(
                                                                textStyle: TextStyle(
                                                                    color:
                                                                    lightBlackColor,
                                                                    fontWeight: FontWeight.w400,
                                                                    fontSize: screenWidth / 26
                                                                )),
                                                          ),
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
                              child: Text("No one is Absent Today!",style: GoogleFonts.roboto(
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
