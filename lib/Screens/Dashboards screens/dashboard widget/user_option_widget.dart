import 'package:flutter/material.dart';
import 'package:taskflow_application/AttendanceModule/Screens/Attendance%20History/Screen/AtdHistoryScreen.dart';
import 'package:taskflow_application/AttendanceModule/Screens/Attendance%20Screen/Screen/Attedance_screen.dart';
import 'package:taskflow_application/Screens/Manage%20User%20Screens/add_user_page.dart';
import 'package:taskflow_application/Screens/SampleScreen/SampleScreen.dart';
import 'package:taskflow_application/Widgets/dashboard_button.dart';

import '../../../AttendanceModule/Screens/Leave Management/Screen/userLeaveManagement.dart';

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
              btnName: "Manage Commanents",
              ontap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => Samplescreen()));
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
