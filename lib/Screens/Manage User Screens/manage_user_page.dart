import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_application/API/designation_model.dart';
import 'package:taskflow_application/API/login_user_detail.dart';
import 'package:taskflow_application/Classes/Device_Info.dart';
import 'package:taskflow_application/Classes/manageUser_class.dart';
import 'package:taskflow_application/Screens/Manage%20User%20Screens/add_user_page.dart';
import 'package:taskflow_application/Screens/Manage%20User%20Screens/profile_page.dart';
import 'package:taskflow_application/Widgets/textfield2.dart';

class ManageUserPage extends StatefulWidget {
  const ManageUserPage({super.key});

  @override
  State<ManageUserPage> createState() => _ManageUserPageState();
}

class _ManageUserPageState extends State<ManageUserPage> {
  //here is the function to get the designation text for the id

  final _searchController = TextEditingController();

  Future<String> getDesignationName(List<Designation> deslist) async {
    // final desigList = Provider.of<Designation>(context, listen: false)
    //     .getUserDesignation(index);

    // final name = Provider.of<Designation>(context, listen: false)
    //     .getDesignationNameWhereRoleIsOne(deslist);
    return "";
    //print("Designation List: ${desigList['2'].toString()} ");
    // print("desig: ${desigList.map((value) {
    //   return value.name!.toString();
    // })}");

    // final name = desigList.map((value) {
    //   return value.name!.toString();
    // });
    // return name.toString();
  }

  //function to store the user catalog
  bool isLoading = false;
  void getData() async {
    isLoading = await Provider.of<ManageUser>(context, listen: false)
        .getAllUsers(context);
    setState(() {
      isLoading;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    const threeSec = Duration(seconds: 2);
    // Future.delayed(threeSec, () {
    //   getDesignationName();
    // });
    Future.delayed(const Duration(seconds: 2), () {
      // if(Provider.of<ManageUser>(context, listen: false).allUsersList != null){
      getData();
      //}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.redAccent.shade700,
        foregroundColor: Colors.white,
        centerTitle: true,
        shadowColor: Colors.black,
        title: const Text("Users"),
        actions: [
          IconButton(
              onPressed: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AddUser()));

                getData();
              },
              icon: const Icon(CupertinoIcons.plus))
        ],
      ),
      body: !isLoading
          ? const Center(child: CircularProgressIndicator())
          : Consumer<ManageUser>(
              builder: (context, manageUser, child) => Padding(
                padding: const EdgeInsets.only(left: 0, right: 0, top: 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFieldWidget2(
                          isPasswordField: false,
                          widgetcontroller: _searchController,
                          fieldName: "Search"),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: manageUser.allUsersList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          spreadRadius: 1.5,
                                          blurRadius: 4,
                                          offset: Offset(4, 3))
                                    ]),
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                height: DeviceInfo.width * 0.3,
                                width: DeviceInfo.width * 0.7,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // here the inside box code starts
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: DeviceInfo.width * 0.2,
                                            height: DeviceInfo.width * 0.2,
                                            child: Material(
                                              elevation: 4,
                                              color: Colors.black,
                                              clipBehavior: Clip.antiAlias,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: const ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(40)),
                                                child: Image(
                                                    image: AssetImage(
                                                        "assets/images/usericon.png")),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          //here we will display the name of the user
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              //User FUll name Widget
                                              Text(
                                                manageUser.allUsersList[index]
                                                    .fullname!,
                                                style: TextStyle(
                                                    fontSize: DeviceInfo.width *
                                                        0.045,
                                                    color: const Color.fromARGB(
                                                        255, 163, 4, 4),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),

                                              Text(Provider.of<Designation>(
                                                          context,
                                                          listen: false)
                                                      .getDesignationName(
                                                          manageUser
                                                              .allUsersList[
                                                                  index]
                                                              .designationId
                                                              .toString())
                                                  // Provider.of<Designation>(
                                                  //         context,
                                                  //         listen: false)
                                                  //     .getDesignationName(
                                                  //         index.toString()),
                                                  // manageUser.allUsersList[index]
                                                  //   .designationId!
                                                  //   .toString()
                                                  ),

                                              const SizedBox(
                                                height: 10,
                                              ),

                                              Text(manageUser
                                                          .allUsersList[index]
                                                          .roleId! ==
                                                      "1"
                                                  ? "Admin"
                                                  : manageUser
                                                              .allUsersList[
                                                                  index]
                                                              .roleId ==
                                                          "2"
                                                      ? "Team Lead"
                                                      : "Team Member")
                                            ],
                                          ),
                                          const Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              //User FUll name Widget

                                              PopupMenuButton(
                                                  initialValue: 0,
                                                  itemBuilder: (context) {
                                                    return [
                                                      PopupMenuItem(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (_) =>
                                                                        UserProfilePage(
                                                                          users:
                                                                              manageUser.allUsersList[index],
                                                                          isCurrentUserProfile:
                                                                              false,
                                                                        )));
                                                          },
                                                          value: 1,
                                                          child: const Text(
                                                              "Edit")),
                                                      PopupMenuItem(
                                                          onTap: () {},
                                                          value: 2,
                                                          child: const Text(
                                                              "Delete Account"))
                                                    ];
                                                  },
                                                  icon: const Icon(
                                                    Icons.menu,
                                                    color: Colors.grey,
                                                  ))
                                              // IconButton(
                                              //     onPressed: () {
                                              //       print(manageUser
                                              //           .allUsersList[index]
                                              //           .fullname!
                                              //           .toString());
                                              //     },
                                              //     icon: const Icon(
                                              //         CupertinoIcons
                                              //             .line_horizontal_3))
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),

                    //here is the code to check the data of the list
                  ],
                ),
              ),
            ),
    );
  }
}
