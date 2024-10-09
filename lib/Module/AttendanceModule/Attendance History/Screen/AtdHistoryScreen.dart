import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Attendance Screen/Screen/Attedance_screen.dart';
import '../Attendance History Shimmer/AttendanceHistoryShimmerScreen.dart';
import '../Class/CustomMonthPicker.dart';
import '../Model/AttendanceHistoryModel.dart';
import '../Provider/HistoryProvider.dart';
import '../../../Utills/Global Class/ColorHelper.dart';
import '../../../Utills/Global Class/ScreenSize.dart';

class AtdHistoryScreen extends StatefulWidget {
  AtdHistoryScreen({super.key});

  @override
  State<AtdHistoryScreen> createState() => _AtdHistoryScreenState();
}
DateTime selectedMonth=DateTime.now();

class _AtdHistoryScreenState extends State<AtdHistoryScreen> {
  bool isCurrentMonth = true;
  int currentYear = DateTime.now().year.toInt();
  int month = 3, year = 2023;
  Future<AttendanceHistoryModel?>? _futureAttendance;

  DateTime _currentMonth = DateTime.now();
  String _currentMonthfilter='';



  void _showMonthPicker(DateTime selectedMonth,currentYear,currentMonth) async {
    final customMonthPicker = CustomMonthPicker(
      initialSelectedMonth: selectedMonth, //DateTime.now(),
      firstEnabledMonth: DateTime(2020, 1),
      lastEnabledMonth:currentMonth,// DateTime(2030, 12),
      firstYear: DateTime.now().year,
      lastYear: currentYear,
      selectButtonText: 'Select',
      cancelButtonText: 'Cancel',
      highlightColor: primary,
      textColor: primary,
      contentBackgroundColor: whiteColor,
      dialogBackgroundColor: whiteColor,
      selectButtonTextStyle: GoogleFonts.roboto(
        textStyle: TextStyle(
          color: primary,
        )
      ),
      cancelButtonTextStyle: GoogleFonts.roboto(
          textStyle: TextStyle(
              color: primary
          )
      ),
    );

    final DateTime? picked = await customMonthPicker.show(context);

    if (picked != null && picked != selectedMonth) {
      setState(() {
        selectedMonth = picked;
        _currentMonthfilter=DateFormat("MMMM").format(selectedMonth);
        Provider.of<HistoryProvider>(context,listen: false).currentMonthfilter=_currentMonthfilter;
        _currentMonth = DateTime(selectedMonth.year,selectedMonth.month);
        Provider.of<HistoryProvider>(context,listen: false).currentMonth=_currentMonth;
        DateTime now = DateTime.now();
        if (selectedMonth.year == now.year && selectedMonth.month == now.month) {
          isCurrentMonth = true;
        } else {
          isCurrentMonth = false;
        }

      });
      print('Selected month: ${picked.month}, year: ${picked.year}');

    }
    _fetchAttendanceData();
  }

  @override
  void initState() {
    super.initState();
    _fetchAttendanceData();
  }

  void _fetchAttendanceData() {
    setState(() {
      _currentMonthfilter=Provider.of<HistoryProvider>(context,listen: false).currentMonthfilter;
      _futureAttendance = Provider.of<HistoryProvider>(context,listen: false)
          .GetAttendanceData(_currentMonthfilter, context);
    });
  }

  Future<void>Refresh()async{
    _fetchAttendanceData();
  }

