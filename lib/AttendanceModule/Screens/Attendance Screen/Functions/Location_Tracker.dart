/*


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
*/



import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:device_info_plus/device_info_plus.dart'; // For checking device info
import 'package:taskflow_application/AttendanceModule/Utills/Global%20Functions/SnackBar.dart';

import '../Provider/attendanceProvider.dart';

// Function to detect if the location is mocked (fake)
bool isMockLocation(Position position) {
  return position.isMocked ?? false;
}

// Function to check if mock locations are enabled (Android)
Future<bool> isMockLocationEnabled() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

  // Mock location detection through system APIs
  // This checks if the device allows mock locations
  return androidInfo.isPhysicalDevice == false || androidInfo.hardware.contains('goldfish') || androidInfo.fingerprint.contains('generic');
}

Future<void> getCurrentLocationCheckInTime(BuildContext context) async {
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    log("Location Denied");
    LocationPermission ask = await Geolocator.requestPermission();
  } else {
    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print("Location Not Accessed Yet");

    // Check if the location is mocked (fake GPS)
    if (isMockLocation(currentPosition)) {
      log("Mock location detected. Attendance denied.");
      showErrorSnackbar("Your Fetching Location through Emulator", context);
      // Show error message to the user or block attendance
      return;
    }

    // Check if Mock Locations are enabled (another layer of protection)
    if (await isMockLocationEnabled()) {
      log("Device likely using mock location or is an emulator.");
      showErrorSnackbar("Your Fetching Location through Emulator", context);
      // Show error message to the user or block attendance
      return;
    }

    final atdProvider = Provider.of<AttendanceProvider>(context, listen: false);
    await atdProvider.AddCheckIn(currentPosition.latitude, currentPosition.longitude, context);
    print("Location Accessed");
  }
}

Future<void> getCurrentLocationCheckOutTime(BuildContext context) async {
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    log("Location Denied");
    LocationPermission ask = await Geolocator.requestPermission();
  } else {
    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Check if the location is mocked (fake GPS)
    if (isMockLocation(currentPosition)) {
      log("Mock location detected. Attendance denied.");
      showErrorSnackbar("Your Fetching Location through Emulator", context);
      // Show error message to the user or block attendance
      return;
    }

    // Check if Mock Locations are enabled
    if (await isMockLocationEnabled()) {
      log("Device likely using mock location or is an emulator.");

      showErrorSnackbar("Your Fetching Location through Emulator", context);
      // Show error message to the user or block attendance
      return;
    }
    else{

    }

    final atdProvider = Provider.of<AttendanceProvider>(context, listen: false);
    atdProvider.AddCheckOut(currentPosition.latitude, currentPosition.longitude, context);
  }
}

