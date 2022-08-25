import 'dart:async';
import 'dart:io';

import 'package:background_location/background_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:shake/shake.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';
import 'package:shared_preferences_ios/shared_preferences_ios.dart';
import 'package:telephony/telephony.dart';
import 'package:vibration/vibration.dart';
import 'package:workmanager/workmanager.dart';
import 'package:hardware_buttons/hardware_buttons.dart' as HardwareButtons;



void onStart() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) SharedPreferencesAndroid.registerWith();
  if (Platform.isIOS) SharedPreferencesIOS.registerWith();
  final service = FlutterBackgroundService();
  Location _location;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("onstart services");
  service.onDataReceived.listen((event) async {
    if (event["action"] == "setAsForeground") {
      service.setForegroundMode(true);

      return;
    }

    if (event["action"] == "setAsBackground") {
      service.setForegroundMode(false);
    }

    if (event["action"] == "stopService") {
      service.stopBackgroundService();
    }
  });

  await BackgroundLocation.setAndroidNotification(
    title: "Location tracking is running in the background!",
    message: "You can turn it off from settings menu inside the app",
    icon: '@mipmap/ic_launcher',
  );
  BackgroundLocation.getLocationUpdates((location) {
    _location = location;
    print("location : $location");
    prefs?.setStringList("location",
        [location.latitude.toString(), location.longitude.toString()]);
  });
  BackgroundLocation.startLocationService(
    distanceFilter: 20,
  );

  print("background location notification");

  String screenShake = "Be strong, We are with you!";
  ShakeDetector.autoStart(
      shakeThresholdGravity: 5,
      onPhoneShake: () async {
        print("Test 1");
        if (await Vibration.hasVibrator()) {
          print("Test 2");
          if (await Vibration.hasCustomVibrationsSupport()) {
            print("Test 3");
            Vibration.vibrate(duration: 2000);
          } else {
            print("Test 4");
            Vibration.vibrate();
            await Future.delayed(Duration(milliseconds: 500));
            Vibration.vibrate();
          }
          print("Test 5");
        }
        print("Test 6");
        String link = '';
        print("Test 7");
        try {
          double lat = _location?.latitude;
          double long = _location?.longitude;
          print("$lat ... $long");
          print("Test 9");
          link = "http://maps.google.com/?q=$lat,$long";
          SharedPreferences prefs = await SharedPreferences.getInstance();
          List<String> numbers = prefs.getStringList("numbers") ?? [];
          String error;
          try {
            if (numbers.isEmpty) {
              screenShake = "No contact found, Please call Police ASAP.";
              debugPrint(
                'No Contacts Found!',
              );
              return;
            } else {
              for (int i = 0; i < numbers.length; i++) {
                Telephony.backgroundInstance.sendSms(
                    to: numbers[i],
                    message:
                    "Help Me! Shake mode activated. Track me here.\n$link");
              }
              prefs.setBool("alerted", true);
              screenShake = "SOS alert Sent! Shake mode activated.";
            }
          } on PlatformException catch (e) {
            if (e.code == 'PERMISSION_DENIED') {
              error = 'Please grant permission';
              print('Error due to Denied: $error');
            }
            if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
              error = 'Permission denied- please enable it from app settings';
              print("Error due to not Asking: $error");
            }
          }
          print("Test 10");
          print(link);
        } catch (e) {
          print("Test 11");
          print(e);
        }
      });
  print("Test 12");

  service.setForegroundMode(true);

  Timer.periodic(Duration(seconds: 1), (timer) async {
    if (!(await service.isServiceRunning())) timer.cancel();

    service.setNotificationInfo(
      title: "Safe Shake activated!",
      content: screenShake,
    );

    service.sendData(
      {"current_date": DateTime.now().toIso8601String()},
    );
  });
}

const simplePeriodicTask = "simplePeriodicTask";
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    String contact = inputData['contact'];
    final prefs = await SharedPreferences.getInstance();
    print(contact);
    List<String> location = prefs.getStringList("location");
    String link = "http://maps.google.com/?q=${location[0]},${location[1]}";
    print(location);
    print(link);
    Telephony.backgroundInstance.sendSms(
        to: contact, message: "I am on my way! every 15 Track me here.\n$link");
    return Future.value(true);
  });
}