  @override
  Widget build(BuildContext context) {
    int currentYear=_currentMonth.year;
    final AtdHistProvider = Provider.of<HistoryProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(screenWidth/25),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: screenHeight/30),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AttendanceScreen()));
                      },
                        child: Icon(Icons.arrow_back,color: blackColor,size: screenWidth/15,)),
                  ],
                ),
              ),
              SizedBox(height: screenHeight/50,),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Attendance",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                          color: lightBlackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth / 15,
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                              onTap: () {
                                AtdHistProvider.PreviousMonth(context);
                                _fetchAttendanceData();
                              },
                              child: Icon(
                                FontAwesomeIcons.chevronLeft,
                                color: primary,
                                size: screenWidth / 15,
                              )),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Wrap(children: [
                            Consumer<HistoryProvider>(
                              builder: (context, provider, child) {
                                return Text(
                                  DateFormat("MMMM").format(provider.currentMonth),
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      color: lightBlackColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth / 18,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 18,
                            ),
                            InkWell(
                                onTap: () async {
                                  _showMonthPicker(
                                      AtdHistProvider.currentMonth,
                                      currentYear,
                                      DateTime.now()
                                  );
                                  },
                                child: Icon(
                                  FontAwesomeIcons.calendar,
                                  color: primary,
                                  size: screenWidth / 15,
                                )),
                          ]),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                              onTap: () {
                                //NextMonth(context);
                                AtdHistProvider.NextMonthFunction(context);
                                _fetchAttendanceData();
                                //AtdHistProvider.GetMonthData(_currentMonth.toString(), context);
                              },
                              child: AtdHistProvider.isCurrentMonth
                                  ? Container()
                                  : Icon(
                                      FontAwesomeIcons.chevronRight,
                                      color: primary,
                                      size: screenWidth / 15,
                                    )),
                        ),
                      ],
                    ),
                    Consumer<HistoryProvider>(builder: (context,historyProvider,child){
                      return Expanded(
                        child: FutureBuilder<AttendanceHistoryModel?>(
                          future: _futureAttendance,
                          builder: (context, dataSnapshot) {
                            if (dataSnapshot.connectionState == ConnectionState.waiting) {
                              return AttendanceHistoryShimmer();
                            } else if (dataSnapshot.error != null) {
                              return Center(child: Text('An error occurred!'));
                            }
                
                            else if(dataSnapshot.hasData) {
                              final attendanceDatasnap = dataSnapshot.data;
                              final monthAttendance = attendanceDatasnap?.monthAttendance;
                              if(monthAttendance==null){
                                return Center(
                                  child: Text("There is No data available for ${_currentMonthfilter}",style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          fontSize: screenWidth/20,
                                          color: primary,
                                          fontWeight: FontWeight.bold
                                      )
                                  ),),
                                );
                              }
                              // Reverse the list to show the most recent date first
                              var attendanceData =
                                  dataSnapshot.data?.monthAttendance?.reversed.toList() ??
                                      [];
                              return RefreshIndicator(
                                color: whiteColor,
                                backgroundColor: lightgreyColor,
                                onRefresh: Refresh,
                                child: ListView.builder(
                                  itemCount: attendanceData.length,
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
                                        padding: const EdgeInsets.all(4),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Icon(CupertinoIcons.calendar),
                                                      SizedBox(width: screenWidth/40,),
                                                      Text(
                                                        attendanceData[index].date??"",
                                                        style: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                            color: primary, // Use your primary color variable
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: MediaQuery.of(context).size.width / 18,
                                                          ),
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                  Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
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
                                                                          fontSize: screenWidth / 25
                                                                      )),
                                                                ),
                                                                Text(
                                                                  "Check In",
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
                                                        Expanded(
                                                            child:Column(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Text(
                                                                    attendanceData[index].checkOut?.time??"",
                                                                    style: GoogleFonts.roboto(
                                                                        textStyle: TextStyle(
                                                                            color:lightBlackColor,
                                                                            fontWeight: FontWeight.w400,
                                                                            fontSize: screenWidth/25
                                                                        )
                                                                    ),),
                                                                  Text("Check Out",
                                                                    style: GoogleFonts.roboto(
                                                                        textStyle: TextStyle(
                                                                            color: Colors.black54,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: screenWidth/30
                                                                        )
                                                                    ),),
                                                                ]
                                                            )
                                                        ),

                                                        Expanded(
                                                            child:Column(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Text(
                                                                    "${attendanceData[index].duration?.hours.toString()??'0'} Hr, ${attendanceData[index].duration?.minutes.toString()??'0'} Min", style: GoogleFonts.roboto(
                                                                        textStyle: TextStyle(
                                                                            color:lightBlackColor,
                                                                            fontWeight: FontWeight.w400,
                                                                            fontSize: screenWidth/25
                                                                        )
                                                                    ),),
                                                                  Text("Duration",
                                                                    style: GoogleFonts.roboto(
                                                                        textStyle: TextStyle(
                                                                            color: Colors.black54,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: screenWidth/30
                                                                        )
                                                                    ),),
                                                                ]
                                                            )
                                                        ),
                                                      ]),
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                            else{
                              return Text("There is no Data");
                            }
                          },
                        ),
                      );
                    })
                    
                
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}

