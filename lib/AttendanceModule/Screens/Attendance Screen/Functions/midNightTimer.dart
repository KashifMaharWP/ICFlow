import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_application/AttendanceModule/Screens/Attendance%20Screen/Provider/attendanceProvider.dart';

import '../Class/CheckInClass.dart';

class MidNightTimer{
 void MidNightTimerCheck(){
   print("Date Time ${DateFormat("dd MM yyyy").format(DateTime.now())}");
   if(CheckInClass.checkInDate!=DateFormat("dd MM yyyy").format(DateTime.now())){
     CheckInClass.checkInTime='--|--';
     CheckInClass.checkOutTime='--|--';
   }
 }
}