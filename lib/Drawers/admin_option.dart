
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskflow_application/Routes/myroutes.dart';
import 'package:taskflow_application/Widgets/mylist_tile.dart';

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
            title: "VIew Complain",
            route: AppRoutes.samplePage),
        MyListTile(iconss: CupertinoIcons.share, title: "Share App", route: AppRoutes.samplePage),
        MyListTile(
            iconss: CupertinoIcons.circle_fill,
            title: "Logout",
            route: AppRoutes.loginPage),
      ],
    );
  }
}
