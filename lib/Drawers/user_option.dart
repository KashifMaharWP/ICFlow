
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskflow_application/Routes/myroutes.dart';
import 'package:taskflow_application/Widgets/mylist_tile.dart';

class UserOption extends StatefulWidget {
  const UserOption({super.key});

  @override
  State<UserOption> createState() => _UserOptionState();
}

class _UserOptionState extends State<UserOption> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //MyListTile(iconss: CupertinoIcons.person, title: "Profile", route: AppRoutes.userProfilePage),
        MyListTile(
            iconss: CupertinoIcons.bus, title: "Apply Leave", route: AppRoutes.samplePage ),
        MyListTile(
            iconss: CupertinoIcons.info_circle_fill,
            title: "Project",
            route: AppRoutes.projectPage),
        MyListTile(iconss: CupertinoIcons.share, title: "Share App", route: AppRoutes.samplePage),
        MyListTile(
            iconss: CupertinoIcons.circle_fill,
            title: "Logout",
            route: AppRoutes.loginPage),
      ],
    );
  }
}
