import 'package:flutter/material.dart';
import 'package:taskflow_application/Screens/Manage%20User%20Screens/manage_user_page.dart';
import 'package:taskflow_application/Screens/SampleScreen/SampleScreen.dart';
import 'package:taskflow_application/Widgets/dashboard_button.dart';

class AdminDashboardButtons extends StatefulWidget {
  const AdminDashboardButtons({super.key});

  @override
  State<AdminDashboardButtons> createState() => _AdminDashboardButtons();
}

class _AdminDashboardButtons extends State<AdminDashboardButtons> {
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
              btnName: "Create Project",
              ontap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) =>  Samplescreen()));
              }),
          CustomDashboardButton(
              colors: Colors.red,
              btnName: "Manage User",
              ontap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ManageUserPage()));
              }),
          CustomDashboardButton(
              colors: Colors.yellow,
              btnName: "View Leave",
              ontap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => Samplescreen()));
              }),
          CustomDashboardButton(
              colors: Colors.green,
              btnName: "Peformance",
              ontap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => Samplescreen()));
              }),
        ],
      ),
    );
  }
}
