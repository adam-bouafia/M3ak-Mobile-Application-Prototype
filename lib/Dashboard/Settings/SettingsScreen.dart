import 'dart:ffi';
import 'dart:io';

import 'package:audio_background_record/audio_background_record.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Dhayen/Dashboard/Settings/About.dart';
import 'package:Dhayen/Dashboard/Settings/ChangePin.dart';
import 'package:Dhayen/Utility/background_services.dart';
import 'package:easy_folder_picker/FolderPicker.dart';
import 'package:duration_picker_dialog_box/duration_picker_dialog_box.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool switchValue = false;
  bool switchAudioRecord = false;

  void _checks() async {
    await checkService();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _checks();
    }
  }

  Directory selectedDirectory;

  void _selectDirectory(BuildContext context) async {
    Directory directory = selectedDirectory;
    directory ??= Directory(FolderPicker.rootPath);
    Directory newDirectory = await FolderPicker.pick(
      allowFolderCreation: true,
      context: context,
      rootDirectory: directory,
    );
    if (newDirectory.absolute != null) {
      AudioBackgroundRecord.getInstance()
          .configure(savetoDirectory: newDirectory.absolute.path);
    }
    setState(() {
      selectedDirectory = newDirectory;
      //print(selectedDirectory);
    });
  }

  final List locale = [
    {'name': 'English', 'locale': Locale('en', 'US')},
    {'name': 'Arabic', 'locale': Locale('ar', 'AR')},
    {'name': 'Russian', 'locale': Locale('ru', 'RU')},
    {'name': 'Francais', 'locale': Locale('fr', 'FR')},
    {'name': 'Italien', 'locale': Locale('it', 'IT')},
    {'name': 'Deutsch', 'locale': Locale('de', 'DE')},
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  buildLanguageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            title: Text('chln'.tr,
                style: TextStyle(
                  fontFamily: 'metaplusmedium',
                  fontSize: 22,
                )),
            backgroundColor: Color(0xffffffff),
            contentPadding: EdgeInsets.only(
                top: 16.0, bottom: 16.0, left: 16.0, right: 16.0),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Text(locale[index]['name']),
                        onTap: () {
                          print(locale[index]['name']);
                          updateLanguage(locale[index]['locale']);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Color(0xff000000),
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }

  // buildDurationSelectionDialog(BuildContext context){
  //   showDialog(context: context,
  //       builder: (builder){
  //         return AlertDialog(
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(32.0))),
  //           title: Text( "Max Duration",//'chln'.tr,
  //               style: TextStyle(fontFamily: 'metaplusmedium',fontSize: 22,)),
  //           backgroundColor: Color(0xffffffff),
  //           contentPadding: EdgeInsets.only(top: 16.0, bottom: 16.0,left: 16.0,right: 16.0),
  //           content: Container(
  //             width: double.maxFinite,
  //             child: ListView.separated(
  //                 shrinkWrap: true,
  //                 itemBuilder: (context,index){
  //                   return Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: GestureDetector(child: Text(locale[index]['name']),onTap: (){
  //                       print(locale[index]['name']);
  //                       updateLanguage(locale[index]['locale']);
  //                     },),
  //                   );
  //                 }, separatorBuilder: (context,index){
  //               return Divider(
  //                 color: Color(0xff000000),
  //               );
  //             }, itemCount: locale.length
  //             ),
  //           ),
  //         );
  //       }
  //   );
  // }

  Future<int> checkPIN() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int pin = (prefs.getInt('pin') ?? -1111);
    print('User $pin .');
    return pin;
  }

  void checkService() async {
    //bool running = await FlutterBackgroundService().isServiceRunning();
    switchAudioRecord =
        (await SharedPreferences.getInstance()).getBool("bgRecord") ?? false;
    switchValue =
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
    switch (switchValue) {
      case true:
        BackgroundServices.getInstance().startService();

        break;
      case false:
        if (await BackgroundServices.getInstance().isRunning())
          BackgroundServices.getInstance().invoke("stopService");
        break;
    }
  }

  //
  // void controllSafeShake(bool val) async {
  //   Trace ShakeStoppedTimes = FirebasePerformance.instance.newTrace('Shake service Stopped Times trace');
  //   await ShakeStoppedTimes.start();
  //   if (val) {
  //     FlutterBackgroundService.initialize(onStart);
  //   } else {
  //     FlutterBackgroundService().sendData(
  //       {"action": "stopService"},
  //     );
  //   }
  //   await ShakeStoppedTimes.stop();
  // }

  void controllSafeShake(bool val) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool("smsSend", val);
    switch (val) {
      case true:
        BackgroundServices.getInstance().startService();

        break;
      case false:
        if (await BackgroundServices.getInstance().isRunning()) {
          BackgroundServices.getInstance().invoke("stopService");
        }
        break;
    }
  }

  void controlAudioBgRecord(bool val) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool("bgRecord", val);
    switch (val) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFCFE),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              "regl".tr,
              style: TextStyle(
                  fontFamily: 'metaplusmedium',
                  fontSize: 35,
                  fontWeight: FontWeight.w900),
            ),
          ),
          FutureBuilder(
              future: checkPIN(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChangePinScreen(pin: snapshot.data),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      child: Center(
                        child: Image.asset("assets/pin.png"),
                      ),
                    ),
                    title: Text(
                        snapshot.data == -1111 ? "creerpin".tr : "chpin".tr),
                    subtitle: Text("cpreq".tr),
                    trailing: CircleAvatar(
                      radius: 7,
                      backgroundColor:
                          snapshot.data == -1111 ? Colors.red : Colors.white,
                      child: Center(
                        child: Card(
                            color: snapshot.data == -1111
                                ? Colors.orange
                                : Colors.white,
                            shape: CircleBorder(),
                            child: SizedBox(
                              height: 5,
                              width: 5,
                            )),
                      ),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              }),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "noti".tr,
                  style: TextStyle(fontFamily: 'metaplusmedium', fontSize: 20),
                ),
              ),
              Expanded(child: Divider())
            ],
          ),
          ListTile(
            onTap: () {
              buildLanguageDialog(context);
            },
            leading: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Center(
                  child: Image.asset(
                "assets/language.jpg",
                height: 24,
              )),
            ),
            title: Text("langu".tr),
            subtitle: Text("languch".tr),
          ),
          Divider(
            indent: 40,
            endIndent: 40,
          ),
          Divider(
            indent: 40,
            endIndent: 40,
          ),
          SwitchListTile(
            onChanged: (val) {
              setState(() {
                switchValue = val;
                controllSafeShake(val);
              });
            },
            value: switchValue,
            secondary: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Center(
                  child: Image.asset(
                "assets/shake.png",
                height: 24,
              )),
            ),
            title: Text("sfs".tr),
            subtitle: Text("actsf".tr),
          ),
          Divider(
            indent: 40,
            endIndent: 40,
          ),
          SwitchListTile(
            onChanged: (val) {
              setState(() {
                switchAudioRecord = val;
                controlAudioBgRecord(val);
              });
            },
            value: switchAudioRecord,
            secondary: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Center(
                  child: Image.asset(
                "assets/record.png",
                height: 24,
              )),
            ),
            title: Text("Audio Record"),
            //TODO Translation
            subtitle: Text("actsfs".tr),
          ),
          Divider(
            indent: 40,
            endIndent: 40,
          ),
          ListTile(
            trailing: IconButton(
              icon: Icon(Icons.keyboard_arrow_right),
              onPressed: () {
                _selectDirectory(context);
              },
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Center(
                child: Image.asset("assets/directory.png", height: 24),
              ),
            ),
            title: Text("Audio Record directory"), //TODO Translation
            subtitle: Text(
                "change audio record directory where you wish you want:".tr),
          ),
          Divider(
            indent: 40,
            endIndent: 40,
          ),
          ListTile(
            trailing: IconButton(
              icon: Icon(Icons.keyboard_arrow_right),
              onPressed: () async {
                showDurationPicker(
                  context: context,
                  initialDuration: Duration(
                      // minutes: 32,
                      // hours: 23,
                      // seconds: 54,
                      // milliseconds: 23,
                      milliseconds: await AudioBackgroundRecord.getInstance()
                          .getMaxRecordDuration()),
                  durationPickerMode: DurationPickerMode.Hour,
                )?.then((value) async {
                  if (value != null)
                    await AudioBackgroundRecord.getInstance().configure(
                      maxDurationInMillis: value.inMilliseconds,
                    );
                });
              },
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Center(
                child: Image.asset("assets/timer.png", height: 24),
              ),
            ),
            title: Text("Audio Record timer"), //TODO Translation
            subtitle: Text("change audio record time as you wish you want:"),
          ),
          Divider(
            indent: 40,
            endIndent: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              "sfdes".tr,
              style:
                  TextStyle(fontFamily: 'metaplusmedium', color: Colors.grey),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "app".tr,
                  style: TextStyle(fontFamily: 'metaplusmedium', fontSize: 20),
                ),
              ),
              Expanded(child: Divider())
            ],
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AboutUs()));
            },
            title: Text("infon".tr),
            leading: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Center(
                  child: Image.asset(
                "assets/info.png",
                height: 24,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
