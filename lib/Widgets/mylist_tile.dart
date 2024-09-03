import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskflow_application/Classes/Device_Info.dart';
import 'package:taskflow_application/Routes/myroutes.dart';
import 'package:taskflow_application/Screens/Login%20screens/login_page.dart';
import 'package:taskflow_application/Widgets/logOut_widget.dart';

class MyListTile extends StatefulWidget {
  MyListTile(
      {super.key,
      required this.iconss,
      required this.title,
      required this.route});
  IconData iconss;
  String title;
  final route;

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  String? prefUid = '';

  Future _getUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('drawer page = ${prefs.getString('userId').toString()}');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (DeviceInfo.height < 650) ? 45 : 55,
      child: ListTile(
        leading: Icon(
          widget.iconss,
          color: Colors.red.shade900,
          size: DeviceInfo.fontSize + 6,
        ),
        title: Text(
          widget.title,
          style:
              TextStyle(color: Colors.black, fontSize: DeviceInfo.fontSize - 1),
        ),
        onTap: () async {
          if (widget.title == "Logout") {
            await showDialog(
                context: context,
                builder: (_) => ConfirmationDialog(
                    title: "Logout",
                    description: "Are you Sure do you want to logout?"));
            // _getUserDetail();
            // print('user id = ${prefUid}');
          }
          widget.route != ""
              ? Navigator.pushNamed(context, widget.route)
              : Navigator.pushNamed(context, AppRoutes.homePage);
        },
      ),
    );
  }
}
