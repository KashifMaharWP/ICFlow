

import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../Provider/attendanceProvider.dart';

  Future<void> getCurrentLocationCheckInTime(BuildContext context) async {
    //print("Current Location Function is Called");
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      log("Location Denied");
      LocationPermission ask = await Geolocator.requestPermission();
    }
    else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      print("Location Not Accessed Yet");
      final atdProvider = Provider.of<AttendanceProvider>(context, listen: false);
      await atdProvider.AddCheckIn(currentPosition.latitude, currentPosition.longitude,context);
      print("Location Accessed");
    }
  }

  getCurrentLocationCheckOutTime(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      log("Location Denied");

      LocationPermission ask = await Geolocator.requestPermission();
    }
    else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      final atdProvider = Provider.of<AttendanceProvider>(context, listen: false);
      atdProvider.AddCheckOut(currentPosition.latitude, currentPosition.longitude,context);
    }
  }
