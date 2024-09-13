import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_application/API/designation_model.dart';
import 'package:taskflow_application/API/login_user_detail.dart';
import 'package:taskflow_application/AttendanceModule/Utills/Global%20Class/ScreenSize.dart';
import 'package:taskflow_application/Classes/Device_Info.dart';
import 'package:taskflow_application/Classes/manageUser_class.dart';
import 'package:taskflow_application/Widgets/textfield.dart';

class UserProfilePage extends StatefulWidget {
  UserProfilePage({super.key, this.users, this.isCurrentUserProfile});
  late ManageUser? users;
  bool? isCurrentUserProfile;
  @override
  State<UserProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<UserProfilePage> {
  // here we initialize the controlle of the text fields

  late UserDetail currentUser;
  bool isCurrentUser = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.users == null) {
      currentUser = Provider.of<UserDetail>(context, listen: false);
      isCurrentUser = true;
      print("UserName${currentUser.fullname}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //here we first display the header container of the screen in which contains the picture of the user and the name, and desingaiton name of the user
          pageHeaderContaienr(),
          //here we display the text fields of the user where the data of the user will be shown
          const SizedBox(height: 15),

          // code to of all user profile data widget
          ProfileFieldWidget(
              "Email",
              isCurrentUser
                  ? currentUser.email.toString()
                  : widget.users!.email.toString(),
              CupertinoIcons.envelope),
          const SizedBox(
            height: 10,
          ),
          ProfileFieldWidget(
              "Contact",
              isCurrentUser
                  ? currentUser.contact.toString()
                  : widget.users!.contact.toString(),
              CupertinoIcons.phone),
          const SizedBox(
            height: 10,
          ),
          ProfileFieldWidget(
              "Address",
              isCurrentUser
                  ? currentUser.address.toString()
                  : widget.users!.address.toString(),
              CupertinoIcons.text_badge_star),

          const SizedBox(
            height: 10,
          ),

          //here we use the designation name functiont to get the designation of the user
          ProfileFieldWidget(
              "Designation", Provider.of<Designation>(
              context,
              listen: false)
              .getDesignationName(isCurrentUser ? currentUser.designationId.toString(): widget.users!.designationId.toString() ), CupertinoIcons.rocket),


        ],
      ),
    );
  }

  Widget pageHeaderContaienr() {
    return Material(
      elevation: 6,
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40)),
            gradient: RadialGradient(colors: [
              Colors.redAccent,
              Colors.red.shade900,
              const Color.fromARGB(255, 114, 9, 1)
            ])),
        child: Column(
          children: [
            SizedBox(
              height: DeviceInfo.height * 0.04,
            ),
            customNavigationBar(),
            SizedBox(
              height: DeviceInfo.height * 0.04,
            ),
            Center(
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(100),
                child: Container(
                    width: DeviceInfo.width * 0.35,
                    height: DeviceInfo.width * 0.35,
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    child: Image.network(currentUser.picture as String))/*AssetImage(isCurrentUser
                            ? "assets/images/usericon.png"
                            : "assets/images/usericon.png"))),*/
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            //displaying the name of the user
            Text(
              isCurrentUser
                  ? currentUser.fullname.toString()
                  : widget.users!.fullname.toString(),
              style: const TextStyle(color: Colors.white),
            ),

            const SizedBox(
              height: 15,
            ),
            //here we are displaying the role of the user
            Text(
              isCurrentUser
                  ? Provider.of<Designation>(context, listen: false)
                      .getDesignationName(currentUser.designationId.toString())
                  : Provider.of<Designation>(context, listen: false)
                      .getDesignationName(
                          widget.users!.designationId.toString()),
              style: const TextStyle(color: Colors.white),
            ),

//    here we set the user role
            Text(
              isCurrentUser
                  ? currentUser.roleId == "1"
                      ? "Admin"
                      : currentUser.roleId == "2"
                          ? "Team Lead"
                          : "Team Member"
                  : widget.users!.roleId == "1"
                      ? "Admin"
                      : widget.users!.roleId == "2"
                          ? "Team Lead"
                          : "Team Member",
              style: const TextStyle(color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }

//Widget for the custom navigation bar
  Widget customNavigationBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //back button
          widget.isCurrentUserProfile!
              ? const Text("         ")
              : IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(CupertinoIcons.back),
                  color: Colors.white,
                ),

          // Displaying Text
          const Center(
            child: Text(
              "Profile",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ),

          //Settings button to edit or Delete the user

          PopupMenuButton(
              initialValue: 1,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                      onTap: () {}, value: 1, child: const Text("Edit")),
                  PopupMenuItem(
                      onTap: () {},
                      value: 2,
                      child: const Text("Delete Account"))
                ];
              },
              icon: const Icon(
                CupertinoIcons.settings,
                color: Colors.white,
              ))
        ],
      ),
    );
  }

  //function to display the fields of the user
  Widget ProfileFieldWidget(
      String title, String displayData, IconData fieldIcon) {
    return Container(
      height: DeviceInfo.width * 0.13,
      width: DeviceInfo.width - 30,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //first row to display icon and name of the field
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                fieldIcon,
                color: Colors.red.shade800,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "${title} :",
                style: TextStyle(color: Colors.black.withOpacity(0.7)),
              ),
            ],
          ),
          SizedBox(width: screenWidth/24,),
          //here we are displaying the user details
          Flexible(
            child: Text(
              textAlign: TextAlign.end,
              displayData,
              style: TextStyle(color: Colors.black.withOpacity(0.7)),
            ),
          )


        ],
      ),
    );
  }
}
