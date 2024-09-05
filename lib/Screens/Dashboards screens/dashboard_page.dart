import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_application/API/login_user_detail.dart';
import 'package:taskflow_application/API/role_model.dart';
import 'package:taskflow_application/AttendanceModule/Screens/Attendance%20Screen/Provider/attendanceProvider.dart';
import 'package:taskflow_application/AttendanceModule/Screens/Team%20Attendance%20Screen/Screen/absentUserScreen.dart';
import 'package:taskflow_application/AttendanceModule/Screens/Team%20Attendance%20Screen/Screen/onlineUserScreen.dart';
import 'package:taskflow_application/AttendanceModule/Screens/Team%20Attendance%20Screen/Provider/TeamAttendanceProvider.dart';
import 'package:taskflow_application/AttendanceModule/Utills/Global%20Class/ColorHelper.dart';
import 'package:taskflow_application/AttendanceModule/Utills/Global%20Class/ScreenSize.dart';
import 'package:taskflow_application/Classes/Device_Info.dart';
import 'package:taskflow_application/Drawers/app_drawer.dart';
import 'package:taskflow_application/Screens/Dashboards%20screens/dashboard%20widget/admin_option_widget.dart';
import 'package:taskflow_application/Screens/Dashboards%20screens/dashboard%20widget/team_lead_option_widget.dart';
import 'package:taskflow_application/Screens/Dashboards%20screens/dashboard%20widget/user_option_widget.dart';
import 'package:taskflow_application/Screens/SampleScreen/SampleScreen.dart';

import '../../AttendanceModule/Screens/Team Attendance Screen/Model/AbsentUserModel.dart';

class DashboardPage extends StatefulWidget {

  DashboardPage({super.key, required this.role});
  String role = "1";

  @override
  State<DashboardPage> createState() => _DashboardPageState();

}

class _DashboardPageState extends State<DashboardPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Provider.of<TeamAttendanceProvider>(context).GetTeamAttendance(context);
    getUserActivity(widget.role);
  }

  //function to get the activity status of the users of the company
  getUserActivity(String userRole){
    if(userRole == "1"){

      //get all the users activity
    }
    else if(userRole == "2"){
      //get the team lead members activity
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(role: int.parse(widget.role)),
      body: Column(
        children: [
          pageHeaderContainer(),
          SizedBox(
            height: screenHeight/50,
          ),
          widget.role != "3"? memberStats()  :Container(),

        ],
      ),
    );
  }

  Widget customNavigationBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Builder(
              builder: (context) => IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(CupertinoIcons.line_horizontal_3)),
            ),
            const SizedBox(
              width: 10,
            ),
            //code for the greeting user
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "Hello, ",
                    style: TextStyle(
                        fontSize: DeviceInfo.fontSize + 1,
                        color: Colors.redAccent.shade700.withOpacity(0.7),
                        fontWeight: FontWeight.w500)),
                TextSpan(
                    text: Provider.of<UserDetail>(context, listen: false)
                            .fullname
                            .toString() ??
                        "User",
                    style: TextStyle(
                        fontSize: DeviceInfo.fontSize + 1,
                        color: Colors.black,
                        fontWeight: FontWeight.w500))
              ]),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Samplescreen()));
            }, icon: const Icon(CupertinoIcons.bell)),
            const SizedBox(
              width: 10,
            ),
            Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(20),
              child: const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/icreativez.png")),
            )
          ],
        )
      ],
    );
  }

  Widget gridButtons() {
    return widget.role == "1"
        ? const AdminDashboardButtons()
        : widget.role == "2"
            ? const TeamLeadDashboardButtons()
            : const UserDashboardButtons();
  }

  Widget memberStats(){
    return
      Container(
        height: screenHeight/8,
        width: screenWidth*0.95,
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(screenWidth/12),
            boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  color: CupertinoColors.systemGrey2,
                  offset: Offset(0, 4)
              ),
            ]
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                child:InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAttendance()));

                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Online",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth/25
                                )
                            ),),
                          SizedBox(
                            width: screenWidth/80,
                          ),
                          Container(
                            height: screenWidth/30,
                            width: screenWidth/30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),

        Consumer<TeamAttendanceProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading==true) {
              return Text("0",
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: lightBlackColor,
                        fontWeight: FontWeight.w500,
                        fontSize: screenWidth/15
                    )
                ),);
            } else {
              return Text("${provider.onlineCount}",
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: lightBlackColor,
                        fontWeight: FontWeight.w500,
                        fontSize: screenWidth/15
                    )
                ),);
            }
          },
        )


                     /*Text("0",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: lightBlackColor,
                                fontWeight: FontWeight.w500,
                                fontSize: screenWidth/15
                            )
                        ),)*/

                    ],
                  ),
                )),
            Container(color: darkgreyColor,
              height: screenHeight/15,
              width: 1,
            ),
            Expanded(
                child:InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>absentUsers()));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text("Absent",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth/25
                                )
                            ),),
                          SizedBox(
                            width: screenWidth/80,
                          ),
                          Container(
                            height: screenWidth/30,
                            width: screenWidth/30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: darkgreyColor,
                            ),
                          ),
                        ],
                      ),
                      Consumer<TeamAttendanceProvider>(
                        builder: (context, provider, child) {
                          if (provider.isLoading==true) {
                            return Text("0",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: lightBlackColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: screenWidth/15
                                  )
                              ),);
                          } else {
                            return Text("${provider.offlineCount}",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: lightBlackColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: screenWidth/15
                                  )
                              ),);
                          }
                        },
                      )

                    ],
                  ),
                )),
            Container(color: darkgreyColor,
              height: screenHeight/15,
              width: 1,
            ),
            Expanded(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Total",
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth/25
                          )
                      ),),
                    Consumer<TeamAttendanceProvider>(
                      builder: (context, provider, child) {
                        if (provider.isLoading==true) {
                          return Text("0",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: lightBlackColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: screenWidth/15
                                )
                            ),);
                        } else {
                          return Text("${provider.totalCount}",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: lightBlackColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: screenWidth/15
                                )
                            ),);
                        }
                      },
                    )

                  ],
                )),
          ],
        ),
      );
  }
  //code for the page header which contains the navigation bar and the gridview buttons
  Widget pageHeaderContainer() {
    return Material(
      elevation: 6,
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      child: Container(
          height: MediaQuery.of(context).size.height / 2 + 40,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: DeviceInfo.height * 0.05,
                ),
                //my custom navigation bar
                customNavigationBar(),

                //here is the code for the custom gridview boxes
                gridButtons(),

              ],
            ),
          )),
    );
  }
}
