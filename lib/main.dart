import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_application/API/designation_model.dart';
import 'package:taskflow_application/API/login_user_detail.dart';
import 'package:taskflow_application/Api/licencekey.dart';
import 'package:taskflow_application/Api/registration.dart';
import 'package:taskflow_application/Classes/Device_Info.dart';
import 'package:taskflow_application/Classes/manageUser_class.dart';
import 'package:taskflow_application/Module/ComplainModule/Screens/Provider/AdminProvider.dart';
import 'package:taskflow_application/Module/ComplainModule/Screens/Provider/commentProvider.dart';
//import 'package:taskflow_application/Module/ComplainModule/Screens/Provider/ComplainProvider.dart';
import 'package:taskflow_application/Module/LeaveModule/Leave%20Management/Provider/leaveProvider.dart';
import 'package:taskflow_application/Routes/myroutes.dart';
import 'package:taskflow_application/Screens/Login%20screens/login_page.dart';

import 'Module/AttendanceModule/Attendance History/Provider/HistoryProvider.dart';
import 'Module/AttendanceModule/Attendance Screen/Provider/attendanceProvider.dart';
import 'Module/AttendanceModule/Team Attendance Screen/Provider/TeamAttendanceProvider.dart';
import 'Module/LeaveModule/LeaveForm Screen/Provider/LeaveFormProvider.dart';
import 'Module/Utills/Global Class/ScreenSize.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      DeviceInfo.height = constraints.maxHeight;
      DeviceInfo.width = constraints.maxWidth;
      DeviceInfo.fontSize = 16.0;

      if (DeviceInfo.width <= 350) {
        DeviceInfo.fontSize = 13.0;
      } else if (DeviceInfo.width > 350 && DeviceInfo.width <= 450) {
        DeviceInfo.fontSize = 15.0;
      } else if (DeviceInfo.width > 450 && DeviceInfo.width <= 480) {
        DeviceInfo.fontSize = 16.0;
      } else {
        DeviceInfo.fontSize = 28.0;
      }
      screenWidth=MediaQuery.of(context).size.width;
      screenHeight=MediaQuery.of(context).size.height;
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => RegistrationProvider()),
          ChangeNotifierProvider(create: (_) => LicenceProvider()),
          ChangeNotifierProvider(create: (_) => UserDetail()),
          ChangeNotifierProvider(create: (_) => ManageUser()),
          ChangeNotifierProvider(create: (_) => Designation()),
          ChangeNotifierProvider(create: (context)=>AttendanceProvider(),),
          ChangeNotifierProvider(create: (context)=>HistoryProvider()),
          ChangeNotifierProvider(create: (context)=>LeaveFormProvider()),
          ChangeNotifierProvider(create: (context)=>TeamAttendanceProvider()),
          ChangeNotifierProvider(create: (context)=>CommentProvider()),
          ChangeNotifierProvider(create: (context)=>LeaveProvider()),
          ChangeNotifierProvider(create: (context)=>AdminProvider()),
        ],
        child: MaterialApp(
            routes: AppRoutes.getRoutes(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primaryColor: Colors.red.shade900),
            home: const LoginPage()),
      );
      localizationsDelegates: [
        //MonthYearPickerLocalizations.delegate,
      ];
    });
  }
}
