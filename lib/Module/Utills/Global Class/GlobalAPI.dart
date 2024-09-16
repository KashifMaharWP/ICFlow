class ApiDetail{
  static String BaseAPI = 'https://backend-production-6e95.up.railway.app/api/';
  static String loginAPI="user/login";
  static String SignUpAPI="user/create";
  static String CheckIn="attendance/checkIn";
  static String CheckOut="attendance/checkOut";
  static String AtdHistory="attendance/getMyMonthAttendance/";
  static String TeamLeadList="user/getAllTeamHeads";
  static String ViewTeamAttendance="attendance/getMyTeamMemberAttendanceStatus";
  static String ViewWorkingHrs="attendance/myWorkingHours/";
  static String absentUsers="attendance/getAllTodayAbsentUsers";
  static String presentUsers="attendance/getAllTodayPresentUsers";
  static String todayAttendnace="attendance/getTodayAttendance";
  static String uploadProfile="user/updatePicture";
  static String applyLeave="leave/apply";
}


