import 'package:flutter/material.dart';
import 'package:m3ak_app/Dashboard/DashWidgets/LiveSafeSpots/BusStationCard.dart';
import 'package:m3ak_app/Dashboard/DashWidgets/LiveSafeSpots/HospitalCard.dart';
import 'package:m3ak_app/Dashboard/DashWidgets/LiveSafeSpots/PharmacyCard.dart';
import 'package:m3ak_app/Dashboard/DashWidgets/LiveSafeSpots/PoliceStationCard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LiveSafe extends StatelessWidget {
  const LiveSafe({Key key}) : super(key: key);

  static Future<void> openMap(String location) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$location';

    try {
      await launch(googleUrl);
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: "Something went wrong! Call emergency numbers.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      child: ListView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          children: [
            PoliceStationCard(openMapFunc: openMap),
            HospitalCard(openMapFunc: openMap),
            PharmacyCard(openMapFunc: openMap),
            BusStationCard(openMapFunc: openMap)
          ]),
    );
  }
}
