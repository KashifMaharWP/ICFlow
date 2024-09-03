import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_application/Api/licencekey.dart';
import 'package:taskflow_application/Api/registration.dart';
import 'package:taskflow_application/Classes/Device_Info.dart';
import 'package:taskflow_application/Screens/Registration%20screens/admin_reg_page.dart';
import 'package:taskflow_application/Widgets/rounded_button.dart';
import 'package:taskflow_application/Widgets/textfield.dart';

class RegistrationPage1 extends StatefulWidget {
  const RegistrationPage1({super.key});

  @override
  State<RegistrationPage1> createState() => _RegistrationPage1State();
}

class _RegistrationPage1State extends State<RegistrationPage1> {
  //Controllers of the textform field
  final _companyNameController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _companyemailController = TextEditingController();
  final _companyContactController = TextEditingController();
  final _companyAddressController = TextEditingController();

//FUNCTION TO SET THE COMPANY DETAILS
  void setCompanyDetails() {
    setState(() {
      Provider.of<RegistrationProvider>(context, listen: false).comName =
          _companyNameController.text;
      Provider.of<RegistrationProvider>(context, listen: false).ownerName =
          _ownerNameController.text;
      Provider.of<RegistrationProvider>(context, listen: false).comContact =
          _companyContactController.text;
      Provider.of<RegistrationProvider>(context, listen: false).comEmail =
          _companyemailController.text;
      Provider.of<RegistrationProvider>(context, listen: false).comAddress =
          _companyAddressController.text;
    });
  }

  void ontap() async {
    setCompanyDetails();
    bool isreg = await Provider.of<RegistrationProvider>(context, listen: false)
        .registerCompany();

    print("isRegistered : $isreg");
    final chk = Provider.of<RegistrationProvider>(context, listen: false).comId;
    print("Comapany Id = $chk");
    if (isreg == true) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const RegistrationPage2()));
    } else {
      const AlertDialog(
        content: Text("Error While registering the company"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.redAccent.shade700,
        // backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: DeviceInfo.height / 12),
            Text(
              "Company Registration",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: DeviceInfo.fontSize + 5),
            ),
            SizedBox(height: DeviceInfo.height / 15),
            Container(
              height: DeviceInfo.height - (DeviceInfo.height / 5.32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35)),
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
                    //Text fields form
                    formTextContainer(),
                    const SizedBox(
                      height: 30,
                    ),
                    //rounded custom button widtet
                    RoundedButton(title: "Next", loading: false, on_Tap: ontap)
                  ],
                ),
              ),
            )
          ],
        ));
  }

// widget text form field
  Widget formTextContainer() {
    return Form(
        child: Column(
      children: [
        TextFieldWidget(
            widgetcontroller: _companyNameController,
            fieldName: "Company name",
            widgeticon: CupertinoIcons.doc_plaintext,
            isPasswordField: false),
        const SizedBox(
          height: 30,
        ),
        //
        TextFieldWidget(
            widgetcontroller: _ownerNameController,
            fieldName: "Owner's name",
            widgeticon: CupertinoIcons.person,
            isPasswordField: false),

        const SizedBox(
          height: 30,
        ),
        //
        TextFieldWidget(
          widgetcontroller: _companyemailController,
          fieldName: "Email",
          widgeticon: CupertinoIcons.news,
          isPasswordField: false,
          keyboardtype: TextInputType.emailAddress,
        ),
        const SizedBox(
          height: 30,
        ),
        //
        TextFieldWidget(
          widgetcontroller: _companyContactController,
          fieldName: "Company Phone",
          widgeticon: CupertinoIcons.phone,
          isPasswordField: false,
          keyboardtype: TextInputType.number,
        ),
        const SizedBox(
          height: 30,
        ),
        //
        TextFieldWidget(
            widgetcontroller: _companyAddressController,
            fieldName: "Address",
            widgeticon: CupertinoIcons.news_solid,
            isPasswordField: false),
      ],
    ));
  }
}
