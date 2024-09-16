import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_application/API/login_user_detail.dart';
import 'package:taskflow_application/Drawers/TeamLead_option.dart';
import 'package:taskflow_application/Drawers/admin_option.dart';
import 'package:taskflow_application/Drawers/user_option.dart';

class AppDrawer extends StatefulWidget {
  AppDrawer({super.key, required this.role});
  int role;
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String userRole = "";

  @override
  void initState() {
    super.initState();
    switch (widget.role) {
      case 1:
        setState(() {
          userRole = "Admin";
        });
      case 2:
        setState(() {
          userRole = "Team Lead";
        });
      case 3:
        setState(() {
          userRole = "Team Member";
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      var fontSize = 16.0;
      if (width <= 350) {
        fontSize = 13.0;
      } else if (width > 350 && width <= 480) {
        fontSize = 15.0;
      } else {
        fontSize = 28.0;
      }
      return Consumer<UserDetail>(
        builder: (context, userInfoProvider, child) => Drawer(
          backgroundColor: Colors.white,
          width: MediaQuery.of(context).size.width / 1.25,
          child: ListView(
            children: [
              DrawerHeader(
                padding: EdgeInsets.zero,
                //margin: const EdgeInsets.all(22),
                child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Colors.red.shade900),
                    margin: EdgeInsets.zero,
                    currentAccountPicture: userInfoProvider.roleId != 3
                        ? const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/usericon.png'),
                          )
                        : Container(),
                    accountName: Text(
                      userInfoProvider.fullname!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(229, 255, 255, 255),
                        fontSize: fontSize,
                      ),
                    ),
                    accountEmail: Text(userRole,
                        style: TextStyle(
                            color: const Color.fromARGB(
                                255, 142, 243, 145),
                            fontWeight: FontWeight.bold,
                            fontSize: fontSize))),
              ),

              //buttons
              options(widget.role)
            ],
          ),
        ),
      );
    });
  }

//method to display the role and options with respect to roles of the user
//role 1 is admin, role 2 is driver and role 3 is student
  Widget options(int role) {
    if (role == 1) {
      return const AdminOption();
    } else if (role == 2) {
      return const TeamLeadOption();
    } else {
      return const UserOption();
    }
  }
}
