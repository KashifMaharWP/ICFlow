import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../../../../API/login_user_detail.dart';
import '../../../Utills/Global Class/GlobalAPI.dart';
import '../../../Utills/Global Functions/SnackBar.dart';
import '../Model/AbsentUserModel.dart';
import '../Model/PresentUserModel.dart';
import '../Model/ViewTodyAttendanceModel.dart';


class TeamAttendanceProvider extends ChangeNotifier {

  int onlineCount = 0;
  int presentCount = 0;
  num offlineCount = 0;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  setIsLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  // Fetch both online and absent user data together
  Future<void> fetchTeamAttendanceData(BuildContext context) async {
    setIsLoading(true);
    try {
      await GetTeamAttendance(context);
      await getAbsentUser(context);
      await getPrsentUser(context);// Fetch absent user data

    } catch (e) {
      print("Error: $e");
      showErrorSnackbar("There was an error: $e", context);
    } finally {
      setIsLoading(false);
    }
  }

  Future<ViewTodyAttendanceModel> GetTeamAttendance(BuildContext context) async {
    String URL = "${ApiDetail.BaseAPI}${ApiDetail.ViewTeamAttendance}";
    try {
      Response response = await http.get(Uri.parse(URL), headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Provider.of<UserDetail>(context, listen: false).token} "
      });

      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        onlineCount = ViewTodyAttendanceModel.fromJson(data).onlineUserAttendanceRecord!.length;
        notifyListeners();
        return ViewTodyAttendanceModel.fromJson(data);
      } else if (response.statusCode == 400) {
        showErrorSnackbar("No record available", context);
        return ViewTodyAttendanceModel.fromJson(data);
      }
      else if(response.statusCode==408){
        showErrorSnackbar("Please check your internet connection", context);
      }
      return ViewTodyAttendanceModel.fromJson(data);
    } catch (e) {
      print(e);
      showErrorSnackbar("TRY AGAIN!. Server is not responding. please check your internet connection.", context);
    }
    return ViewTodyAttendanceModel();
  }

  Future<AbsentUserModel> getAbsentUser(BuildContext context) async {
    String URL = "${ApiDetail.BaseAPI}${ApiDetail.absentUsers}";
    try {
      Response response = await http.get(Uri.parse(URL), headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Provider.of<UserDetail>(context, listen: false).token} "
      });

      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        offlineCount = AbsentUserModel.fromJson(data).count ?? 0;
        notifyListeners();
        return AbsentUserModel.fromJson(data);
      } else if (response.statusCode == 400) {
        showErrorSnackbar("No record available", context);
        return AbsentUserModel.fromJson(data);
      }
      else if(response.statusCode==408){
        showErrorSnackbar("Please check your internet connection", context);

      }
      return AbsentUserModel.fromJson(data);
    } catch (e) {
      print(e);
      showErrorSnackbar("TRY AGAIN!. Server is not responding. please check your internet connection.", context);
    }
    return AbsentUserModel();
  }

  Future<PresentUserModel> getPrsentUser(BuildContext context) async {
    String URL = "${ApiDetail.BaseAPI}${ApiDetail.presentUsers}";
    try {
      Response response = await http.get(Uri.parse(URL), headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Provider.of<UserDetail>(context, listen: false).token} "
      });

      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        presentCount = PresentUserModel.fromJson(data).presentUsers!.length;
        notifyListeners();
        return PresentUserModel.fromJson(data);
      } else if (response.statusCode == 400) {
        showErrorSnackbar("No record available", context);
        return PresentUserModel.fromJson(data);
      }
      else if(response.statusCode==408){
        showErrorSnackbar("Please check your internet connection", context);
      }
      return PresentUserModel.fromJson(data);
    } catch (e) {
      print(e);
      showErrorSnackbar("TRY AGAIN!. Server is not responding. please check your internet connection.", context);
    }
    return PresentUserModel();
  }
}
