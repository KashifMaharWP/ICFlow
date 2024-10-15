class ApiDetail{
  static String BaseAPI = 'https://flow-backend-ic-production.up.railway.app/api/';
  static String loginAPI="user/login";
  static String SignUpAPI="user/create";
  static String CheckIn="attendance/checkIn";
  static String CheckOut="attendance/checkOut";
  static String AtdHistory="attendance/getMyMonthAttendance/";
  static String TeamLeadList="user/getMyTeamLead";
  static String ViewTeamAttendance="attendance/getMyTeamMemberAttendanceStatus";
  static String ViewWorkingHrs="attendance/myWorkingHours/";
  static String absentUsers="attendance/getAllTodayAbsentUsers";
  static String presentUsers="attendance/getAllTodayPresentUsers";
  static String todayAttendnace="attendance/getTodayAttendance";
  static String uploadProfile="user/updatePicture";
  static String applyLeave="leave/apply";
  static String getLeave="leave/getMyLeaves";
  static String getMyComments="comment/getMyComments";
  static String getAllComments="comment/getAllComments";
  static String deleteComment="comment/delete";
  static String updateComment="comment/update";
  static String UserProfilePage="user/updatePicture";


}


