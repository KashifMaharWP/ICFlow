import 'package:provider/provider.dart';

class CountWeekDays{
 static int CountWorkDays(){
   int workingDays=0;
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth=DateTime(now.year,now.month,1);
    DateTime lastDayOfMonth=DateTime(now.year,now.month+1,0);
    print(now.day);
    print(now.weekday);
    for(int i=0; i<lastDayOfMonth.day; i++){
      DateTime day = firstDayOfMonth.add(Duration(days: i));
      if(day.weekday>=DateTime.monday&&day.weekday<=DateTime.friday){
        workingDays++;
      }
    }
    return workingDays;
    //print("Total Weeks"+totalWeekDays.toString());
  }

}