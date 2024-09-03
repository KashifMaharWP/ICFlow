import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskflow_application/Routes/myroutes.dart';
import 'package:taskflow_application/Widgets/mylist_tile.dart';

class TeamLeadOption extends StatefulWidget {
  const TeamLeadOption({super.key});

  @override
  State<TeamLeadOption> createState() => _TeamLeadOptionState();
}

class _TeamLeadOptionState extends State<TeamLeadOption> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyListTile(
            iconss: CupertinoIcons.pin_fill,
            title: "Create Project",
            route: AppRoutes.samplePage),
        MyListTile(
            iconss: CupertinoIcons.doc_chart_fill,
            title: "Admin Project",
            route: AppRoutes.samplePage),
        /*MyListTile(
            iconss: CupertinoIcons.phone_fill,
            title: "Profile",
            route: AppRoutes.userProfilePage),*/
        MyListTile(iconss: CupertinoIcons.share, title: "Share App", route: AppRoutes.samplePage),
        MyListTile(
            iconss: CupertinoIcons.circle_fill,
            title: "Logout",
            route: AppRoutes.loginPage),
      ],
    );
  }
}
