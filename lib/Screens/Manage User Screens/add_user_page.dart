import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_application/API/designation_model.dart';
import 'package:taskflow_application/API/jobType_model.dart';
import 'package:taskflow_application/API/login_user_detail.dart';
import 'package:taskflow_application/API/role_model.dart';
import 'package:taskflow_application/AttendanceModule/Utills/Global%20Functions/SnackBar.dart';
import 'package:taskflow_application/Classes/Device_Info.dart';
import 'package:taskflow_application/Classes/manageUser_class.dart';
import 'package:taskflow_application/Widgets/message_dialog.dart';
import 'package:taskflow_application/Widgets/rounded_button.dart';
import 'package:taskflow_application/Widgets/textfield.dart';
import 'package:taskflow_application/Widgets/textfield2.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  // initializing the controllers
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();

  //here we are initializing the role value variable
  String roleDropdownValue = '1';
  String jobTypeDropdownValue = '1';
  String designationDropdownValue = '1';

  String comId = "";
  String token = "";
  
  String? roleId;

  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    roleId = Provider.of<UserDetail>(context, listen: false).roleId.toString();

  roleDropdownValue = roleId == "1"? "2": "3";
    super.initState();
    // Role.rolesMap.map((value) {
    //   print("Role Name "+value.name.toString());
    // }).toList();
    // JobType.jobTypeslist.map((value){
    //   print(value.name.toString());
    // });
    comId =
        Provider.of<UserDetail>(context, listen: false).companyId.toString();
    token = Provider.of<UserDetail>(context, listen: false).token.toString();
  }

  void setUserDetail() {
    Provider.of<ManageUser>(context, listen: false).fullname =
        _fullNameController.text;
    Provider.of<ManageUser>(context, listen: false).email =
        _emailController.text;
    Provider.of<ManageUser>(context, listen: false).contact =
        _contactController.text;
    Provider.of<ManageUser>(context, listen: false).address =
        _addressController.text;
    Provider.of<ManageUser>(context, listen: false).password =
        _passwordController.text;
    Provider.of<ManageUser>(context, listen: false).companyId = comId;
    Provider.of<ManageUser>(context, listen: false).token = token;
    Provider.of<ManageUser>(context, listen: false).jobTypeId =
        jobTypeDropdownValue.toString();
    Provider.of<ManageUser>(context, listen: false).designationId =
        designationDropdownValue.toString();
    Provider.of<ManageUser>(context, listen: false).roleId =
        roleDropdownValue.toString();

    //Provider.of(context)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: const Text("Add User"),
            foregroundColor: Colors.white,
            backgroundColor: Colors.redAccent.shade700),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              //here is code of the form
              userFormWidget(),
              const SizedBox(
                height: 20,
              ),
              //add user button
              RoundedButton(
                  title: "Add User",
                  loading: isLoading,
                  on_Tap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    setUserDetail();

                    bool check =
                        await Provider.of<ManageUser>(context, listen: false)
                            .addUser();
                    setState(() {
                      if (check == true) {
                        isLoading = false;
                        /*
                        showDialog(
                            context: context,
                            builder: (_) => MessageDialog(
                                title: "Success",
                                description: "User Successfully Added!",
                                btnType: 1));*/
                        Navigator.pop(context);
                        showSuccessSnackbar("User Created Successfully", context);
                      } else {
                        print("Failed To Add user");

                        setState(() {
                          isLoading = false;
                        });

                        showDialog(
                            context: context,
                            builder: (_) => MessageDialog(
                                title: "Error",
                                description:
                                    "Failed to add the user, server problem!",
                                btnType: 1));
                      }
                    });
                  }),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }

  Widget userFormWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text("FullName"),
            TextFieldWidget2(
              isPasswordField: false,
              widgetcontroller: _fullNameController,
              fieldName: "Full Name",
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Email"),
            TextFieldWidget2(
              isPasswordField: false,
              widgetcontroller: _emailController,
              fieldName: "Email",
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Contact"),
            TextFieldWidget2(
              isPasswordField: false,
              widgetcontroller: _contactController,
              fieldName: "Contact",
              keyboardtype: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),

            const Text("Address"),
            TextFieldWidget2(
              isPasswordField: false,
              widgetcontroller: _addressController,
              fieldName: "Address",
            ),
            const SizedBox(
              height: 20,
            ),

            // displaying two fields in a single row
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              //column for job type
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Job Type"),
                  Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white.withOpacity(0.7),
                    shadowColor: Colors.red.shade700.withOpacity(0.7),
                    child: SizedBox(
                      width: DeviceInfo.width * 0.4,
                      child: DropdownButtonFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ))),
                          value: jobTypeDropdownValue,
                          isExpanded: true,
                          items: JobType.jobTypeslist.map((value) {
                            return DropdownMenuItem(
                                value: value.id,
                                child: Text(value.name.toString()));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              jobTypeDropdownValue = value.toString();
                            });
                          }),
                    ),
                  )
                ],
              ),

              //column for Role
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("User Role"),
                  Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white.withOpacity(0.7),
                    shadowColor: Colors.red.shade700.withOpacity(0.7),
                    child: SizedBox(
                      width: DeviceInfo.width * 0.4,
                      child: DropdownButtonFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ))),
                          value: roleDropdownValue,
                          isExpanded: true,
                          items: [
                            DropdownMenuItem(
                                value: roleDropdownValue,
                                child: Text(roleId == "1" ? "Team Lead": "Team Member",))
                          ],
                          // items: Role.rolesMap.map((value) {
                          //   return DropdownMenuItem(
                          //       value: value.id,
                          //       child: Text(value.name.toString()));
                          // }).toList(),
                          onChanged: (value) {
                            setState(() {
                              roleDropdownValue = value.toString();
                              print(roleDropdownValue);
                            });
                          }
                          
                          ),
                    ),
                  )
                ],
              ),
            ]),
            const SizedBox(
              height: 20,
            ),
            const Text("Designation"),
            Material(
              elevation: 4,
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
              shadowColor: Colors.red.shade700.withOpacity(0.7),
              child: SizedBox(
                child: DropdownButtonFormField(
                    elevation: 5,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ))),
                    value: designationDropdownValue,
                    isExpanded: true,
                    items: Designation.designationList
                        .map((element) => DropdownMenuItem(
                            value: element.id.toString(),
                            child: Text(element.name.toString())))
                        .toList(),

                    onChanged: (value) {
                      setState(() {
                        designationDropdownValue = value.toString();
                      });
                    }),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Password"),

            TextFieldWidget2(
              widgeticon: CupertinoIcons.lock,
              widgetcontroller: _passwordController,
              fieldName: "Password",
              isPasswordField: true,
            ),
          ],
        ),
      ),
    );
  }
}
