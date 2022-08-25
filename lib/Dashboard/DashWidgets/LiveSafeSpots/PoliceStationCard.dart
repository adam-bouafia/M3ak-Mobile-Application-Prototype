import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PoliceStationCard extends StatelessWidget {
  const PoliceStationCard({Key key, this.openMapFunc}) : super(key: key);

  final Function openMapFunc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: (){
                openMapFunc("Postes de police à proximité");
              },
              child: Container(
                  height: 50,
                  width: 50,
                  child: Center(
                      child: Image.asset(
                    "assets/police.png",
                    height: 32,
                  ))),
            ),
          ),
          Text("pol".tr)
        ],
      ),
    );
  }
}
