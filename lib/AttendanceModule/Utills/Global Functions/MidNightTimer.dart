import 'package:intl/intl.dart';

import '../../Screens/Attendance Screen/Class/CheckInClass.dart';

void startMidnightTimer() {
  DateTime now = DateTime.now();
  print("MidNight Timer");
  if (now == CheckInClass.checkInDate ) {
    CheckInClass.checkInTime='--|--';
  }

}