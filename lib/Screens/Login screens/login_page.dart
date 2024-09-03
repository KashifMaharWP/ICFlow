import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskflow_application/API/login_user_detail.dart';
import 'package:taskflow_application/API/user_login.dart';
import 'package:taskflow_application/Api/licencekey.dart';
import 'package:taskflow_application/AttendanceModule/Utills/Global%20Functions/SnackBar.dart';
import 'package:taskflow_application/Classes/Device_Info.dart';
import 'package:taskflow_application/Screens/Dashboards%20screens/home.dart';

import 'package:taskflow_application/Widgets/rounded_button.dart';
import 'package:taskflow_application/Widgets/textfield.dart';

import '../../Routes/myroutes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _regController = TextEditingController();
  final _SignInformKey=GlobalKey<FormState>();

  bool isloading = false;
  late final void Function() _ontap = () async {
    login();

  };

  login() async{
    if(_SignInformKey.currentState!.validate()){
      setState(() {
        isloading = true;
      });
      final authUser = await UserLogin.userLogin(
          _usernameController.text, _passwordController.text, context);

      if (authUser == true) {
        setState(() {
          isloading = false;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const HomePage()));
      } else {
        setState(() {
          isloading = false;
        });
      }
    }
  }
  late final VoidCallback _regOnTap = () async {
    Navigator.pop(context);

    await Provider.of<LicenceProvider>(context, listen: false)
        .checkKey(_regController.text, context);
      print("Key Status: "+Provider.of<LicenceProvider>(context, listen: false).isValid.toString());
    //if the licencekey is valid then
    if(Provider.of<LicenceProvider>(context, listen: false).isValid == true){
      Navigator.pushNamed(context, AppRoutes.companyRegPage);
    }
    else
      {
        //here error message should be displayed to the user
        final mess = "Invalid licence key please try again!";
        showErrorSnackbar(mess, context);
      }
  };

//Function to check the userpreferences
  checkUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final chk = prefs.getString('userId');
    print("User Id = $chk");
    //checking if the user detail is available then
    if (chk != '' && chk != null) {
      //get user data from the preference and store it in userdetail class
      Provider.of<UserDetail>(context, listen: false)
          .setUserDetailByPreferences();

      //after initializing the user detail class move the user to homepage
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const HomePage()));
    } else {
      print("User not found!");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Provider.of<UserDetail>(context, listen: false).clearUserPreferences();
    //checking that user was already logined or not if yes then move him dashboard
    checkUserData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _SignInformKey,
            child: Column(
              children: [
                // Logo container
                pageHeaderContaienr(),
                const SizedBox(height: 30),
          
                //Text field container
                textFieldContainer(),
          
                //round button
                RoundedButton(title: 'Login', loading: isloading, on_Tap: _ontap),
          
                SizedBox(
                  height: DeviceInfo.height / 25,
                ),
          
                //Registration
                regDecptContainer()
              ],
            ),
          ),
        ),
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
            color: Colors.redAccent.shade700),
        child: Center(
          child: Container(
              width: 150,
              height: 150,
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(40)),
              child: const Image(
                  image: AssetImage("assets/images/icreativez.png"))),
        ),
      ),
    );
  }

  Widget textFieldContainer() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          //Username text field
          TextFieldWidget(
              widgetcontroller: _usernameController,
              fieldName: "Username",
              widgeticon: CupertinoIcons.person,
              isPasswordField: false),
    
          SizedBox(
            height: DeviceInfo.height / 20,
          ),
    
          //Password text field
          TextFieldWidget(
              widgetcontroller: _passwordController,
              fieldName: "Password",
              widgeticon: CupertinoIcons.lock,
              isPasswordField: true)
        ],
      ),
    );
  }

  Widget regDecptContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Want to register your company? ",
          style: TextStyle(
              fontSize: DeviceInfo.fontSize - 1, color: Colors.grey.shade400),
        ),
        GestureDetector(
          onTap: () {
            showRegistrationDialog();
          },
          child: Text(
            "Register",
            style: TextStyle(
                color: Colors.red.shade800, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }

//function to display the dialog box for the registration purpose
  void showRegistrationDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  color: Colors.white,
                  width: DeviceInfo.width - 20,
                  height: DeviceInfo.height / 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Registration Key",
                        style: TextStyle(
                            fontSize: DeviceInfo.fontSize + 5,
                            fontWeight: FontWeight.w500,
                            color: Colors.red.shade800),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        textAlign: TextAlign.center,
                        controller: _regController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            hintText: "Enter Registration Key",
                            hintStyle:
                                TextStyle(fontSize: DeviceInfo.fontSize)),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: _regOnTap,
                        // onPressed: () {
                          //   final chk = LicenceProvider()
                          //       .checkKey(_regController.text, context);
                          //
                          //   if (chk == true) {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (_) =>
                          //                 const RegistrationPage1()));
                          //   } else {
                          //
                          //     MessageDialog(title: "Error", description: "Your Licence Key is Invalid",btnType: 1);
                          //     // ScaffoldMessenger.of(context).showSnackBar(
                          //     //     const SnackBar(content: Text("Invalid Key")));
                          //   }
                          // },
                          child: const Text("Register"))
                    ],
                  ),
                ),
              )
            ],
          ));
}
