import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_application/Api/registration.dart';
import 'package:taskflow_application/Classes/Device_Info.dart';
import 'package:taskflow_application/Screens/Registration%20screens/company_reg_page.dart';
import 'package:taskflow_application/Widgets/rounded_button.dart';
import 'package:taskflow_application/Widgets/textfield.dart';

class RegistrationPage2 extends StatefulWidget {
  const RegistrationPage2({super.key});

  @override
  State<RegistrationPage2> createState() => _RegistrationPage2State();
}

class _RegistrationPage2State extends State<RegistrationPage2> {
  //Controllers of the textform field
  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();

// function to send the details
  void setAdminDetails() {
    setState(() {
      Provider.of<RegistrationProvider>(context, listen: false).fullname =
          _fullnameController.text;
      Provider.of<RegistrationProvider>(context, listen: false).email =
          _emailController.text;
      Provider.of<RegistrationProvider>(context, listen: false).contact =
          _contactController.text;
      Provider.of<RegistrationProvider>(context, listen: false).address =
          _addressController.text;
      Provider.of<RegistrationProvider>(context, listen: false).password =
          _passwordController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.redAccent.shade700,
        // backgroundColor: Colors.white,
        body: Column(
          children: [
            const SizedBox(height: 18),
            //widget of page back button and heading
            pageHeader(),
            SizedBox(height: DeviceInfo.height / 15),
            //Form container
            FormContiner()
          ],
        ));
  }

//Widget header
  Widget pageHeader() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                iconSize: DeviceInfo.fontSize + 15,
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistrationPage1()));
                },
                icon: const Icon(CupertinoIcons.back))
          ],
        ),
        Text(
          "Admin Registration",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: DeviceInfo.fontSize + 5),
        ),
      ],
    );
  }

//form container
  Widget FormContiner() {
    return Container(
      height: DeviceInfo.height - (DeviceInfo.height / 5.32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(35), topRight: Radius.circular(35)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 4),
            // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            FormTextContainer(),
            const SizedBox(
              height: 50,
            ),
            RoundedButton(
                title: "Register",
                loading: false,
                on_Tap: () {
                  setAdminDetails();

                  Provider.of<RegistrationProvider>(context, listen: false)
                      .registerAdmin();
                })
          ],
        ),
      ),
    );
  }

// widget text form field
  Widget FormTextContainer() {
    return Form(
        child: Column(
      children: [
        TextFieldWidget(
            widgetcontroller: _fullnameController,
            fieldName: "Fullname",
            widgeticon: CupertinoIcons.person,
            isPasswordField: false),
        const SizedBox(
          height: 30,
        ),
        //
        TextFieldWidget(
            widgetcontroller: _emailController,
            fieldName: "Email",
            widgeticon: CupertinoIcons.envelope,
            isPasswordField: false),

        const SizedBox(
          height: 30,
        ),
        //
        TextFieldWidget(
          widgetcontroller: _contactController,
          fieldName: "Contact",
          widgeticon: CupertinoIcons.phone,
          isPasswordField: false,
          keyboardtype: TextInputType.number,
        ),
        const SizedBox(
          height: 30,
        ),
        //
        TextFieldWidget(
          widgetcontroller: _addressController,
          fieldName: "Address",
          widgeticon: CupertinoIcons.news,
          isPasswordField: false,
          keyboardtype: TextInputType.text,
        ),

        const SizedBox(
          height: 30,
        ),
        //
        TextFieldWidget(
          widgetcontroller: _passwordController,
          fieldName: "Password",
          widgeticon: CupertinoIcons.lock_fill,
          isPasswordField: false,
          keyboardtype: TextInputType.visiblePassword,
        ),
      ],
    ));
  }
}
