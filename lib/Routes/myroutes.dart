// class AppRoutes{
//   static String loginPage = "/logout";
//   static String dashboardPage = '/dashboard';
//   static String companyRegPage = '/companyregistration';
//   static String adminRegPage = '/adminregistrationpage';
//   static String manageUserPage = '/manageuserpage';
//   static String addUserPage = '/adduserpage';
//   static String userProfilePage = '/userprofilepage';
//   static String homePage = '/homepage';
//   static String projectPage = '/projectpage';
//   static String addProjectPage = '/addprojectpage';
//   static String taskPage = '/taskpage';

// }

// lib/routes.dart

import 'package:flutter/material.dart';
import 'package:taskflow_application/Classes/manageUser_class.dart';
import 'package:taskflow_application/Classes/project.dart';
import 'package:taskflow_application/Screens/Dashboards%20screens/dashboard_page.dart';
import 'package:taskflow_application/Screens/Dashboards%20screens/home.dart';
import 'package:taskflow_application/Screens/Login%20screens/login_page.dart';
import 'package:taskflow_application/Screens/Manage%20User%20Screens/add_user_page.dart';
import 'package:taskflow_application/Screens/Manage%20User%20Screens/manage_user_page.dart';
import 'package:taskflow_application/Screens/Manage%20User%20Screens/profile_page.dart';
import 'package:taskflow_application/Screens/Registration%20screens/admin_reg_page.dart';
import 'package:taskflow_application/Screens/Registration%20screens/company_reg_page.dart';
import 'package:taskflow_application/Screens/SampleScreen/SampleScreen.dart';

import '../Module/ProjectModule/Project screens/add_project_page.dart';
import '../Module/ProjectModule/Project screens/project_page.dart';
import '../Module/ProjectModule/Task screens/task_page.dart';

class AppRoutes {
  static const String loginPage = "/login";
  static const String homePage = '/homepage';
  static const String dashboardPage = '/dashboard';
  static const String companyRegPage = '/companyregistration';
  static const String adminRegPage = '/adminregistrationpage';
  static const String manageUserPage = '/manageuserpage';
  static const String addUserPage = '/adduserpage';
  static const String userProfilePage = '/userprofilepage';
  static const String projectPage = '/projectpage';
  static const String addProjectPage = '/addprojectpage';
  static const String taskPage = '/taskpage';
  static const String samplePage = '/samplepage';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      loginPage: (context) => const LoginPage(),
      dashboardPage: (context) => DashboardPage(role: ""),
      companyRegPage: (context) => const RegistrationPage1(),
      adminRegPage: (context) => const RegistrationPage2(),
      manageUserPage: (context) => const ManageUserPage(),
      addUserPage: (context) => const AddUser(),
      userProfilePage: (context) => UserProfilePage(),
      homePage: (context) => const HomePage(),
      projectPage: (context) => const ProjectPage(),
      addProjectPage: (context) => const AddProjectPage(),
      taskPage: (context) => const TaskPage(),
      samplePage:(context)=>const Samplescreen(),
    };
  }
}
