import 'dart:async';
import 'package:Dhayen/Utility/localeString.dart';
import 'package:audio_background_record/audio_background_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:shake/shake.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Dhayen/Utility/background_services.dart';
import 'package:vibration/vibration.dart';
import 'package:workmanager/workmanager.dart';
import 'package:Dhayen/Dashboard/Dashboard.dart';
import 'onboarding/onboarding_screen.dart';
import 'package:get/get.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  BackgroundServices.checkService() ;

  ShakeDetector.autoStart(
      shakeThresholdGravity: 5,
      onPhoneShake: () async {
        var prefs = await SharedPreferences.getInstance();
        await prefs.reload();
        bool sendSmsOption = prefs.getBool("smsSend") ?? false;
        bool audioRecordOption = (prefs.getBool("bgRecord") ?? false);
        //Vibration feedback for shaking the phone
        if (sendSmsOption || audioRecordOption) {
          if (await Vibration.hasVibrator()) {
            if (await Vibration.hasCustomVibrationsSupport()) {
              Vibration.vibrate(duration: 2000);
            } else {
              Vibration.vibrate();
              await Future.delayed(Duration(milliseconds: 500));
              Vibration.vibrate();
            }
          }
        }

        //sms send config
        String link = '';
        //if (sms send is enabled in the shared preference , then perceed with the following routine
        if (sendSmsOption) {
          BackgroundServices.sendSms();
        } else {
          print("sms send fonctionality is desactivated");
        }

        var isServiceStarted = await AudioBackgroundRecord.getInstance()
            .isRecordingServiceRunning();
        var isRecording =
            await AudioBackgroundRecord.getInstance().isRecording();
        if (isServiceStarted) {
          if (isRecording == false) {
            if (audioRecordOption == true) {
              AudioBackgroundRecord.getInstance().startRecording();
              print("bg recording is activated");
            } else {
              print("bg recording is deactivated");
            }
          } else {
            AudioBackgroundRecord.getInstance().stopRecording();
          }
        }
        //AudioBackgroundRecord.getInstance().configure(savetoDirectory: path);
      });


  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false,
  );

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  Future<bool> isAppOpeningForFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = prefs.getBool("appOpenedBefore") ?? false;
    // if (!result) {
    //   prefs.setBool("appOpenedBefore", true);
    // }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LocaleString(),
      locale: Locale('fr', 'FR'),
      debugShowCheckedModeBanner: false,
      title: 'Dhayen',
      theme: ThemeData(
        fontFamily: 'metaplusmedium',
        //primarySwatch: Colors.kPrimaryColor,
        //primarySwatch: Colors.red,
      ),
      home: FutureBuilder(
          future: isAppOpeningForFirstTime(),
          builder: (context, AsyncSnapshot<bool> snap) {
            if (snap.hasData) {
              if (snap.data) {
                return Dashboard(); //Dashboard
              } else {
                return OnboardingScreen();
              }
            } else {
              return Container(
                color: Colors.transparent,
              );
            }
          }),
    );
  }
}
