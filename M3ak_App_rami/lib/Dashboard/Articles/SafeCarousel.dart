import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m3ak_app/Dashboard/Articles/ArticleDesc.dart';
import 'package:m3ak_app/Dashboard/Articles/SadeWebView.dart';
import 'package:m3ak_app/Utility/constants.dart';

class SafeCarousel extends StatelessWidget {
  const SafeCarousel({Key key}) : super(key: key);

  void navigateToRoute(
    BuildContext context,
    Widget route,
  ) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => route,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
        ),
        items: List.generate(
            imageSliders.length,
            (index) => Hero(
                  tag: articleTitle[index],
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(
                      onTap: () {
                        if (index == 0) {
                          navigateToRoute(
                              context,
                              SafeWebView(
                                  index: index,
                                  title: "A return to the police state in Tunisia ?",
                                  url: "https://nawaat.org/2021/02/09/a-return-to-the-police-state-in-tunisia"));
                        } else if (index == 1) {
                          navigateToRoute(
                              context,
                              SafeWebView(
                                  index: index,
                                  title: "School pupils fall victims of insecurity, after the coup in Tunisia",
                                  url: "https://www.alestiklal.net/en/view/10432/school-pupils-fall-victims-of-insecurity-after-the-coup-in-tunisia"));
                        } else if (index == 2) {
                          navigateToRoute(
                              context, ArticleDesc(index: index));
                        } else if (index == 3) {
                          navigateToRoute(
                              context,
                              SafeWebView(
                                  index: index,
                                  title: "Tunisia: Concern over increase in violent crime rate",
                                  url: "https://www.middleeastmonitor.com/20201013-tunisia-concern-over-increase-in-violent-crime-rate"));
                        }  else {
                          navigateToRoute(
                              context,
                              SafeWebView(
                                  index: index,
                                  title: "Ten years after the Jasmine Revolution, it's time for the Tunisian garden to bloom again",
                                  url: "https://www.undp.org/blog/ten-years-after-jasmine-revolution-its-time-tunisian-garden-bloom-again"));
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(imageSliders[index]),
                              fit: BoxFit.cover),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(0.5),
                                    Colors.transparent
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight)),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 8),
                              child: Text(
                                articleTitle[index],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
      ),
    );
  }
}
