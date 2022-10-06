import 'package:flutter/material.dart';

class AboutCard extends StatelessWidget {
  AboutCard(
      {Key key,
      this.asset,
      this.desc,
      this.subtitle,
      this.title,
      this.sizeFactor})
      : super(key: key);

  final String asset;
  final String desc;
  final double sizeFactor;
  final String subtitle;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / sizeFactor,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width - 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    ListTile(
                      title: Text(
                        title,
                        style: TextStyle(fontFamily: 'metaplusmedium',
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      subtitle: Text(subtitle),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        desc,
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Center(
                  child: Image.asset(
                "assets/logoss.png",
                height: 85,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
