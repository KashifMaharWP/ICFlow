import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_application/API/designation_model.dart';
import 'package:taskflow_application/API/jobType_model.dart';
import 'package:taskflow_application/API/login_user_detail.dart';
import 'package:taskflow_application/API/role_model.dart';
import 'package:taskflow_application/AttendanceModule/Screens/Attendance%20Screen/Provider/attendanceProvider.dart';
import 'package:taskflow_application/AttendanceModule/Screens/Team%20Attendance%20Screen/Provider/TeamAttendanceProvider.dart';
import 'package:taskflow_application/Classes/manageUser_class.dart';
import 'package:taskflow_application/Screens/Dashboards%20screens/dashboard_page.dart';
import 'package:taskflow_application/Screens/Manage%20User%20Screens/profile_page.dart';
import 'package:taskflow_application/Screens/Project%20screens/project_page.dart';
import 'package:taskflow_application/Screens/Task%20screens/task_page.dart';

import '../../AttendanceModule/Screens/Team Attendance Screen/Model/ViewTodyAttendanceModel.dart';
import '../SampleScreen/SampleScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //variable to store the index of the navigation bar
  int _selectedIndex = 0;
  late String userRole;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   //*******Uncomment the below to use the user functionalities ****** */
   
    //getting all the data from the server
     Role.getRole(context);
    JobType.getJobType();
    Designation.getDesignation();
     Provider.of<ManageUser>(context, listen: false).getAllUsers(context);

    //get the user role from the UserDetail provider class
    userRole =
        Provider.of<UserDetail>(context, listen: false).roleId.toString();

    //Get Team Attendance from the Team Attendance Provider
    if(userRole!=3){
      WidgetsBinding.instance.addPostFrameCallback((_){
        Provider.of<TeamAttendanceProvider>(context, listen: false).fetchTeamAttendanceData(context);
      });

    }

  }


  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      DashboardPage(role: userRole ?? "1"),
      const Samplescreen(),
      const Samplescreen(),
      UserProfilePage(
        isCurrentUserProfile: true,
      )
    ];
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (int newIndex) {
                setState(() {
                  _selectedIndex = newIndex;
                  debugPrint(newIndex.toString());
                });
              },
              type: BottomNavigationBarType.fixed,
              elevation: 20,
              backgroundColor: Colors.white,
              selectedItemColor: Colors.redAccent.shade700,
              unselectedItemColor: Colors.grey,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(
                    label: 'Home', icon: Icon(CupertinoIcons.home)),
                BottomNavigationBarItem(
                    label: 'Project', icon: Icon(CupertinoIcons.book)),
                BottomNavigationBarItem(
                    label: 'Calender Task',
                    icon: Icon(CupertinoIcons.calendar)),
                BottomNavigationBarItem(
                    label: 'Calender Task',
                    icon: Icon(CupertinoIcons.profile_circled)),
              ]),
          body: screens[_selectedIndex]
          // body: Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Column(
          //     children: [
          //       ListView.builder(
          //           itemCount: ProjectCatalog.projects.length,
          //           itemBuilder: (context, index) {
          //           return ProjectWidget(project: ProjectCatalog.projects[index]);
          //           }),
          //     ],
          //   ),
          // ),
          ),
    );
  }
}
