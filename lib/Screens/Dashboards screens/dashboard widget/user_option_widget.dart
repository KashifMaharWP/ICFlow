import 'package:flutter/material.dart';
import 'package:taskflow_application/Module/ComplainModule/Screens/screen/userComplainScreen.dart';
import 'package:taskflow_application/Screens/SampleScreen/SampleScreen.dart';
import 'package:taskflow_application/Widgets/dashboard_button.dart';

import '../../../Module/AttendanceModule/Attendance Screen/Screen/Attedance_screen.dart';
import '../../../Module/LeaveModule/Leave Management/Screen/userLeaveManagement.dart';

class UserDashboardButtons extends StatefulWidget {
  const UserDashboardButtons({super.key});

  @override
  State<UserDashboardButtons> createState() => _UserDashboardButtons();
}

class _UserDashboardButtons extends State<UserDashboardButtons> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            mainAxisExtent: 110),
        children: [
          CustomDashboardButton(
              colors: Colors.blue,
              btnName: "Manage Attendance",
              ontap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AttendanceScreen()));
              }),
          CustomDashboardButton(
              colors: Colors.red,
              btnName: "Complain Box",
              ontap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => userComplainScreen()));
              }),
          CustomDashboardButton(
              colors: Colors.yellow,
              btnName: "Manage Leave",
              ontap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => userLeaveManagement()));
              }),
          CustomDashboardButton(
              colors: Colors.green,
              btnName: "Manage Task",
              ontap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const Samplescreen()));
              }),
        ],
      ),
    );
  }
}
