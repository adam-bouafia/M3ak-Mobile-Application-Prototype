import 'package:flutter/material.dart';
import 'package:Dhayen/Dashboard/Settings/AboutCard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key key}) : super(key: key);
  _launchURL() async {
    const url = 'https://www.efi-ife.org/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  showLicences(context) {
    showAboutDialog(
        context: context,
        applicationVersion: "1.0.0",
        applicationIcon: Image.asset(
          "assets/logoss.png",
          height: 50,
        ),
        applicationName: "Dhayen",
        applicationLegalese:
            "Dhayen fournit une solution aux problèmes de la communauté, une application entièrement conviviale et un besoin de l'heure, visant à vous connecter à ceux qui s'occupent de vous!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF7FA),
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "propos".tr,
              style: TextStyle(fontFamily: 'metaplusmedium',color: Colors.black, fontSize: 26),
            ),
            SizedBox(
              width: 10,
            ),
        GestureDetector(
          onTap: _launchURL,
            child: Image.asset(
              "assets/information.png",
              height: 26,
            )
        ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
        ),
      ),
      body: ListView(
        children: [
          AboutCard(
            desc:
                "Dhayen est une application mobile vigilante qui permet à l'utilisateur de rester connecté avec ceux qui s'en soucient ! Il donne à l'utilisateur la possibilité de partager l'emplacement en direct avec les personnes concernées via des alertes SOS et permet à l'utilisateur d'accéder aux services d'urgence. Soyez témoin de l'incident malheureux qui se produit et appelez à l'aide. C'est votre compagnon personnel.",
            subtitle: "Vous méritez la sécurité!",
            title: "Dhayen",
            sizeFactor: 1.8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: ListTile(
                  onTap: () {
                    showLicences(context);
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    child: Center(
                      child: Image.asset("assets/card.png", height: 30),
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                  title: Text("lcs".tr)),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Expanded(
                child: Divider(
                  indent: 10,
                  endIndent: 10,
                ),
              ),
              Text("drt".tr),
              Expanded(
                child: Divider(
                  indent: 10,
                  endIndent: 10,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
