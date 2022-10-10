import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:audio_background_record/audio_background_record.dart';
import 'package:background_location/background_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shake/shake.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';
import 'package:shared_preferences_ios/shared_preferences_ios.dart';
import 'package:telephony/telephony.dart';
import 'package:vibration/vibration.dart';
import 'package:workmanager/workmanager.dart';

class BackgroundServices {
  BackgroundServices._() {}
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static const simplePeriodicTask = "simplePeriodicTask";


  static const String smsNotificationChannelID = "BG_SMS_SEND_SERVICE";
  static const int smsNotificationID = 888;
  static const  _smsNotificationDetails =  NotificationDetails(
      android:  AndroidNotificationDetails(
          smsNotificationChannelID, smsNotificationChannelID,
          channelDescription: 'a service channel dedicated the Dahyen app',
          icon: "ic_bg_service_small"));

  static showSmsNotification({String title, String content}) {
    _flutterLocalNotificationsPlugin.show(
        smsNotificationID, title, content, _smsNotificationDetails);
  }
  static cancelSmsNotification(){
    _flutterLocalNotificationsPlugin.cancel(smsNotificationID);
  }

  static const String audioRecordNotificationChannelID = "BG_AUDIO_RECORD_SERVICE";
  static const int audioRecordNotificationID = 555;
  static const  _audioRecordNotificationDetails =  NotificationDetails(
      android:  AndroidNotificationDetails(
          audioRecordNotificationChannelID, audioRecordNotificationChannelID,
          channelDescription: 'a service channel dedicated the Dahyen app to record audio',
          icon: "ic_bg_service_small"));

  static showAudioRecordNotification({String title, String content}) {
    _flutterLocalNotificationsPlugin.show(
        audioRecordNotificationID, title, content, _audioRecordNotificationDetails);
  }
  static cancelaudioRecordNotification(){
    _flutterLocalNotificationsPlugin.cancel(audioRecordNotificationID);
  }

  static Location _location;
  static void sendSms() async{
    String screenShake = "Be strong, We are with you!";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      double lat = _location?.latitude;
      double long = _location?.longitude;
      String link = "http://maps.google.com/?q=$lat,$long";
      List<String> numbers = prefs.getStringList("numbers") ?? [];
      String error;
      try {
        if (numbers.isEmpty) {
          screenShake = "No contact found, Please call Police ASAP.";
          debugPrint(
            'No Contacts Found!',
          );

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
        //TODO translation
        BackgroundServices.showSmsNotification(
          title: "Safe Shake activated!",
          content: screenShake,);
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
    } catch (e) {
      print(e);
    }
  }


  static void audioRecordCallBack(int status, String errorMsg) {
  switch (status) {
  case 1 /*recording started*/:
  BackgroundServices.showAudioRecordNotification(
  title: "Audio Recording",
  content: "Audio Recording Started");
  break;
  case 2 /*recording stopped*/:
  BackgroundServices.showAudioRecordNotification(
  title: "Audio Recording",
  content: "Audio Recording Stopped, Ready to record again");
  break;
  case 0 /*recording error*/:
  print("error : $errorMsg");
  break;
  }
  }

  static void checkService() async {
    //bool running = await FlutterBackgroundService().isServiceRunning();
    bool switchAudioRecord =
        (await SharedPreferences.getInstance()).getBool("bgRecord") ?? false;
    bool switchSmsSend =
        (await SharedPreferences.getInstance()).getBool("smsSend") ?? false;

    switch (switchAudioRecord) {
      case true:
        AudioBackgroundRecord.getInstance()
          ..startRecordingService()
          ..setOnRecordStatusChangedCallback(
              BackgroundServices.audioRecordCallBack);
        BackgroundServices.showAudioRecordNotification(
            title: "Audio Recording",
            content: "Audio Recording service is ready");
        break;
      case false:
        AudioBackgroundRecord.getInstance().stopRecordingService();
        BackgroundServices.cancelaudioRecordNotification();
        break;
    }
    switch (switchSmsSend) {
      case true:
        //TODO translate
        BackgroundServices.showSmsNotification(
          title: "Safe Shake activated!",
          content: "Be strong, We are with you!",);

        BackgroundLocation.getLocationUpdates(_updateLocation);
        BackgroundLocation.startLocationService(
          distanceFilter: 20,
        );

        break;
      case false:
        BackgroundServices.cancelSmsNotification();
        BackgroundLocation.stopLocationService();
        break;
    }
  }

  static void _updateLocation(Location location){
    _location = location;
    print("location : $location");

  }
}


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
        to: contact, message: "I am on my way! every 15 Track me here.\n$link"
        //message: "${'changelang'.tr}\n$link"
        );
    return Future.value(true);
  });
}
