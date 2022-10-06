import 'dart:async';
import 'package:Dhayen/Utility/localeString.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Dhayen/Utility/background_services.dart';
import 'package:workmanager/workmanager.dart';
import 'package:Dhayen/Dashboard/Dashboard.dart';
import 'onboarding/onboarding_screen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterBackgroundService.initialize(onStart);
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
    if (!result) {
      prefs.setBool("appOpenedBefore", true);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      translations: LocaleString(),
      locale: Locale('fr','FR'),
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
               return Dashboard();//Dashboard
              } else {
               return OnboardingScreen();
               }
             } else {
               return Container(
               color: Colors.transparent,
               );
             }
          }
          ),
    );
  }
}
