import 'package:flutter/material.dart';
import 'package:Dhayen/Utility/constants.dart';

class ArticleDesc extends StatelessWidget {
  const ArticleDesc({Key key, this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[200],
              backgroundImage: NetworkImage(imageSliders[index]),
            ),
            title: Text(
              "Daily Life",
              style: TextStyle(fontFamily: 'metaplusmedium',color: Colors.grey[600], fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Protecting each other at work in markets",
              style: TextStyle(fontFamily: 'metaplusmedium',fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[100],
              child: Center(
                child: Image.asset("assets/un.png"),
              ),
            ),
            title: Text("UN WOMEN"),
          ),
          ArticleImage(
              imageStr:
                  "https://th.bing.com/th/id/R.7c4b7b897ee9f0e7bd67acbb7f26d1b7?rik=R1Me8O2B%2f7PYZA&pid=ImgRaw&r=0"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(articles[0][0]),
          ),
          ArticleImage(
              imageStr:
                  "https://cdn.travelsafe-abroad.com/wp-content/uploads/Tunisia-4.jpg"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(articles[0][1]),
          ),
        ],
      ),
    );
  }
}

class ArticleImage extends StatelessWidget {
  const ArticleImage({Key key, this.imageStr}) : super(key: key);

  final String imageStr;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width - 20,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: NetworkImage(
                  imageStr,
                ),
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
