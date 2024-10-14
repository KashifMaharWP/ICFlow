
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskflow_application/Module/ComplainModule/Screens/screen/AdminScreen.dart';
import 'package:taskflow_application/Module/ComplainModule/Screens/Provider/AdminProvider.dart';

import 'package:taskflow_application/Routes/myroutes.dart';
import 'package:taskflow_application/Widgets/mylist_tile.dart';
//import 'package:taskflow_application/comment_module/Screens/screen/AdminScreen.dart';
//import 'package:taskflow_application/comment_module/Screens/Provider/AdminProvider.dart'; // Make sure this path is correct


class AdminOption extends StatefulWidget {
  const AdminOption({super.key});

  @override
  State<AdminOption> createState() => _AdminOptionState();
}

class _AdminOptionState extends State<AdminOption> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyListTile(
            iconss: CupertinoIcons.bus,
            title: "Manage User",
            route: AppRoutes.manageUserPage),
        MyListTile(
            iconss: CupertinoIcons.doc_chart,
            title: "View Leave",
            route: AppRoutes.samplePage),
        MyListTile(
            iconss: CupertinoIcons.doc_fill,
            title: "Create Project",
            route: AppRoutes.samplePage,),
        MyListTile(
            iconss: CupertinoIcons.pin_fill,
            title: "View Complain",
            route: AppRoutes.AdminScreen),
        MyListTile(iconss: CupertinoIcons.share, title: "Share App", route: AppRoutes.samplePage),
        MyListTile(
            iconss: CupertinoIcons.circle_fill,
            title: "Logout",
            route: AppRoutes.loginPage),
      ],
    );
  }
}
